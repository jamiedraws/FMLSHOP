// api
import ExpressCheckout from "Shared/ts/api/express-checkout/express-checkout";

// applications
import {
    initializeValidateCommonWithBraintree,
    initializeValidateEvent,
    validatePromoCode
} from "Shared/ts/applications/form";
import StatusScreen from "Shared/ts/components/status-screen";

// observers
import { observer } from "Shared/ts/observers/intersection";

// utils
import ValidateEvent from "Shared/ts/utils/validate-event";

const validateCommonWhenAvailable = () => {
    const form = document.querySelector<HTMLFormElement>(
        "[data-validate-common-form]"
    );
    if (!form) return;

    initializeValidateCommonWithBraintree(form);
};

validateCommonWhenAvailable();

const validateInputRules = (control: HTMLInputElement) => {
    const isValid = control.validity.valid;
    if (!isValid) return false;

    const isEmpty = control.value === "";
    if (isEmpty) return false;

    const pattern = control.getAttribute("data-pattern");

    if (pattern) {
        const regex = new RegExp(pattern);
        const hasValidPattern = regex.test(control.value);

        return hasValidPattern;
    }

    return true;
};

const validateComboboxRules = (control: HTMLSelectElement) => {
    return control.validity.valid;
};

const initializeValidateSearchForm = () => {
    const form = document.querySelector<HTMLFormElement>(
        'form[action^="/Search"]'
    );
    if (!form) return;

    const submit = form.querySelector<HTMLButtonElement>(
        'button[type="submit"]'
    );
    if (!submit) return;

    const validateSearchForm = new ValidateEvent({
        form,
        submit,
        invalidInputEvents: ["keyup", "blur", "change"]
    });

    validateSearchForm.submit?.addEventListener("click", (event) =>
        validateSearchForm.validateAll()
    );

    validateSearchForm.processInputEvents();

    validateSearchForm.submit?.addEventListener("click", (event) =>
        validateSearchForm.validateAll()
    );

    const text = validateSearchForm.inputs.find((input) => input.id === "text");
    if (!text) return;

    const textS = validateSearchForm.inputs.find(
        (input) => input.id === "textS"
    );
    if (!textS) return;

    textS.addEventListener("keyup", (event) => (text.value = textS.value));

    validateSearchForm.submit?.addEventListener(
        "submit",
        (event) => text.value.replace(/^\s+|\s+$/, "").length !== 0
    );
};

initializeValidateSearchForm();

const initializeProductDetailPageValidation = () => {
    const form = document.querySelector<HTMLFormElement>("form.product__info");
    if (!form) return;

    const termsCheckbox = form.querySelector<HTMLInputElement>(
        "input[type=checkbox][id^=terms-][id$=-PDP]"
    );
    if (!termsCheckbox) return;

    const productCode = termsCheckbox.getAttribute("data-product-code");
    if (!productCode) return;

    const subscribeOption = form.querySelector<HTMLInputElement>(
        `input[type="radio"][value="${productCode}"]`
    );
    if (!subscribeOption) return;

    const addCartId = termsCheckbox.getAttribute("aria-controls");
    if (!addCartId) return;

    const addCartButton = form.querySelector<HTMLButtonElement>(
        `button#${addCartId}`
    );
    if (!addCartButton) return;

    const validateCondition = () => {
        termsCheckbox.checked && subscribeOption.checked
            ? addCartButton.removeAttribute("disabled")
            : addCartButton.setAttribute("disabled", "true");
    };

    termsCheckbox.addEventListener("click", (event) => {
        validateCondition();

        if (termsCheckbox.checked) return;
        window.handleCartChange(subscribeOption.value, 0);
    });

    subscribeOption.addEventListener("change", validateCondition);

    const ve = initializeValidateEvent(form, addCartButton, "required");

    addCartButton.addEventListener("mouseover", (event) => ve.validateAll());
};

initializeProductDetailPageValidation();

observer("[data-validate-form]", {
    inRange: (element) => {
        const validateMessage = new ValidateEvent({
            form: element as HTMLFormElement,
            submit: element.querySelector(
                `[data-validate-form-type="submit"]`
            ) as HTMLButtonElement,
            attribute: "data-required",
            inputEvents: ["blur", "change"],
            invalidInputEvents: ["keyup", "blur", "change"],
            comboboxEvents: ["change", "blur"]
        });

        validateMessage.validateInputEvent = (event: Event) => {
            validateMessage.validateControl(
                event.target as HTMLInputElement,
                validateInputRules
            );
        };

        validateMessage.validateComboboxEvent = (event: Event) => {
            validateMessage.validateControl(
                event.target as HTMLSelectElement,
                validateComboboxRules
            );
        };

        validateMessage.submit?.addEventListener("click", (event: Event) => {
            validateMessage.validateInputs(validateInputRules);
            validateMessage.validateComboboxes(validateComboboxRules);
        });

        validateMessage.processInputEvents();
        validateMessage.processComboboxEvents();
    }
});

addEventListener("ECDrawFormComplete", (event) => {
    const checkout: HTMLElement | null = document.querySelector(
        "[data-validate-common-form]"
    );
    if (!checkout) return;

    const ec = new ExpressCheckout(checkout);
    ec.createCheckoutButtonGUI();
});

const validatePromoCodeAroundStatusScreen = (): void => {
    const form = document.querySelector<HTMLFormElement>(
        "[data-validate-promo-code]"
    );
    if (!form) return;

    const statusContainer = document.querySelector<HTMLElement>(
        "#promo-code-validation-status"
    );
    if (!statusContainer) return;

    const statusScreen = new StatusScreen("inline", statusContainer);
    let wasValidated = false;
    let capturePromoCode: string | undefined;

    const validateEvent = initializeValidateEvent(
        form,
        form.querySelector('button[type="button"]') as HTMLButtonElement
    );

    const input = validateEvent.inputs.find(
        (input) => input.id === "promoCode"
    );

    input?.addEventListener("keyup", (event) => {
        if (wasValidated) {
            wasValidated = false;
            statusScreen.close();
        }

        capturePromoCode && input.value === capturePromoCode
            ? statusScreen.open()
            : statusScreen.close();
    });

    validateEvent.submit?.addEventListener("click", (event) => {
        validateEvent.validateInputs(validateInputRules);

        if (validateEvent.isValidForm()) {
            statusScreen.busy("Checking...");
        }
    });

    validatePromoCode()
        .pass((promoCode) => {
            statusScreen.done(`Code ${promoCode} was successfully redeemed.`);
        })
        .fail((error) => {
            statusScreen.problem(error);
        })
        .finally(() => {
            capturePromoCode = input?.value;
            wasValidated = true;
        });
};

validatePromoCodeAroundStatusScreen();
