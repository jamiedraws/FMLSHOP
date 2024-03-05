<template data-modal-dialog-template>
    <section id="klaviyo-waitlist-placeholder" data-modal-dialog-title="Join the waitlist" data-modal-dialog-container tabindex="0">
        <template id="klaviyo-waitlist-template">
            <form action="/" method="post" id="klaviyo-waitlist-form" class="view fieldset fieldset--klaviyo-waitlist section">
                <div class="view__in fieldset__in section__in">
                    <input type="hidden" id="klaviyo-variant-id" value="{{id}}"/>
                    <div class="fieldset__group">
                        <picture class="fieldset__picture-sidebar">
                            <source srcset="/images/Site1/products/{{code}}/{{code}}-0.webp" type="image/webp">
                            <img src="/images/Site1/products/{{code}}/{{code}}-0.jpg" loading="lazy" alt="{{title}}" width="560" height="760"/>
                        </picture>
                        <div class="fieldset__text">
                            <div class="fieldset__group">
                                <div class="fieldset__take-all">
                                    <picture>
                                        <img src="/images/Site1/logo.svg" alt="Flip My Life" width="90" height="90">
                                    </picture>
                                    <h2 id="waitlist-title" class="fieldset__title">Join the Waitlist</h2>
                                    <p>We will notify you when {{title}} is available.</p>
                                </div>
                                <picture class="fieldset__picture-block">
                                    <img src="{{image}}" alt="{{title}}" width="100" height="100" loading="lazy">
                                </picture>
                                <div class="fieldset__take-all form message">
                                    <div class="form__field-label">
                                        <input type="email" name="klaviyo-email" id="klaviyo-email" title="Format example: someone@someplace.com" required autocomplete="email" placeholder="*Email" class="form__field">
                                        <label for="klaviyo-email" class="message__label">
                                            <span class="form__error">* </span>Email
                                        </label>
                                        <span class="message__group" role="alert">
                                            <span class="message__invalid">Please enter an email address.</span>
                                        </span>
                                    </div>
                                </div>
                            
                                <div class="fieldset__take-all fieldset__action-disclaimer">
                                    <p id="waitlist-disclaimer">You'll receive a one time notification when this product arrives in stock. We won't share your information with anyone else.</p>
                                    <button type="submit" class="button" aria-describedby="waitlist-disclaimer">
                                        <span>Notify me when available</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </template>
    </section>
</template>