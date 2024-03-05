<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>

<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preload" href="/css/Site1/checkout.css" as="style" />
    <link rel="stylesheet" href="/css/Site1/checkout.css" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <%
        var subTotal = DtmContext.ShoppingCart.SubTotal.ToString("C");
        var shoppingCartItems = DtmContext.ShoppingCart.Items.Where(i => i.CampaignProduct.ProductTypeId == 1 || i.CampaignProduct.ProductTypeId == 2).ToList();
        var hasItems = (shoppingCartItems.Count() > 0) ? true : false;

        var landingPageUrl = string.Format("/{0}/{1}/{2}{3}#products",
        DtmContext.OfferCode,
        DtmContext.Version,
        "Index",
        DtmContext.ApplicationExtension);

        if (!hasItems)
        {
            var shoppingCartPageUrl = String.Format("/{0}/{1}/ShoppingCart{2}", DtmContext.OfferCode, DtmContext.Version, DtmContext.ApplicationExtension);
            Response.Redirect(shoppingCartPageUrl);
        }

    %>
    <script>    
        var emailOptVD = '<%=ViewData["EmailOptInCbx"]%>';
    </script>

    <main aria-labelledby="checkout-title" id="checkoutForm" class="view store store--checkout section">
        <div id="main" class="view__anchor"></div>
        <div class="logo-title-hero logo-title-hero--page-banner logo-title-hero--shrink">
            <div class="logo-title-hero__group">
                <h1 id="checkout-title" class="logo-title-hero__title">Checkout</h1>
            </div>
        </div>

        <div class="view__in section__in">
            <div class="section__block">
                <% if (FMLSHOP.Rules.Expose.Login)
                    { %>
                <% using (Html.BeginForm("CheckoutLogin", "Profile", FormMethod.Post, new { id = "loginForm", @data_processing_message = "Signing In..." }))
                    {
                        if (Model.CurrentCustomer == null || Model.CurrentCustomer.StoreCustomerID == Guid.Empty)
                        { %>
                <fieldset class="fieldset fieldset--login">
                    <div class="fieldset__group">
                        <h2 class="fieldset__take-all store__header">Returning Customers</h2>
                        <div class="fieldset__take-all form">
                            <div class="form__label">
                                <span class="form__error">*</span> Indicates a required field
                            </div>
                        </div>
                        <div class="form message">
                            <div class="form__field-label">
                                <input id="Login" type="email" name="Login" placeholder="Email Address" autocomplete="email" data-required="true" required data-pattern="^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$" class="form__field dtm__restyle">
                                <label for="Login" class="message__group">
                                    <span class="message__label"><span class="form__error">* </span>Email Address</span>
                                </label>
                                <div class="message__group" role="alert">
                                    <span class="message__invalid">Please enter an email address.</span>
                                </div>
                            </div>
                        </div>
                        <div class="form message">
                            <div class="form__field-label">
                                <input id="Password" maxlength="50" name="Password" type="password" autocomplete="current-password" data-required="true" required placeholder="Password" class="form__field">
                                <label for="Password" class="message__group">
                                    <span class="message__label"><span class="form__error">* </span>Password</span>
                                </label>
                                <div class="message__group" role="alert">
                                    <span class="message__invalid">Please enter a password.</span>
                                </div>
                            </div>
                        </div>
                        <nav aria-label="Login or recover password" class="fieldset__take-some store__nav">
                            <div class="store__group">
                                <button type="submit" data-validate-form-type="submit" id="customerLogin" name="customerLogin" class="button">Login</button>
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Login?forgotPassword=1" class="store__link">Forgot your password?</a>
                            </div>
                        </nav>
                        <%= Html.HiddenFor(m => m.ReturnUrl) %>
                    </div>
                </fieldset>
                <%}
                else
                { %>
                <div class="store__copy">
                    <div class="store__header">Welcome back, <%= Model.CurrentCustomer.FirstName %></div>
                    <div>Sign into a different account? <a href="/Profile/Logout" class="store__link">Logout</a></div>
                </div>
                <%}
                    }%>
                <% } %>

                <form data-validate-common-form action="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/<%=DtmContext.PageCode %><%= DtmContext.ApplicationExtension %>" method="post">
                    <script>_AdaErrors = false;</script>
                    <div role="alert" data-vse-scroll class="vse form__error">
                        <%= Html.ValidationSummary("The following errors have occurred:") %>
                        <%
                            var promo = DtmContext.ShoppingCart.Where(i => DtmContext.PromoCodeRules.Any(p => p.PromoCode == i.ProductCode)).Select(i => i.ProductCode).FirstOrDefault() ?? string.Empty;

                            if (DateTime.Now >= DateTime.Parse("06/01/23") && DateTime.Now < DateTime.Parse("06/04/23 11:59 PM") && String.IsNullOrEmpty(promo))
                            {
                                promo = "PROMOCODE25";
                            }
                        %>
                    </div>
                    <div class="store__group">
                        <div class="store__checkout">
                            <%-- Promotional Code --%>
                            <fieldset class="store__copy">
                                <h2 id="promoCodeHeader" class="store__header">Promotional Code</h2>
                                <div data-validate-promo-code class="form form--field-button message message--promo-code">
                                    <div class="message__select">
                                        <div class="form__contain form__field-button">
                                            <input type="text" name="promoCode" id="promoCode" placeholder="Enter promo code" class="form__field ddlPromo dtm__restyle" data-required="true" aria-labelledby="promoCodeHeader" value="<%=promo %>">
                                            <button type="button" id="emailSubscribeButton" data-validate-form-type="submit" data-validate-form-page-code="Checkout" class="button form__button ddlPromoButton" onclick="_firstRun = false; handleCartChange();">
                                                <span>Apply</span>
                                            </button>
                                        </div>
                                    </div>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter a valid promo code.</span>
                                        <div id="promo-code-validation-status" class="message__valid"></div>
                                    </div>
                                </div>
                            </fieldset>

                            <%-- Order Review --%>
                            <div class="store__copy">
                                <h2 class="store__header">Review Your Order</h2>
                                <div class="c-brand--form order-table reviewTable" data-eflex-table-custom>
                                    <% Html.RenderPartial("OrderFormReviewTable"); %>

                                    <div id="emptyCartSection" class="hide">
                                        <p>Your cart is currently empty.</p>
                                        <a href="<%= landingPageUrl %>" class="button button--second">Continue Shopping</a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="store__form store__copy">
                            <fieldset class="fieldset">
                                <div class="fieldset__group" id="paymentInformation">
                                    <h2 class="fieldset__take-all store__header">Select Payment Type</h2>

                                    <!-- Card Type -->
                                    <div class="fieldset__take-all form message">
                                        <div id="cc" class="payment-icons"></div>
                                        <%
                                            var cardTypeMessage = Html.ValidationMessageFor(m => m.CardType);
                                            var cardTypeIsInvalid = cardTypeMessage != null;
                                        %>
                                        <div id="CardTypeCt" class="form__field-label">
                                            <div class="form form--select">
                                                <div class="form__contain">
                                                    <%= Html.DropDownList("CardType", new[]
                                                    {
                                                        new SelectListItem { Text = "Visa", Value = "V"},
                                                        new SelectListItem { Text = "Mastercard", Value = "M"},
                                                        new SelectListItem { Text = "Discover", Value = "D"},
                                                        new SelectListItem { Text = "American Express", Value= "AX"}
                                                    }, new { @class = "form__field dtm__restyle" })
                                                    %>
                                                    <span class="form__field form__button">
                                                        <svg class="icon icon--combobox">
                                                            <use href="#icon-chevron"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                            <label class="message__group" for="CardType" role="alert">
                                                <span class="message__label">
                                                    <span class="form__error">* </span>Card Type
                                                </span>
                                                <span class="message__invalid">
                                                    <% if (cardTypeIsInvalid)
                                                        { %>
                                                    <%= cardTypeMessage %>
                                                    <% }
                                                        else
                                                        { %>
                                                    Please choose a card type.
                                                <% } %>
                                                </span>
                                            </label>
                                        </div>
                                    </div>

                                    <div class="fieldset__group" id="paymentInformationStep" data-express-checkout-order-type="CARD">
                                        <!-- Card Number -->
                                        <div class="fieldset__take-all form message">
                                            <div role="alert" id="vse-payment" data-vse-scroll></div>
                                            <%
                                                var cardNumberMessage = Html.ValidationMessageFor(m => m.CardNumber);
                                                var cardNumberIsInvalid = cardNumberMessage != null;
                                            %>
                                            <div class="form__field-label">
                                                <input type="tel" name="CardNumber" id="CardNumber" placeholder="Card Number" data-required="true" autocomplete="cc-number" class="dtm__restyle form__field <%= cardNumberIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["CardNumber"] %>">
                                                <label for="CardNumber" class="message__label">
                                                    <span class="form__error">* </span>Card Number
                                                </label>
                                                <span class="message__group" role="alert">
                                                    <span class="message__invalid">
                                                        <% if (cardNumberIsInvalid)
                                                            { %>
                                                        <%= cardNumberMessage %>
                                                        <% }
                                                            else
                                                            { %>
                                                        Please enter a valid card number.
                                                    <% } %>
                                                    </span>
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Card Expiration Month -->
                                        <div id="CardExpirationCt" class="form message">
                                            <%
                                                var cardExpirationMonthMessage = Html.ValidationMessageFor(m => m.CardExpirationMonth);
                                                var cardExpirationMonthIsInvalid = cardExpirationMonthMessage != null;
                                            %>
                                            <div class="form__field-label">
                                                <div class="form form--select message__select">
                                                    <div class="form__contain">
                                                        <%= Html.CardExpirationMonth("CardExpirationMonth", new { @id="CardExpirationMonth", @class = "form__field dtm__restyle", @data_required="true", @autcomplete="cc-exp-month"}) %>
                                                        <span class="form__field form__button">
                                                            <svg class="icon">
                                                                <use href="#icon-chevron"></use>
                                                            </svg>
                                                        </span>
                                                    </div>
                                                </div>
                                                <label for="CardExpirationMonth" class="message__label">
                                                    <span class="form__error">* </span>Card Expiration Month
                                                </label>
                                                <span class="message__group" role="alert">
                                                    <span class="message__invalid">
                                                        <% if (cardExpirationMonthIsInvalid)
                                                            { %>
                                                        <%= cardExpirationMonthMessage %>
                                                        <% }
                                                            else
                                                            { %>
                                                        Please choose an expiration month.
                                                    <% } %>
                                                    </span>
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Card Expiration Year -->
                                        <div id="CardExpirationYearCt" class="form message">
                                            <%
                                                var cardExpirationYearMessage = Html.ValidationMessageFor(m => m.CardExpirationYear);
                                                var cardExpirationYearIsInvalid = cardExpirationYearMessage != null;
                                            %>
                                            <div class="form__field-label">
                                                <div class="form form--select message__select">
                                                    <div class="form__contain">
                                                        <%= Html.NumericDropDown("CardExpirationYear", DateTime.Now.Year, DateTime.Now.Year + 10, ViewData["CardExpirationYear"], new { @id="CardExpirationYear", @class = "form__field dtm__restyle", @autocomplete = "cc-exp-year" }) %>
                                                        <span class="form__field form__button">
                                                            <svg class="icon">
                                                                <use href="#icon-chevron"></use>
                                                            </svg>
                                                        </span>
                                                    </div>
                                                </div>
                                                <label for="CardExpirationYear" class="message__label">
                                                    <span class="form__error">* </span>Card Expiration Year
                                                </label>
                                                <span class="message__group" role="alert">
                                                    <span class="message__invalid">
                                                        <% if (cardExpirationYearIsInvalid)
                                                            { %>
                                                        <%= cardExpirationYearMessage %>
                                                        <% }
                                                            else
                                                            { %>
                                                        Please enter an expiration year.
                                                    <% } %>
                                                    </span>
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Card CVV2 -->
                                        <div id="CardCVV2Ct" class="fieldset__take-all form message">
                                            <%
                                                var cardCVV2Message = Html.ValidationMessageFor(m => m.CardCvv2);
                                                var cardCVV2IsInvalid = cardCVV2Message != null;
                                            %>
                                            <div class="form__field-label form__cvv">
                                                <input type="text" name="CardCvv2" id="CardCvv2" autocomplete="cc-csc" placeholder="CVV2" data-required="true" class="dtm__restyle form__field <%= cardCVV2IsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["CardCvv2"] %>">
                                                <label for="CardCvv2" class="message__label">
                                                    <span class="form__error">* </span>CVV2
                                                </label>
                                                <span class="message__group" role="alert">
                                                    <span class="message__invalid">
                                                        <% if (cardCVV2IsInvalid)
                                                            { %>
                                                        <%= cardCVV2Message %>
                                                        <% }
                                                            else
                                                            { %>
                                                        Please enter a CVV number.
                                                    <% } %>
                                                    </span>
                                                </span>
                                                <a data-modal-dialog-id="cvv" data-modal-dialog-actor="open" data-modal-dialog-iframe data-modal-dialog-title="About CVV2" href="/shared/cvv.html" title="Learn What is CVV2" id="cvv2-link" class="store__link form__link">What is CVV2?</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                            <%
                                ViewDataDictionary billingAddressViewData;
                                ViewDataDictionary shippingAddressViewData;
                                if (Model.CurrentCustomer != null && Model.CurrentCustomer.StoreCustomerID != Guid.Empty)
                                {
                                    var addresses = Model.CurrentCustomer.StoreCustomerAddresses;

                                    var billingAddress = addresses
                                        .Where(a => a.IsDefault.HasValue
                                        && a.IsDefault.Value
                                        && (!a.IsShipping.HasValue || (a.IsShipping.HasValue && !a.IsShipping.Value)))
                                        .FirstOrDefault()
                                        ??
                                        addresses
                                        .Where(a => (!a.IsShipping.HasValue || (a.IsShipping.HasValue && !a.IsShipping.Value)))
                                        .FirstOrDefault()
                                        ?? new StoreCustomerAddress();

                                    var shippingAddress = addresses
                                        .Where(a => a.IsDefault.HasValue
                                        && a.IsDefault.Value
                                        && a.IsShipping.HasValue
                                        && a.IsShipping.Value)
                                        .FirstOrDefault()
                                        ??
                                        addresses
                                        .Where(a => a.IsShipping.HasValue
                                        && a.IsShipping.Value)
                                        .FirstOrDefault()
                                        ?? new StoreCustomerAddress();


                                    billingAddressViewData = new ViewDataDictionary {
                                    {"BillingStreet", billingAddress.Street},
                                    {"BillingStreet2", billingAddress.Street2},
                                    { "BillingFirstName", billingAddress.FirstName },
                                    { "BillingLastName", billingAddress.LastName},
                                    { "BillingZip", billingAddress.Zip },
                                    { "BillingCountry", billingAddress.Country },
                                    { "Email", Model.CurrentCustomer.Email },
                                    { "Phone", Model.CurrentCustomer.Phone },
                                    { "BillingState", billingAddress.State },
                                    { "BillingCity", billingAddress.City }
                                };
                                    shippingAddressViewData = new ViewDataDictionary {
                                    {"ShippingStreet", shippingAddress.Street},
                                    {"ShippingStreet2", shippingAddress.Street2},
                                    { "ShippingFirstName", shippingAddress.FirstName },
                                    { "ShippingLastName", shippingAddress.LastName},
                                    { "ShippingZip", shippingAddress.Zip },
                                    { "ShippingCountry", shippingAddress.Country },
                                    { "ShippingState", shippingAddress.State },
                                    { "ShippingCity", shippingAddress.City }
                                };

                                }
                                else
                                {
                                    var order = Model.Order ?? new Order();

                                    billingAddressViewData = new ViewDataDictionary {
                                    {"BillingStreet", order.BillingStreet},
                                    {"BillingStreet2", order.BillingStreet2},
                                    { "BillingFirstName", order.BillingFirstName },
                                    { "BillingLastName", order.BillingLastName},
                                    { "BillingZip", order.BillingZip },
                                    { "BillingCountry", order.BillingCountry },
                                    { "Email", order.Email },
                                    { "Phone", order.Phone },
                                    { "BillingState", order.BillingState },
                                    { "BillingCity", order.BillingCity }
                                };

                                    shippingAddressViewData = new ViewDataDictionary {
                                    {"ShippingStreet", order.ShippingStreet},
                                    {"ShippingStreet2", order.ShippingStreet2},
                                    { "ShippingFirstName", order.ShippingFirstName },
                                    { "ShippingLastName", order.ShippingLastName},
                                    { "ShippingZip", order.ShippingZip },
                                    { "ShippingCountry", order.ShippingCountry},
                                    { "ShippingState", order.ShippingState},
                                    { "ShippingCity", order.ShippingCity }
                                };
                                }

                                billingAddressViewData.Add("BillingFirstNameMessage", Html.ValidationMessageFor(m => m.BillingFirstName));
                                billingAddressViewData.Add("BillingLastNameMessage", Html.ValidationMessageFor(m => m.BillingLastName));
                                billingAddressViewData.Add("BillingStreetMessage", Html.ValidationMessageFor(m => m.BillingStreet));
                                billingAddressViewData.Add("BillingStreet2Message", Html.ValidationMessageFor(m => m.BillingStreet2));
                                billingAddressViewData.Add("BillingCityMessage", Html.ValidationMessageFor(m => m.BillingCity));
                                billingAddressViewData.Add("BillingStateMessage", Html.ValidationMessageFor(m => m.BillingState));
                                billingAddressViewData.Add("BillingZipMessage", Html.ValidationMessageFor(m => m.BillingZip));
                                billingAddressViewData.Add("BillingCountryMessage", Html.ValidationMessageFor(m => m.BillingCountry));
                                billingAddressViewData.Add("PhoneMessage", Html.ValidationMessageFor(m => m.Phone));
                                billingAddressViewData.Add("EmailMessage", Html.ValidationMessageFor(m => m.Email));

                                Html.RenderPartial("BillingInfo", Model, billingAddressViewData);

                                shippingAddressViewData.Add("ShippingFirstNameMessage", Html.ValidationMessageFor(m => m.ShippingFirstName));
                                shippingAddressViewData.Add("ShippingLastNameMessage", Html.ValidationMessageFor(m => m.ShippingLastName));
                                shippingAddressViewData.Add("ShippingStreetMessage", Html.ValidationMessageFor(m => m.ShippingStreet));
                                shippingAddressViewData.Add("ShippingStreet2Message", Html.ValidationMessageFor(m => m.ShippingStreet2));
                                shippingAddressViewData.Add("ShippingCityMessage", Html.ValidationMessageFor(m => m.ShippingCity));
                                shippingAddressViewData.Add("ShippingStateMessage", Html.ValidationMessageFor(m => m.ShippingState));
                                shippingAddressViewData.Add("ShippingZipMessage", Html.ValidationMessageFor(m => m.ShippingZip));
                                shippingAddressViewData.Add("ShippingCountryMessage", Html.ValidationMessageFor(m => m.ShippingCountry));

                                Html.RenderPartial("ShippingInfo", Model, shippingAddressViewData);
                            %>

                            <% if (FMLSHOP.Rules.Expose.Login)
                                { %>
                            <fieldset id="additional-information" class="fieldset" data-express-checkout-order-type="card">
                                <div class="fieldset__group">
                                    <h2 class="fieldset__take-all store__header">Additional Information</h2>

                                    <%if (Model.CurrentCustomer == null || Model.CurrentCustomer.StoreCustomerID == Guid.Empty)
                                        { %>

                                    <div class="fieldset__take-all form form--checkbox message">
                                        <div class="form__checkbox-label">
                                            <input type="hidden" name="CreateAccount" id="CreateAccount" value="False" />
                                            <input
                                                type="checkbox"
                                                id="CreateAccountCbx"
                                                name="CreateAccountCbx" />
                                            <label for="CreateAccountCbx" class="form__label">
                                                <span class="form__checkbox"></span>
                                                <span id="CreateAccountCbxLabel">Use this information to create an account for a faster checkout in the future.</span>
                                            </label>
                                        </div>
                                    </div>

                                    <div id="passwordField" hidden class="fieldset__take-all">
                                        <div class="fieldset__take-all form form--username-password message">
                                            <div class="form__field-label">
                                                <div class="form__username message__label">
                                                    <span>Username: </span><b id="emailSignUp"></b>
                                                </div>
                                                <div class="form__field-label">
                                                    <label for="CreateAccountPassword" class="message__label">
                                                        <span class="form__error">* </span>Password
                                                    </label>
                                                    <input type="password" name="CurrentCustomer.Password" id="CreateAccountPassword" data-required="true" placeholder="Password" class="form__field" autocomplete="new-password" aria-autocomplete="list">
                                                    <span class="message__group" role="alert">
                                                        <span class="message__invalid">Please enter a password.</span>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <% }
                                    else
                                    { %>
                                    <div class="fieldset__take-all form message">
                                        <div class="form__checkbox-label">
                                            <input type="hidden" name="SaveInfo" id="SaveInfo" value="False" />
                                            <input
                                                type="checkbox"
                                                id="SaveInfoCbx"
                                                name="SaveInfoCbx"
                                                aria-labelledby="SaveInfoCbxLabel" />
                                            <label for="SaveInfoCbx" class="form__label">
                                                <span class="form__checkbox"></span>
                                                <span id="SaveInfoCbxLabel">Save my information for a faster checkout in the future.</span>
                                            </label>
                                        </div>
                                    </div>
                                    <% }
                                    %>
                                </div>
                            </fieldset>
                            <% } %>

                            <button type="submit" id="AcceptOfferButton" name="acceptOffer">
                                <span id="AcceptOfferCard" class="button button--checkout" aria-describedby="disclaimerText" data-express-checkout-order-type="card">
                                    <span>Process Order</span>
                                </span>
                                <div data-express-checkout-buttons></div>
                            </button>

                            <p id="disclaimerText" data-express-checkout-order-type="CARD">By clicking Process Order, your credit card will be charged the amount above. Click only once. Please confirm accuracy of billing and shipping address as it cannot be changed once the orders are placed, since all orders are processed immediately.</p>

                            <div class="disclaimer">
                                <p><strong>OFFER DETAILS: </strong>
                                    <br>
                                    These offers are only available within the United States (50 states). State sales tax will be applied where applicable. There will be a $5.95 processing and handling fee for all orders. Orders shipping to AK or HI will incur a Shipping Surcharge of $10.00.</p>
                                <%
                                    string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];
                                %>
                                <p><strong>*Subscribe and Save: </strong>Save 20% today when you choose Subscribe and Save. You will then automatically receive a new supply every 30 days, charged to the same payment method used on today's order. You may send an email to <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a> to cancel your subscription. Please contact us at least 3 business days prior to your next billing to avoid being charged for the upcoming month.</p>

                                <p>Please note that our subscribe and save discounted offer requires a minimum of 2 months commitment. You will not be billed for your second month until after 30 days from your initial purchase and you can cancel any time after 30 days, by contacting us at <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a>. We do offer a 30-day money-back guarantee with the return of the product.</p>
                            </div>

                            <div class="disclaimer">
                                <p>
                                    <strong>DISCLAIMER: </strong>
                                    <br>
                                    These products have not been evaluated by the Food and Drug Administration. This product is not intended to diagnose, treat, or prevent any disease.
                                </p>
                            </div>
                            </p>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <section id="emptyCartModal" data-modal-dialog-container data-modal-dialog-title="Empty Cart" aria-labelledby="empty-cart-title" class="view store section">
        <div class="view__in section__in store__copy">
            <h2 id="empty-cart-title" class="store__header">Hello there!</h2>
            <p>Your cart is currently empty. Please add at least one item to your order to checkout.</p>
            <a href="<%= landingPageUrl %>" class="button">
                <span>Continue Shopping</span>
            </a>
        </div>
    </section>

    <script>

        window.addEventListener("load", function () {
            $('#emailSignUp').text($('#Email').val());

            $('#Email').on('keyup', function () {
                var val = $(this).val();
                $('#emailSignUp').text(val);
            });

            //Validation
            $("#AcceptOfferButton").on("click", function () {
                let createAccountElementExists = $("#CreateAccountCbx").length;
                if (createAccountElementExists) {
                    let createAccountCbxChecked = $("#CreateAccountCbx").is(":checked");
                    let passwordHasValue = $("#CreateAccountPassword").val().length !== 0;
                    if (createAccountCbxChecked && !passwordHasValue) {
                        setMessageToInvalid($("#CreateAccountPassword"));
                    }
                }

            });

            function setMessageToInvalid(element) {
                if (!element) return false;
                element.addClass("message__is-invalid");
                element.removeClass("message__is-valid");
            }

            const emptyCartModalDiv = document.getElementById("emptyCartModal");
            const ofrtDiv = document.getElementById("reviewOrder");
            const emptyCartSectionDiv = document.getElementById("emptyCartSection");


            addEventListener("CartChange", updateCheckoutForm);

            function updateCheckoutForm() {
                if (getItems().length !== 0) return;

                const emptyCartModal = modalRepo.get(emptyCartModalDiv);
                if (!emptyCartModal) return;

                emptyCartModal.open();
                $(emptyCartSectionDiv).removeClass('hide');
                $(ofrtDiv).addClass('hide');
            }

            const toggleCreateAccountFieldsetByCheckbox = function (fieldset, checkbox) {
                if (!checkbox) return;

                const password = document.getElementById("CreateAccountPassword");
                if (!password) return;

                checkbox.addEventListener("click", function () {
                    if (checkbox.checked) {
                        fieldset.removeAttribute("hidden");
                        password.setAttribute("required", "");
                        password.setAttribute("data-required", "true");
                    } else {
                        fieldset.setAttribute("hidden", "");
                        password.removeAttribute("required");
                        password.removeAttribute("data-required");
                    }
                });
            };

            toggleCreateAccountFieldsetByCheckbox(document.getElementById("passwordField"), document.getElementById("CreateAccountCbx"));


            if (klaviyo) {
                klaviyo.StartedShoppingCartCheckout();
            }

        });



    </script>

</asp:Content>
