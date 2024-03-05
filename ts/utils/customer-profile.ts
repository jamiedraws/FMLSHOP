export default class CustomerProfile {
    private static url: string = window.location.href;

    constructor() {
        CustomerProfile.initializeActionByUrl();
    }

    private static initializeActionByUrl(): void {
        switch (true) {
            case /login/gi.test(this.url):
                this.login();
                break;
        }
    }

    private static login(): void {
        const returnUrl = document.querySelector<HTMLInputElement>(
            'input[type="hidden"][name="ReturnUrl"]'
        );
        if (!returnUrl) return;

        returnUrl.value = returnUrl.value + window.location.hash;
    }
}
