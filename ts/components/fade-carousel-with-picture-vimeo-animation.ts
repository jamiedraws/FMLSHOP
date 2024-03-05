// api
import FadeSlideCarouselAdapter from "Shared/ts/api/carousel/slide/adapters/fade-slide-carousel";

// components
import FadeCarousel from "Shared/ts/components/fade-carousel";
import { createElement } from "Shared/ts/utils/html";

// utils
import VimeoManager from "Shared/ts/utils/vimeo-manager";

export default class FadeCarouselWithPictureVimeoAnimation {
    public container: Element;

    public carousel: FadeCarousel;

    public vimeoIframePlayers: HTMLIFrameElement[] = [];

    private adapter: FadeSlideCarouselAdapter;

    private static vimeoManager: VimeoManager = new VimeoManager();

    private static trackerIframeRepository: WeakMap<
        HTMLElement,
        HTMLIFrameElement
    > = new WeakMap<HTMLElement, HTMLIFrameElement>();

    constructor(container: Element) {
        this.container = container;

        this.adapter = new FadeSlideCarouselAdapter(container);

        this.carousel = new FadeCarousel(this.adapter);

        this.processVimeoPlaceholders();
        this.initializeCarouselUI();
    }

    private initializeCarouselUI(): void {
        this.carousel.container?.addEventListener("mouseenter", (event) => {
            this.carousel.container?.classList.remove(
                "slide--hide-vimeo-iframe"
            );

            this.carousel.goto(1);
        });

        this.carousel.container?.addEventListener("mouseleave", (event) => {
            this.carousel.goto(0);
        });
    }

    private processVimeoPlaceholders(): void {
        const placeholders = Array.from<HTMLElement>(
            this.container.querySelectorAll("[data-vimeo-carousel-id]")
        );

        const observer = new IntersectionObserver((records) => {
            records.forEach((record) => {
                const iframe =
                    FadeCarouselWithPictureVimeoAnimation.trackerIframeRepository.get(
                        record.target as HTMLElement
                    );
                if (!iframe) return;

                const player =
                    FadeCarouselWithPictureVimeoAnimation.vimeoManager.getPlayerByIframe(
                        iframe
                    );
                if (!player) return;

                switch (record.intersectionRatio > 0) {
                    case true:
                        player.play();

                        break;
                    case false:
                        player.pause();
                        player.setCurrentTime(0);

                        break;
                }
            });
        });

        placeholders
            .filter((placeholder) => placeholder.id !== "")
            .forEach((placeholder) => {
                this.initializeVimeoPlayerByPlaceholder(placeholder).then(
                    (iframe) => {
                        {
                            const tracker = createElement("div", {
                                "data-tracker": placeholder.id
                            });
                            placeholder.appendChild(tracker);

                            FadeCarouselWithPictureVimeoAnimation.trackerIframeRepository.set(
                                tracker,
                                iframe
                            );

                            observer.observe(tracker);
                        }
                    }
                );

                const slide = placeholder.closest<HTMLElement>(".slide__item");

                slide?.addEventListener(
                    "transitionend",
                    (event: TransitionEvent) => {
                        const target = event.target as HTMLElement;
                        if (event.propertyName !== "opacity") return;

                        const isVisible = target.classList.contains(
                            "slide__item--current"
                        );

                        if (!isVisible) {
                            this.carousel.container?.classList.add(
                                "slide--hide-vimeo-iframe"
                            );
                        }
                    }
                );
            });
    }

    private initializeVimeoPlayerByPlaceholder(
        placeholder: HTMLElement
    ): Promise<HTMLIFrameElement> {
        return new Promise<HTMLIFrameElement>((resolve, reject) => {
            const id = placeholder.getAttribute("data-vimeo-carousel-id");
            if (!id) return;

            const player =
                FadeCarouselWithPictureVimeoAnimation.vimeoManager.createPlayerById(
                    placeholder.id,
                    id,
                    {
                        background: 1,
                        loop: 1
                    }
                );

            setTimeout(() => {
                const message =
                    "The HTML iframe element containing the Vimeo Player was unobtainable for the carousel";

                const iframe =
                    FadeCarouselWithPictureVimeoAnimation.vimeoManager.getIframeByPlayer(
                        player
                    );
                if (!iframe) {
                    reject({
                        message,
                        id,
                        placeholder
                    });

                    return;
                }

                if (!placeholder.contains(iframe)) {
                    placeholder.append(iframe);
                }

                iframe
                    ? resolve(iframe)
                    : reject({
                          message,
                          id,
                          placeholder
                      });
            }, 1000);
        });
    }
}
