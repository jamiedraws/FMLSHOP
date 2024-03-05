<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>

<% using (Html.BeginForm()) { %>        
    <div class="checkout element-controller">
        <div class="checkout__group">
            <div class="checkout__take-all">
                <script>_AdaErrors = false;</script>
                <div role="alert" class="vse" data-vse-scroll>
                    <%= Html.ValidationSummary("The following errors have occurred:") %>
                </div>
            </div>
            <div class="checkout__take-all checkout__action-text">
                <div class="form">
                    <span class="form__error">*</span>Indicates required field
                </div>
            </div>
            <div class="checkout__take-all">
                <fieldset class="fieldset fieldset--frame" id="SelectOffer">
                    <div class="fieldset__group fieldset__container">
                        <h2 class="fieldset__take-all fieldset__title">STEP 1: Select Your Offer</h2> 
                        <div class="fieldset__take-all">
                            <div class="fieldset__content">
                                <div class="product-offers">
                                    <div id="flip-7-chocolate" class="product-offer">
                                        <h3 class="product-offer__title">Flip 7<br>Chocolate</h3>
                                        <picture class="product-offer__picture">
                                            <img src="/images/Site99/flip-7-chocolate.png" alt="Bag of the flip 7 chocolate shake" width="240" height="242" loading="lazy">
                                        </picture>
                                        <div class="product-offer__price">Price: $44.95</div>
                                        <div class="product-offer__checkbox">
                                            <div class="form form--radio message">
                                                <div class="form__radio-label">
                                                    <input
                                                        type="checkbox"
                                                        id="checkbox4"
                                                        name="checkbox4"
                                                        aria-labelledby="Checkbox4Label"
                                                        class="element-controller__controller"
                                                        aria-controls="termsCbxSection"/>
                                                    <label for="checkbox4" class="form__label">
                                                        <span class="form__radio"></span>
                                                        <span id="Checkbox4Label">Subscribe and Save 10%*<br>Only $40.45 per package!</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__combobox">
                                            <div class="form message">
                                                <div class="form__field-label">
                                                    <label for="flip-chocolate">
                                                        <span class="form__error">* </span>Qty
                                                    </label>
                                                    <div class="form form--select">
                                                        <div class="form__contain">
                                                            <select name="quantity4" id="flip-chocolate" class="form__field dtm__restyle" data-required>
                                                               <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                            </select>
                                                            <span class="form__field form__button">
                                                                <svg class="icon" focusable="false" role="presentation">
                                                                    <use href="#icon-chevron"/>
                                                                </svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__button">
                                            <button type="button" >
                                                <span><a href="javascript:void(0);" class="button" data-code-modifier="checkbox4" data-code="F7C" data-code-alt="CF7C" data-noedit="true" data-select-id="flip-chocolate" data-code-toggle="true">Add to Cart</a>
                                            </button>
                                        </div>
                                    </div>
                                    <div id="flip-7-vanilla" class="product-offer">
                                        <h3 class="product-offer__title">Flip 7<br>Vanilla</h3>
                                        <picture class="product-offer__picture">
                                            <img src="/images/Site99/flip-7-vanilla.png" alt="Bag of the flip 7 vanilla shake" width="240" height="242" loading="lazy">
                                        </picture>
                                        <div class="product-offer__price">Price: $44.95</div>
                                        <div class="product-offer__checkbox">
                                            <div class="form form--radio message">
                                                <div class="form__radio-label">
                                                    <input
                                                        type="checkbox"
                                                        id="checkbox3"
                                                        name="checkbox3"
                                                        aria-labelledby="Checkbox3Label"
                                                        class="element-controller__controller"
                                                        aria-controls="termsCbxSection"/>
                                                    <label for="checkbox3" class="form__label">
                                                        <span class="form__radio"></span>
                                                        <span id="Checkbox3Label">Subscribe and Save 10%*<br>Only $40.45 per package!</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__combobox">
                                            <div class="form message">
                                                <div class="form__field-label">
                                                    <label for="flip-vanilla">
                                                        <span class="form__error">* </span>Qty
                                                    </label>
                                                    <div class="form form--select">
                                                        <div class="form__contain">
                                                            <select name="quantity3" id="flip-vanilla" class="form__field dtm__restyle" data-required>
                                                                <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                            </select>
                                                            <span class="form__field form__button">
                                                                <svg class="icon" focusable="false" role="presentation">
                                                                    <use href="#icon-chevron"/>
                                                                </svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__button">
                                            <button type="button">
                                                <span><a href="javascript:void(0);" class="button" data-code-modifier="checkbox3" data-code="F7V" data-code-alt="CF7V" data-noedit="true" data-select-id="flip-vanilla" data-code-toggle="true">Add to Cart</a>
                                            </button>
                                        </div>
                                    </div>
                                    <div id="collagen-peptides-biotin" class="product-offer">
                                        <h3 class="product-offer__title">Collagen<br>Peptides + Biotin</h3>
                                        <picture class="product-offer__picture">
                                            <img src="/images/Site99/collagen-peptides-biotin.png" alt="Bag of the collagen peptides + biotin" width="240" height="242" loading="lazy">
                                        </picture>
                                        <div class="product-offer__price">Price: $29.95</div>
                                        <div class="product-offer__checkbox">
                                            <div class="form form--radio message">
                                                <div class="form__radio-label">
                                                    <input
                                                        type="checkbox"
                                                        id="checkbox1"
                                                        name="checkbox1"
                                                        aria-labelledby="Checkbox1Label" 
                                                        class="element-controller__controller"
                                                        aria-controls="termsCbxSection"/>
                                                    <label for="checkbox1" class="form__label">
                                                        <span class="form__radio"></span>
                                                        <span id="Checkbox1Label">Subscribe and Save 10%*<br>Only $26.95 per package!</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__combobox">
                                            <div class="form message">
                                                <div class="form__field-label">
                                                    <label for="BIOTIN">
                                                        <span class="form__error">* </span>Qty
                                                    </label>
                                                    <div class="form form--select">
                                                        <div class="form__contain">
                                                           <select name="quantity1" id="BIOTIN" class="form__field dtm__restyle" data-required>
                                                                <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                            </select>
                                                            <span class="form__field form__button">
                                                                <svg class="icon" focusable="false" role="presentation">
                                                                    <use href="#icon-chevron"/>
                                                                </svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__button">
                                            <button type="button">
                                                <span><a href="javascript:void(0);" class="button" data-code-modifier="checkbox1" data-code="CPB" data-code-alt="CCPB" data-noedit="true" data-select-id="BIOTIN" data-code-toggle="true">Add to Cart</a>
                                                </span>
                                            </button>
                                        </div>
                                    </div>
                                    <div id="super-matcha-latte" class="product-offer">
                                        <h3 class="product-offer__title">Super<br>Matcha Latte</h3>
                                        <picture class="product-offer__picture">
                                            <img src="/images/Site99/super-matcha-latte.png" alt="Bag of the super matcha latte" width="240" height="242" loading="lazy">
                                        </picture>
                                        <div class="product-offer__price">Price: $24.95</div>
                                        <div class="product-offer__checkbox">
                                            <div class="form form--radio message">
                                                <div class="form__radio-label">
                                                    <input
                                                        type="checkbox"
                                                        id="checkbox2"
                                                        name="checkbox2"
                                                        aria-labelledby="Checkbox2Label" 
                                                        class="element-controller__controller"
                                                        aria-controls="termsCbxSection"/>
                                                    <label for="checkbox2" class="form__label">
                                                        <span class="form__radio"></span>
                                                        <span id="Checkbox2Label">Subscribe and Save 10%*<br>Only $22.45 per package!</span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__combobox">
                                            <div class="form message">
                                                <div class="form__field-label">
                                                    <label for="matcha-latte">
                                                        <span class="form__error">* </span>Qty
                                                    </label>
                                                    <div class="form form--select">
                                                        <div class="form__contain">
                                                            <select name="quantity2" id="matcha-latte" class="form__field dtm__restyle" data-required>
                                                                <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                            </select>
                                                            <span class="form__field form__button">
                                                                <svg class="icon" focusable="false" role="presentation">
                                                                    <use href="#icon-chevron"/>
                                                                </svg>
                                                            </span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="product-offer__button">
                                            <button type="button">
                                                <span><a href="javascript:void(0);" class="button" data-code-modifier="checkbox2" data-code="SML" data-code-alt="CSML" data-noedit="true" data-select-id="matcha-latte" data-code-toggle="true">Add to Cart</a>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                                     <style>
                        .hide {
                            display:none;
                        }
                    </style>

                                <div class="offer-details">
                                    <p><b>*Subscribe and Save:</b> Save 10% today when you choose Subscribe and Save. You will then automatically receive a new supply every 30 days, charged to the same payment method used on today's order. You may send an email to <a href="mailto:support@flipmylifewellness.com">support@flipmylifewellness.com</a> to cancel your subscription. Please contact us at least 3 business days prior to your next billing to avoid being charged for the upcoming month.</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </fieldset>
            </div>
            <div class="checkout__take-all">
                <fieldset class="fieldset fieldset--frame">
                    <div class="fieldset__group fieldset__container">
                        <h2 class="fieldset__take-all fieldset__title">STEP 2: Review Your Order</h2>
                        <div class="fieldset__take-all c-brand--form order-table reviewTable">
                            <% Html.RenderPartial("OrderFormReviewTable"); %>
                        </div>
                    </div>
                </fieldset>
            </div>
            <div class="checkout__take-all">
                <div class="checkout__group">
                    <div class="checkout__take-some view" data-viewport>
                        <div class="view__scroll">
                            <fieldset class="fieldset fieldset--frame">
                                <div class="fieldset__group fieldset__container" id="paymentInformation">
                                    <h2 class="fieldset__take-all fieldset__title">STEP 3: Select Payment Type</h2>

                                    <!-- Card Type -->
                                    <div class="fieldset__take-all form message">
                                        <div id="cc" class="payment payment--form"></div>
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
                        </div>
                    </div>
                    <div  class="checkout__take-some view">
                        <div class="checkout__copy view__scroll">
                            <fieldset id="billingInformation" class="fieldset fieldset--frame" data-express-checkout-order-type="CARD">
                                <div class="fieldset__group fieldset__container">
                                    <h2 class="fieldset__take-all fieldset__title">STEP 4: Billing Address</h2>

                                    <!-- First Name -->
                                    <div class="form message">
                                        <%
                                            var billingFirstNameMessage = Html.ValidationMessageFor(m => m.BillingFirstName);
                                            var billingFirstNameIsInvalid = billingFirstNameMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" title="First name can only contain letter characters" data-required="true" autocomplete="section-bill billing given-name" name="BillingFirstName" id="BillingFirstName" placeholder="First Name" class="dtm__restyle form__field <%= billingFirstNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingFirstName"] %>">
                                            <label for="BillingFirstName" class="message__label">
                                                <span class="form__error">* </span>First Name
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingFirstNameIsInvalid)
                                                        { %>
                                                    <%= billingFirstNameMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a first name.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Last Name -->
                                    <div class="form message">
                                        <%
                                            var billingLastNameMessage = Html.ValidationMessageFor(m => m.BillingLastName);
                                            var billingLastNameIsInvalid = billingLastNameMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="BillingLastName" id="BillingLastName" placeholder="Last Name" data-required="true" autocomplete="section-bill billing family-name" class="dtm__restyle form__field <%= billingLastNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingLastName"] %>">
                                            <label for="BillingLastName" class="message__label">
                                                <span class="form__error">* </span>Last Name
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingLastNameIsInvalid)
                                                        { %>
                                                    <%= billingLastNameMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a last name.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Street -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var billingStreetMessage = Html.ValidationMessageFor(m => m.BillingStreet);
                                            var billingStreetIsInvalid = billingStreetMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="BillingStreet" id="BillingStreet" placeholder="Address" data-required="true" autocomplete="section-bill billing address-line1" class="dtm__restyle form__field <%= billingStreetIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingStreet"] %>">
                                            <label for="BillingStreet" class="message__label">
                                                <span class="form__error">* </span>Address
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingStreetIsInvalid)
                                                        { %>
                                                    <%= billingStreetMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter an address.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Street 2 -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var billingStreet2Message = Html.ValidationMessageFor(m => m.BillingStreet2);
                                            var billingStreet2IsInvalid = billingStreet2Message != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="BillingStreet2" id="BillingStreet2" placeholder="Address 2" aria-describedby="BillingStreet2Description" autocomplete="section-bill billing address-line2" class="dtm__restyle form__field <%= billingStreet2IsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingStreet2"] %>">
                                            <label for="BillingStreet2" class="message__label">
                                                Address 2
                                            </label>
                                            <span class="message__group" role="alert">
                                                <small id="BillingStreet2Description" class="message__label">
                                                    Example: Suite / Apt., etc.
                                                </small>
                                                <span class="message__invalid">
                                                    <% if (billingStreet2IsInvalid)
                                                        { %>
                                                    <%= billingStreet2Message %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter an address.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- City -->
                                    <div class="fieldset__take-some form message">
                                        <%
                                            var billingCityMessage = Html.ValidationMessageFor(m => m.BillingCity);
                                            var billingCityIsInvalid = billingCityMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="BillingCity" id="BillingCity" placeholder="City" data-required="true" autocomplete="section-bill billing address-level2" class="dtm__restyle form__field <%= billingCityIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingCity"] %>">
                                            <label for="BillingCity" class="message__label">
                                                <span class="form__error">* </span>City
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingCityIsInvalid)
                                                    { %>
                                                    <%= billingCityMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a city.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- State -->
                                    <div class="fieldset__take-some form message">
                                        <%
                                            var billingStateMessage = Html.ValidationMessageFor(m => m.BillingState);
                                            var billingStateIsInvalid = billingStateMessage != null;
                                        %>
                                        <div class="form__field-label" id="billStateParent">
                                            <div class="form form--select message__select">
                                                <div class="form__contain">
                                                    <%= Html.DropDownListFor(m => m.BillingState, new SelectList(Model.States, "StateCode", "StateName", ViewData["BillingState"]), new { @class="dtm__restyle form__field", @data_required="true", @autocomplete="section-bill billing address-level1" }) %>
                                                    <span class="form__field form__button">
                                                        <svg class="icon">
                                                            <use href="#icon-chevron"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                            <label for="BillingState" class="message__label">
                                                <span class="form__error">* </span>State
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingStateIsInvalid)
                                                        { %>
                                                    <%= billingStateMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please choose a state.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Zip Code -->
                                    <div class="fieldset__take-some form message">
                                        <%
                                            var billingZipMessage = Html.ValidationMessageFor(m => m.BillingZip);
                                            var billingZipIsInvalid = billingZipMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="BillingZip" id="BillingZip" placeholder="Zip Code" data-required="true" autocomplete="section-bill billing postal-code" class="dtm__restyle form__field <%= billingZipIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingZip"] %>">
                                            <label for="BillingZip" class="message__label">
                                                <span class="form__error">* </span>Zip Code
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingZipIsInvalid)
                                                    { %>
                                                    <%= billingZipMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a zip code.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Country -->
                                    <div class="form message" <%=Model.Countries.Count() > 1 ? string.Empty :"style='display:none'" %>>
                                        <%
                                            var billingCountryMessage = Html.ValidationMessageFor(m => m.BillingCountry);
                                            var billingCountryIsInvalid = billingCountryMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <div class="form form--select message__select">
                                                <div class="form__contain">
                                                    <%= Html.DropDownListFor(m => m.BillingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName", ViewData["BillingCountry"]), new { @class="dtm__restyle form__field", @autocomplete = "section-bill billing country" }) %>
                                                    <span class="form__field form__button">
                                                        <svg class="icon">
                                                            <use href="#icon-chevron"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                            <label for="BillingCountry" class="message__label">
                                                <span class="form__error">* </span>Country
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (billingCountryIsInvalid)
                                                        { %>
                                                    <%= billingCountryMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please choose a country.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Phone -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var phoneMessage = Html.ValidationMessageFor(m => m.Phone);
                                            var phoneIsInvalid = phoneMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="tel" name="Phone" id="Phone" placeholder="Phone" data-required="true" autocomplete="section-bill billing tel" class="dtm__restyle form__field <%= phoneIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Phone"] %>">
                                            <label for="Phone" class="message__label">
                                                <span class="form__error">* </span>Phone
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (phoneIsInvalid)
                                                    { %>
                                                    <%= phoneMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter a phone number.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                
                                    <!-- Email -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var emailMessage = Html.ValidationMessageFor(m => m.Email);
                                            var emailIsInvalid = emailMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="email" name="Email" id="Email" title="Format example: someone@someplace.com" data-required="true" autocomplete="section-bill billing email" placeholder="Email" class="dtm__restyle form__field <%= emailIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Email"] %>">
                                            <label for="Email" class="message__label">
                                                <span class="form__error">* </span>Email
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (emailIsInvalid)
                                                    { %>
                                                    <%= emailMessage %>
                                                    <% }
                                                    else
                                                    { %>
                                                    Please enter an email address.
                                                <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>

                            <div class="form message" id="ShippingIsSameDiv" data-express-checkout-order-type="CARD">
                                <div class="form__checkbox-label">
                                    <input
                                        type="checkbox"
                                        id="ShippingIsDifferentThanBilling"
                                        name="ShippingIsDifferentThanBilling"
                                        value="true"
                                        aria-labelledby="ShippingIsDifferentThanBillingLabel" 
                                        />
                                    <input name="ShippingIsDifferentThanBilling" type="hidden" value="false">
                                    <label for="ShippingIsDifferentThanBilling" class="form__label">
                                        <span class="form__checkbox"></span>
                                        <span id="ShippingIsDifferentThanBillingLabel">Check if your shipping address is different than your billing address.</span>
                                    </label>
                                </div>
                            </div>

                            <fieldset id="shippingInformation" class="fieldset fieldset--frame" data-express-checkout-order-type="CARD">
                                <div class="fieldset__group fieldset__container">
                                    <h2 class="fieldset__take-all fieldset__title">STEP 5: Shipping Address</h2>

                                    <!-- First Name -->
                                    <div class="form message">
                                        <%
                                            var shippingFirstNameMessage = Html.ValidationMessageFor(m => m.ShippingFirstName);
                                            var shippingFirstNameIsInvalid = shippingFirstNameMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" title="Name can only contain letters" data-required="true" autocomplete="section-bill shipping given-name" name="ShippingFirstName" id="ShippingFirstName" placeholder="First Name" class="dtm__restyle form__field  shipping__field <%= shippingFirstNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["ShippingFirstName"] %>">
                                            <label for="ShippingFirstName" class="message__label">
                                                <span class="form__error">* </span>First Name
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingFirstNameIsInvalid) { %>
                                                        <%= shippingFirstNameMessage %>
                                                    <% } else { %>
                                                        Please enter a first name.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- Last Name -->
                                    <div class="form message">
                                        <%
                                            var shippingLastNameMessage = Html.ValidationMessageFor(m => m.ShippingLastName);
                                            var shippingLastNameIsInvalid = shippingLastNameMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="ShippingLastName" id="ShippingLastName" placeholder="Last Name"  data-required="true" autocomplete="section-ship shipping family-name" class="dtm__restyle form__field  shipping__field <%= shippingLastNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["ShippingLastName"] %>">
                                            <label for="ShippingLastName" class="message__label">
                                                <span class="form__error">* </span>Last Name
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingLastNameIsInvalid) { %>
                                                        <%= shippingLastNameMessage %>
                                                    <% } else { %>
                                                        Please enter a last name.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- Street -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var shippingStreetMessage = Html.ValidationMessageFor(m => m.ShippingStreet);
                                            var shippingStreetIsInvalid = shippingStreetMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="ShippingStreet" id="ShippingStreet" placeholder="Address" data-required="true" autocomplete="section-ship shipping address-line1" class="dtm__restyle form__field  shipping__field <%= shippingStreetIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["ShippingStreet"] %>">
                                            <label for="ShippingStreet" class="message__label">
                                                <span class="form__error">* </span>Address
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingStreetIsInvalid) { %>
                                                        <%= shippingStreetMessage %>
                                                    <% } else { %>
                                                        Please enter an address.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- Street 2 -->
                                    <div class="fieldset__take-all form message">
                                        <%
                                            var shippingStreet2Message = Html.ValidationMessageFor(m => m.ShippingStreet2);
                                            var shippingStreet2IsInvalid = shippingStreet2Message != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="ShippingStreet2" id="ShippingStreet2" autocomplete="section-ship shipping address-line2" placeholder="Address 2" aria-describedby="ShippingStreet2Description" class="dtm__restyle form__field shipping__field <%= shippingStreet2IsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["ShippingStreet2"] %>">
                                            <label for="ShippingStreet2" class="message__label">
                                                Address 2
                                            </label>
                                            <span class="message__group" role="alert">
                                                <small id="ShippingStreet2Description" class="message__label">Example: Street / Apt., etc.</small>
                                                <span class="message__invalid">
                                                    <% if (shippingStreet2IsInvalid) { %>
                                                        <%= shippingStreet2Message %>
                                                    <% } else { %>
                                                        Please enter an address.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- City -->
                                    <div class="fieldset__take-some form message">
                                        <%
                                            var shippingCityMessage = Html.ValidationMessageFor(m => m.ShippingCity);
                                            var shippingCityIsInvalid = shippingCityMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="ShippingCity" id="ShippingCity" placeholder="City" autocomplete="section-ship shipping address-level2" data-required="true" class="dtm__restyle form__field  shipping__field <%= shippingCityIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["ShippingCity"] %>">
                                            <label for="ShippingCity" class="message__label">
                                                <span class="form__error">* </span>City
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingCityIsInvalid) { %>
                                                        <%= shippingCityMessage %>
                                                    <% } else { %>
                                                        Please enter a city.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- State -->
                                    <div class="fieldset__take-some form message">
                                        <%
                                            var shippingStateMessage = Html.ValidationMessageFor(m => m.ShippingState);
                                            var shippingStateIsInvalid = shippingStateMessage != null;
                                        %>
                                        <div class="form__field-label" id="shipStateParent">
                                            <div class="form form--select message__select">
                                                <div class="form__contain">
                                                    <%= Html.DropDownListFor(m => m.ShippingState, new SelectList(Model.States, "StateCode", "StateName", ViewData["ShippingState"]), new { @class="dtm__restyle form__field shipping__field", @autocomplete = "section-ship shipping address-level1" }) %>
                                                    <span class="form__field form__button">
                                                        <svg class="icon">
                                                            <use href="#icon-chevron"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                            <label for="ShippingState" class="message__label">
                                                <span class="form__error">* </span>State
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingStateIsInvalid) { %>
                                                        <%= shippingStateMessage %>
                                                    <% } else { %>
                                                        Please choose a state.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- Zip Code -->
                                    <div class="fieldset__take-some form message">
                                        <%
                                            var shippingZipMessage = Html.ValidationMessageFor(m => m.ShippingZip);
                                            var shippingZipIsInvalid = shippingZipMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <input type="text" name="ShippingZip" id="ShippingZip" placeholder="Zip Code" autocomplete="section-ship shipping postal-code" data-required="true" class="dtm__restyle form__field <%= shippingZipIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["ShippingZip"] %>">
                                            <label for="ShippingZip" class="message__label">
                                                <span class="form__error">* </span>Zip Code
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingZipIsInvalid) { %>
                                                        <%= shippingZipMessage %>
                                                    <% } else { %>
                                                        Please enter a zip code.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
            
                                    <!-- Country -->
                                    <div class="form message" <%=Model.Countries.Count() > 1 ? string.Empty :"style='display:none'" %>>
                                        <%
                                            var shippingCountryMessage = Html.ValidationMessageFor(m => m.ShippingCountry);
                                            var shippingCountryIsInvalid = shippingCountryMessage != null;
                                        %>
                                        <div class="form__field-label">
                                            <div class="form form--select message__select">
                                                <div class="form__contain">
                                                    <%= Html.DropDownListFor(m => m.ShippingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName", ViewData["ShippingCountry"]), new { @class="dtm__restyle form__field", @autocomplete = "section-ship shipping country" }) %>
                                                    <span class="form__field form__button">
                                                        <svg class="icon">
                                                            <use href="#icon-chevron"></use>
                                                        </svg>
                                                    </span>
                                                </div>
                                            </div>
                                            <label for="ShippingCountry" class="message__label">
                                                <span class="form__error">* </span>Country
                                            </label>
                                            <span class="message__group" role="alert">
                                                <span class="message__invalid">
                                                    <% if (shippingCountryIsInvalid) { %>
                                                        <%= shippingCountryMessage %>
                                                    <% } else { %>
                                                        Please choose a country.
                                                    <% } %>
                                                </span>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </div>

                        <%  
                            NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;  

                            string termsLink = sitemap.GetItemById("terms").Page;
                            string returnLink = sitemap.GetItemById("return-policy").Page;
                        %>
                        <div class="form form--checkbox-border message">
                            <div class="form__checkbox-label">
                                <input id="Terms" name="Terms" type="checkbox" value="True" data-required>
                                <label class="form__label" id="TermsLabel" for="Terms">
                                    <span class="form__checkbox"></span>
                                    <span>I accept the <a  href="<%= returnLink %>" target="_blank">Return Policy</a> and the <a href="<%= termsLink %>" target="_blank">Terms and Conditions</a> of this purchase and use of this website.</span>
                                </label>
                                <div class="message__group" role="alert">
                                    <span id="terms-error-message" class="message__invalid">Please read and accept the Return Policy and the Terms and Conditions of this website.</span>
                                </div>
                            </div>
                        </div>

                        <%-- /////// auto-billing terms  --%>
                        <div id="termsCbxSection" class="form__span-item form message view element-controller__element">
                            <div class="form form--checkbox-border message">
                                <div class="form__checkbox-label">
                                    <input type="hidden" name="subscription" id="subscription" value="False" />
                                    <input
                                        type="checkbox"
                                        id="subscriptionCbx"
                                        name="subscriptionCbx"
                                        data-required="true"
                                        aria-labelledby="subscriptionCbxLabel" />
                                    <label for="subscriptionCbx" class="form__label">
                                        <span class="form__checkbox"></span>
                                        <span id="subscriptionCbxLabel">I understand and agree to the Subscribe and Save terms stated above, agree that my payment information will be reserved for future shipments and agree to receive communications from you as per the policies.</span>
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid" id="subscriptionCbx-error-message">
                                            Please accept the Subscribe and Save terms.
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="checkout__copy checkout__action-text">
                            <div class="checkout__action">
                                <button type="submit" id="AcceptOfferButton" name="acceptOffer">
                                    <span id="AcceptOfferCard" class="button" data-express-checkout-order-type="card">
                                        <span>Process Order</span>
                                    </span>
                                    <div data-express-checkout-buttons></div>
                                </button>
                            </div>
                            <p id="ProcessOrderDisclaimer" data-express-checkout-order-type="card">By clicking Process Order, your credit card will be charged the amount above. Click only once.</p>
                            <div class="checkout__ssl">
                                <img src="/Shared/images/PositiveSSL_tl_trans.png" alt="Secure Site SSL Encryption" width="100" height="100" loading="lazy">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<% } %> 