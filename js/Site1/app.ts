// applications
import {
    initalizeDocumentModalDialogsByDOMMutation,
    initializeDocumentModalDialogsByContainers,
    initializeDocumentModalDialogsByControllers,
    initializeDocumentModalDialogsByTemplates
} from "Shared/ts/applications/modal-dialog";
import {
    initializeReviewTableUI,
    initializeFlyoutUI,
    initializeVariantProductControllersUI,
    pubsub,
    initializeKlaviyoSignUpFormUI,
    initializeModalDialogUI
} from "Shared/ts/applications/delay-input";
import {
    initializeFlyoutsThenNav,
    initializeGlobalFlyoutRepository
} from "Shared/ts/applications/navigation";
import { initializeBase } from "Shared/ts/applications/template";

// observers
import { observer } from "Shared/ts/observers/intersection";
import MediaQuery from "Shared/ts/observers/media-query";

// utils
import ElementController from "Shared/ts/utils/element-controller";
import KlaviyoSignUpForm from "Shared/ts/utils/klaviyo-signup-form";
import { initializeGlobalHTMLTemplateRenderingEngine } from "Shared/ts/utils/html-template-rendering-engine";
import ShoppingCart from "Shared/ts/utils/shopping-cart";
import VariantProductController from "Shared/ts/utils/variant-product-controller";
import OrderFormReviewTable from "Shared/ts/utils/order-form-review-table";
import CaptureElement from "Shared/ts/utils/capture-element";
import CustomerProfile from "ts/utils/customer-profile";
import { setElementAttributes } from "Shared/ts/utils/html";
import VimeoManager from "Shared/ts/utils/vimeo-manager";

// api
import InstagramMediaDTMAdapter from "Shared/ts/api/instagram/instagram-media-dtm-adapter";
import FadeSlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/fade-slide-carousel";
import ModalDialogVimeoIframe from "Shared/ts/api/modal/modal-dialog-vimeo-iframe";

// components
import Accordion from "Shared/ts/components/accordion";
import Carousel from "Shared/ts/components/carousel";
import ResponsiveCarousel from "Shared/ts/components/responsive-carousel";
import CustomerCart from "Shared/ts/components/customer-cart";
import ToolTip from "Shared/ts/components/tooltip";
import VimeoCarousel from "Shared/ts/components/vimeo-carousel";
import FadeCarouselWithPictureVimeoAnimation from "ts/components/fade-carousel-with-picture-vimeo-animation";
import IngredientViewer from "ts/components/ingredient-viewer";
import FadeCarousel from "Shared/ts/components/fade-carousel";

// adapters
import SlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/slide-carousel";
import ResponsiveSlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/responsive-slide-carousel";
import VimeoSlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/vimeo-slide-carousel";
import { initializeKlaviyoWaitlist } from "Shared/ts/applications/klaviyo";

// interfaces
import { ICartChange, IProduct } from "Shared/ts/interfaces/cart-change";
import { ICustomerCartProductItemSubscription } from "Shared/ts/interfaces/customer-cart";

initializeDocumentModalDialogsByContainers();
initializeDocumentModalDialogsByControllers();
initializeDocumentModalDialogsByTemplates();

const excludeProductsFromCartCount = (products: IProduct[]) => {
    return products.filter(
        (product) =>
            !product.props.find((prop) => prop.Key === "ExcludeFromCartCount")
    );
};

const customerCart = new CustomerCart("customer-cart");

customerCart.filterProductsArray((products: IProduct[]) => {
    products
        .filter((product) => product.price < 0)
        .forEach((product) => {
            product.priceC = `-${product.priceC.replace(/\(|\)/g, "")}`;
        });

    products
        .filter((product) =>
            product.props.find((prop) => prop.Key === "NoEdit")
        )
        .forEach((product) => {
            const value = product.props["NoEdit"];
            product.props["NoEdit"] = value.toLowerCase();
        });

    return excludeProductsFromCartCount(products).sort(
        (productA, productB) => productA.rank - productB.rank
    );
});

customerCart.extendCustomerCartView((cart: ICartChange) => {
    cart.items = excludeProductsFromCartCount(cart.items).filter(
        (item) => !item.props.find((prop) => prop.Key === "NoEdit")
    );

    return cart;
});

customerCart.subscribeToCartProductItems(
    (data: ICustomerCartProductItemSubscription) => {
        const promoItem = data.items.find(
            (item) => item.type.toLowerCase() === "promo"
        );
        if (!promoItem) return;

        customerCart.removeProductView(promoItem.code);
        customerCart.renderProductView(promoItem.code, promoItem, {
            insertionOrder(itemList, entry) {
                return itemList.insertAdjacentElement("beforeend", entry);
            }
        });
    }
);

new ShoppingCart();

const initializeCustomerCartUI = (container: Element): void => {
    const categoryProductCarousels = Array.from(
        container.querySelectorAll(".slide--category-products-customer-cart")
    );

    categoryProductCarousels.forEach((categoryProductCarousel) => {
        const carousel = new Carousel(
            new SlideCarouselAdapter(categoryProductCarousel)
        );

        carousel.enablePrevNextControls();
        carousel.enableThumbnailControls();
    });

    const pictureAnimationCarousels = Array.from(
        container.querySelectorAll(".slide--product-beauty-shot")
    );

    pictureAnimationCarousels.forEach(
        (carousel) => new FadeCarouselWithPictureVimeoAnimation(carousel)
    );
};

const captureCustomerCartUI = (): void => {
    let process = false;

    pubsub.subscribe("captureBody", (elements: Element[]) => {
        const container = elements.find(
            (element) => element.id === customerCart.id
        );
        if (!container) return;

        const hasAttribute = container.hasAttribute(
            "data-customer-cart-container-ready"
        );
        if (hasAttribute) {
            return initializeCustomerCartUI(container);
        }

        if (process) return;
        process = true;

        const captureContainer = new CaptureElement(container);

        captureContainer.subscribe("attributes", (record) => {
            if (record.attributeName !== "data-customer-cart-container-ready")
                return;

            initializeCustomerCartUI(container);
        });
    });
};

captureCustomerCartUI();
initializeReviewTableUI();
initializeKlaviyoSignUpFormUI();
initializeVariantProductControllersUI();

observer("[data-variant-product-permalink]", {
    inRange: (element) => new VariantProductController(element)
});

const initializeDelayRenderUI = (): void => {
    const candidates = Array.from(document.querySelectorAll(".delay-render"));

    candidates.forEach((candidate) =>
        candidate.classList.remove("delay-render")
    );
};

addEventListener("load", initializeDelayRenderUI);

const initializeAccordions = () => {
    const accordions = Array.from(document.querySelectorAll(".accordion"));

    accordions.forEach((accordion) => new Accordion(accordion));
};

initializeAccordions();

const modalDialogIframe = new ModalDialogVimeoIframe();
modalDialogIframe.initializeObserver();

// currently used on .slide--reviews if it needs to be split out from another slider
observer(".slide--carousel", {
    inRange: (element) => {
        const adapter = new SlideCarouselAdapter(element);
        const carousel = new Carousel(adapter);

        carousel.enablePrevNextControls();
        carousel.enableThumbnailControls();

        if (adapter.isAuto()) {
            carousel.autoplay();
        }
    }
});

const vimeoManager = new VimeoManager();

observer(".slide--hero", {
    inRange: (element) => {
        const iframes = Array.from(
            element.querySelectorAll<HTMLIFrameElement>(
                'iframe[src^="https://player.vimeo.com/video"]'
            )
        );

        iframes.forEach(async (iframe) => {
            const id = vimeoManager.getIdByIframe(iframe);
            if (!id) return;

            const src = await vimeoManager.generatePosterImage(id, {
                width: window.innerWidth.toString(),
                height: window.innerHeight.toString()
            });

            const image = setElementAttributes(document.createElement("img"), {
                src,
                loading: "lazy",
                alt: "",
                role: "presentation"
            });

            iframe.insertAdjacentElement("beforebegin", image);
        });

        const carousel = new FadeCarousel(
            new FadeSlideCarouselAdapter(element)
        );

        carousel.autoplay();
    }
});

observer(".slide--review-card-carousel", {
    inRange: (element) => {
        const carousel = new ResponsiveCarousel(
            new ResponsiveSlideCarouselAdapter(element)
        );

        carousel.enablePrevNextControls();

        new MediaQuery("(min-width: 700px)")
            .inbound((task) => carousel.setAttributes({ steps: 2 }))
            .outbound((task) => carousel.setAttributes({ steps: 1 }));

        new MediaQuery("(min-width: 900px)")
            .inbound((task) => carousel.setAttributes({ steps: 3 }))
            .outbound((task) => carousel.setAttributes({ steps: 2 }));

        new MediaQuery("(min-width: 1150px)")
            .inbound((task) => carousel.setAttributes({ steps: 4 }))
            .outbound((task) => carousel.setAttributes({ steps: 3 }));
    }
});

observer(".slide--ugc-photo", {
    inRange: (element) => {
        const carousel = new ResponsiveCarousel(
            new ResponsiveSlideCarouselAdapter(element)
        );

        carousel.enablePrevNextControls();

        new MediaQuery("(min-width: 0rem)")
            .inbound((task) => carousel.setAttributes({ steps: 2 }))
            .outbound((task) => carousel.setAttributes({ steps: 1 }));

        new MediaQuery("(min-width: 43.75rem)")
            .inbound((task) => carousel.setAttributes({ steps: 3 }))
            .outbound((task) => carousel.setAttributes({ steps: 2 }));

        new MediaQuery("(min-width: 50rem)")
            .inbound((task) => carousel.setAttributes({ steps: 4 }))
            .outbound((task) => carousel.setAttributes({ steps: 3 }));

        new MediaQuery("(min-width: 56.25rem)")
            .inbound((task) => carousel.setAttributes({ steps: 5 }))
            .outbound((task) => carousel.setAttributes({ steps: 4 }));

        new MediaQuery("(min-width: 87.5rem)")
            .inbound((task) => carousel.setAttributes({ steps: 6 }))
            .outbound((task) => carousel.setAttributes({ steps: 5 }));
    }
});

observer(".element-controller", {
    inRange: (element) => {
        const elementController = new ElementController(element);

        elementController.controllers.forEach((controller) =>
            controller.addEventListener("click", (event) =>
                elementController.toggleElementsByController(controller)
            )
        );
    }
});

observer(".slide--category-products", {
    inRange: (element) => {
        const carousel = new ResponsiveCarousel(
            new ResponsiveSlideCarouselAdapter(element)
        );

        carousel.enablePrevNextControls();

        new MediaQuery("(min-width: 0px)").inbound((task) =>
            carousel.setAttributes({ steps: 1 })
        );

        new MediaQuery("(min-width: 800px)")
            .inbound((task) => carousel.setAttributes({ steps: 2 }))
            .outbound((task) => carousel.setAttributes({ steps: 1 }));

        new MediaQuery("(min-width: 1200px)")
            .inbound((task) => carousel.setAttributes({ steps: 3 }))
            .outbound((task) => carousel.setAttributes({ steps: 2 }));
    }
});

observer(".slide--product-beauty-shot", {
    inRange: (element) => new FadeCarouselWithPictureVimeoAnimation(element)
});

observer(".slide--vimeo-carousel", {
    inRange: (element) => {
        const carousel = new VimeoCarousel(
            new VimeoSlideCarouselAdapter(element)
        );

        carousel.autoplay();
        carousel.enablePrevNextControls();
    },
    options: {
        threshold: [0.5]
    }
});

initalizeDocumentModalDialogsByDOMMutation();
initializeGlobalHTMLTemplateRenderingEngine();

const flyoutRepo = initializeGlobalFlyoutRepository();

const initializeNav = (): void => {
    const nav = document.querySelector<HTMLElement>("#nav");
    if (!nav) return;

    initializeScrollingNav(nav);
    initializeNavWithFlyoutSupport(nav);
};

const initializeScrollingNav = (nav: HTMLElement): void => {
    observer("[data-nav-tracker]", {
        outRange: (element) => {
            nav.classList.add("nav--is-minibar");
        },
        unObserve: false
    });
};

const initializeNavWithFlyoutSupport = (nav: HTMLElement): void => {
    initializeFlyoutsThenNav(".flyout", nav.id);
    initializeFlyoutUI();

    const containers = Array.from<HTMLElement>(nav.querySelectorAll(".flyout"));

    const hoverableContainers = containers.filter((flyout) =>
        flyout.hasAttribute("data-flyout-allow-hover")
    );

    let usingNavDrawerUI = false;

    new MediaQuery("(max-width: 75rem)")
        .inbound((task) => {
            hoverableContainers.forEach((container) =>
                container.removeAttribute("data-flyout-allow-hover")
            );

            usingNavDrawerUI = true;
        })
        .outbound((task) => {
            hoverableContainers.forEach((container) =>
                container.setAttribute("data-flyout-allow-hover", "true")
            );

            usingNavDrawerUI = false;
        });

    const searchContainer = containers.find(
        (container) => container.id === "search-form"
    );
    if (!searchContainer) return;

    const searchFlyout = flyoutRepo.get(searchContainer);
    if (!searchFlyout) return;

    addEventListener("click", (event) => {
        const target = event.target as HTMLElement;
        const meetsCondition =
            target.closest("#search-form") === searchContainer &&
            !searchContainer.classList.contains("flyout--is-hidden");

        if (meetsCondition) return;

        searchFlyout.off();
    });

    const searchController = searchContainer.querySelector(".flyout__button");
    if (!searchController) return;

    const captureSearchController = new CaptureElement(searchController);
    captureSearchController.subscribe("attributes", (record) => {
        if (record.attributeName !== "aria-expanded") return;
        if (usingNavDrawerUI) return;

        switch (searchController.getAttribute("aria-expanded")) {
            case "true":
                hoverableContainers.forEach((container) =>
                    container.removeAttribute("data-flyout-allow-hover")
                );
                break;
            case "false":
                hoverableContainers.forEach((container) =>
                    container.setAttribute("data-flyout-allow-hover", "true")
                );
                break;
        }
    });
};

initializeNav();

new KlaviyoSignUpForm();

new ToolTip(document.querySelectorAll(".link"), "link--is-active");

const initializeReviewTableProductImages = () => {
    const reviewTable =
        document.querySelector<HTMLTableElement>("#orderReview");
    if (!reviewTable) return;

    const ofrt = new OrderFormReviewTable(reviewTable);

    ofrt.addProductListingImages();
};

initializeReviewTableProductImages();

const instagramIdList: string[] = [
    "18254238571179008",
    "17967272138321516",
    "17966382086330687",
    "17893768166772143",
    "17998261717648524",
    "18255380797120651",
    "17981126347832647",
    "18206278027228333",
    "17974200412985003"
];
const instagramMedia = new InstagramMediaDTMAdapter();

const createInstagramGallery = (gallery: Element | null): void => {
    if (!gallery) return;

    Promise.all(
        instagramIdList.map((id) => instagramMedia.requestMediaNode(id))
    )
        .then((media) => {
            Array.from(gallery.querySelectorAll("img[src]")).forEach(
                (picture, index): void => {
                    const post = media[index];
                    picture.setAttribute(
                        "src",
                        post.media_type === "VIDEO"
                            ? post.thumbnail_url
                            : post.media_url
                    );

                    const image = picture.querySelector("img");

                    if (!image) return;
                    image.alt = post.caption;
                }
            );
        })
        .catch((error) => console.debug(error));
};

createInstagramGallery(document.querySelector(".instagram-display"));

initializeBase();

new IngredientViewer();

const initializeKlaviyoWaitlistWithModalDialog = () => {
    let isCaptured = false;

    initializeModalDialogUI((container) => {
        if (container.id !== "klaviyo-waitlist-placeholder") return;

        if (!isCaptured) {
            initializeKlaviyoWaitlist(container)
                .then((statusScreen) => {
                    window.addEventListener("modal::close", () =>
                        statusScreen.close()
                    );
                })
                .catch((error) => console.debug(error));

            isCaptured = true;
        }
    });
};

initializeKlaviyoWaitlistWithModalDialog();

new CustomerProfile();
