import {
    convertFragmentToHTMLElement,
    renderTemplate
} from "Shared/ts/utils/html";

export default class IngredientViewer {
    public controllers: HTMLButtonElement[] = [];

    constructor() {
        this.controllers = Array.from<HTMLButtonElement>(
            document.querySelectorAll(
                `button[type="button"][data-ingredient-id][data-ingredient-name]`
            )
        );

        IngredientViewer.initializeControllersByContext(this);
    }

    private static initializeControllersByContext(
        context: IngredientViewer
    ): void {
        const observer = new IntersectionObserver((entries) => {
            entries.forEach((entry) => {
                if (!entry.isIntersecting) return;

                const controller = entry.target as HTMLButtonElement;

                this.initializeViewByController(controller);

                observer.unobserve(controller);
            });
        });

        context.controllers.forEach((controller) =>
            observer.observe(controller)
        );
    }

    private static initializeViewByController(
        controller: HTMLButtonElement
    ): void {
        this.requestIngredientViewByController(controller)
            .then((element) => {
                const candidates = (
                    controller.getAttribute("aria-controls") ?? ""
                )
                    .split(" ")
                    .filter((id) => id !== "")
                    .map((id) => document.getElementById(id))
                    .filter((candidate) => candidate !== null) as HTMLElement[];

                if (candidates.length === 0) {
                    document.body.append(element);

                    return;
                }

                candidates.forEach((candidate) => {
                    candidate.append(element);
                });
            })
            .catch((error) => console.debug(error));
    }

    private static async requestIngredientViewByController(
        controller: HTMLButtonElement
    ): Promise<Element> {
        const id = controller.getAttribute("data-ingredient-id");
        const name = controller.getAttribute("data-ingredient-name");

        if (!id) {
            throw {
                message: `The HTML attribute for [data-ingredient-id] was blank for the current controller.`,
                controller
            };
        }

        if (!name) {
            throw {
                message: `The HTML attribute for the [data-ingredient-name] was blank for the current controller.`,
                controller
            };
        }

        const request = await fetch(`/Ingredients/${name}?cver=${id}`, {
            method: "GET",
            headers: {
                PermissionKey: id
            }
        });

        if (request.status !== 200) {
            throw {
                message: `The HTTP request did not succeed for the current controller.`,
                controller
            };
        }

        if (request.redirected) {
            throw {
                message: `The HTTP request did not satisfy the requisites for the current controller.`,
                controller
            };
        }

        const response = await request.text();
        const text = response.trim();

        if (text === "") {
            throw {
                message: `The HTTP response did not return an HTML body for the current controller.`,
                controller
            };
        }

        const fragment = renderTemplate(text);
        const element = convertFragmentToHTMLElement(fragment);

        if (!element) {
            throw {
                message: `The HTTP response did not return an HTML body for the current controller.`,
                controller
            };
        }

        return element;
    }
}
