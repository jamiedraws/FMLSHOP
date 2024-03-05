// components
import Carousel from "Shared/ts/components/carousel";
import Accordion from "Shared/ts/components/accordion";

// adapters
import SlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/slide-carousel";

// observers
import { observer } from "Shared/ts/observers/intersection";

// utils
import Disclosure from "Shared/ts/utils/disclosure";

// applications
import {
    initializeBase,
    initializeMicrosite
} from "Shared/ts/applications/template";
import {
    initializeExpressCheckout,
    initializeModalDialogIframe,
    initializeValidateCommon
} from "Shared/ts/applications/form";
import { initializeNavById } from "Shared/ts/applications/navigation";
import { initializeDocumentModalDialogsByTemplates } from "Shared/ts/applications/modal-dialog";
import { IValidateCommonErrorResponse } from "Shared/ts/interfaces/validate/validate-common";
import { ICartChange } from "Shared/ts/interfaces/cart-change";

const nav = initializeNavById("nav");

initializeBase();
initializeMicrosite();
initializeModalDialogIframe();

const validateCommon = initializeValidateCommon();
initializeExpressCheckout();

const subscriptionDisclosure = new Disclosure(
    document.querySelector(`form[action^="/FMLSHOP/"] > .element-controller`)
);

const controllers = subscriptionDisclosure.controllers as HTMLInputElement[];

const hasSubscriptionOffer = (): boolean => {
    return controllers.some((controller) => controller.checked);
};

window.addEventListener("CartChange", (event: CustomEvent<ICartChange>) => {
    hasSubscriptionOffer()
        ? subscriptionDisclosure.addControllerState(controllers[0])
        : subscriptionDisclosure.removeControllerState(controllers[0]);
});

window.onFormPostValidation = (
    event: Event
): IValidateCommonErrorResponse[] => {
    const errors: IValidateCommonErrorResponse[] = [];

    const terms = validateCommon?.inputs.find((input) => input.id === "Terms");
    if (!terms) return errors;

    if (!terms.checked) {
        const message =
            document.querySelector("#terms-error-message")?.textContent ??
            "Please read and accept the Terms and Conditions and Arbitration Agreement.";

        errors.push({
            element: $(terms),
            message
        });
    }

    if (hasSubscriptionOffer()) {
        const subscriptionCheckbox = validateCommon?.inputs.find(
            (input) => input.id === "subscriptionCbx"
        );
        if (!subscriptionCheckbox) return errors;

        if (!subscriptionCheckbox.checked) {
            const message =
                document
                    .querySelector("#subscriptionCbx-error-message")
                    ?.textContent?.trim() ??
                "Please accept the Subscribe and Save terms.";

            errors.push({
                element: $(subscriptionCheckbox),
                message
            });
        }
    }

    return errors;
};

initializeDocumentModalDialogsByTemplates();

observer(".slide--carousel", {
    inRange: (element) => {
        const carousel = new Carousel(new SlideCarouselAdapter(element));

        carousel.enablePrevNextControls();
    }
});

observer(".accordion", {
    inRange: (element) => new Accordion(element)
});
