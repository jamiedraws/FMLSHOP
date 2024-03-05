<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<div id="billingInformation" class="store__copy" data-express-checkout-order-type="CARD">
    <fieldset class="fieldset">
        <div class="fieldset__group">
            <h2 class="fieldset__take-all store__header">Billing Address</h2>

            <% if (Model.CurrentCustomer != null && Model.CurrentCustomer.StoreCustomerID != Guid.Empty)
                { %>
                <div class="form__field-label fieldset__take-all">
                    <div class="form form--select message message__select">
                        <div class="form__contain">
                            <select data-prepopulate-address="Billing" class="dtm__restyle form__field">
                                <option value="">Choose a billing address</option>
                                <%foreach (var address in Model.CurrentCustomer.StoreCustomerAddresses)
                                    {
                                        var isDefault = (bool)address.IsDefault && (bool)!address.IsShipping;
                                %>
                                <option
                                    <%if (isDefault)
                                    {%> selected <%} %>
                                    value="<%=address.StoreCustomerAddressID %>"
                                    data-firstname="<%=address.FirstName %>"
                                    data-lastname="<%=address.LastName %>"
                                    data-street="<%=address.Street %>"
                                    data-street2="<%=address.Street2 %>"
                                    data-city="<%=address.City %>"
                                    data-state="<%=address.State %>"
                                    data-zip="<%=address.Zip %>"><%=string.Format("{0} {1} - {2} {3} {4},{5} {6} ", address.FirstName, address.LastName,

                                                address.Street, address.Street2, address.City, address.State, address.Zip) %></option>
                                <% } %>
                            </select>
                            <span class="form__field form__button">
                                <svg class="icon">
                                    <use href="#icon-chevron"></use>
                                </svg>
                            </span>
                        </div>
                    </div>
                </div>
            <%} %>

            <!-- First Name -->
            <div class="form message">
                <%
                    var billingFirstNameMessage = ViewData["BillingFirstNameMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingFirstName);
                    var billingFirstNameIsInvalid = billingFirstNameMessage != null;
                %>
                <div class="form__field-label">
                    <input type="text" title="First name can only contain letter characters" data-required="true" autocomplete="billing given-name" name="BillingFirstName" id="BillingFirstName" placeholder="First Name" class="dtm__restyle form__field <%= billingFirstNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingFirstName"] %>">
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
                    var billingLastNameMessage = ViewData["BillingLastNameMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingLastName);
                    var billingLastNameIsInvalid = billingLastNameMessage != null;
                %>
                <div class="form__field-label">
                    <input type="text" name="BillingLastName" id="BillingLastName" placeholder="Last Name" data-required="true" autocomplete="billing family-name" class="dtm__restyle form__field <%= billingLastNameIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingLastName"] %>">
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
                    var billingStreetMessage = ViewData["BillingStreetMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingStreet);
                    var billingStreetIsInvalid = billingStreetMessage != null;
                %>
                <div class="form__field-label">
                    <input type="text" name="BillingStreet" id="BillingStreet" placeholder="Address" data-required="true" autocomplete="billing address-line1" class="dtm__restyle form__field <%= billingStreetIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingStreet"] %>">
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
                    var billingStreet2Message = ViewData["BillingStreet2Message"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingStreet2);
                    var billingStreet2IsInvalid = billingStreet2Message != null;
                %>
                <div class="form__field-label">
                    <input type="text" name="BillingStreet2" id="BillingStreet2" placeholder="Address 2" aria-describedby="BillingStreet2Description" autocomplete="billing address-line2" class="dtm__restyle form__field <%= billingStreet2IsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingStreet2"] %>">
                    <label for="BillingStreet2" class="message__label">
                        Address 2
                    </label>
                    <span class="message__group" role="alert">
                        <small id="BillingStreet2Description" class="message__label">Example: Suite / Apt., etc.
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
                    var billingCityMessage = ViewData["BillingCityMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingCity);
                    var billingCityIsInvalid = billingCityMessage != null;
                %>
                <div class="form__field-label">
                    <input type="text" name="BillingCity" id="BillingCity" placeholder="City" data-required="true" autocomplete="billing address-level2" class="dtm__restyle form__field <%= billingCityIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingCity"] %>">
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
                    var billingStateMessage = ViewData["BillingStateMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingState);
                    var billingStateIsInvalid = billingStateMessage != null;
                %>
                <div class="form__field-label" id="billStateParent">
                    <div class="form form--select message__select">
                        <div class="form__contain">
                            <%= Html.DropDownListFor(m => m.BillingState, new SelectList(Model.States, "StateCode", "StateName", ViewData["BillingState"]), new { @class="dtm__restyle form__field", @data_required="true", @autocomplete="billing address-level1" }) %>
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
                    var billingZipMessage = ViewData["BillingZipMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingZip);
                    var billingZipIsInvalid = billingZipMessage != null;
                %>
                <div class="form__field-label">
                    <input type="text" name="BillingZip" id="BillingZip" placeholder="Zip Code" data-required="true" autocomplete="billing postal-code" class="dtm__restyle form__field <%= billingZipIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["BillingZip"] %>">
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
                    var billingCountryMessage = ViewData["BillingCountryMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.BillingCountry);
                    var billingCountryIsInvalid = billingCountryMessage != null;
                %>
                <div class="form__field-label">
                    <div class="form form--select message__select">
                        <div class="form__contain">
                            <%= Html.DropDownListFor(m => m.BillingCountry, new SelectList(Model.Countries, "CountryCode", "CountryName", ViewData["BillingCountry"]), new { @class="dtm__restyle form__field", @autocomplete = "billing country" }) %>
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
                    var phoneMessage = ViewData["PhoneMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.Phone);
                    var phoneIsInvalid = phoneMessage != null;
                %>
                <div class="form__field-label">
                    <input type="tel" name="Phone" id="Phone" placeholder="Phone" data-required="true" autocomplete="billing tel" class="dtm__restyle form__field <%= phoneIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Phone"] %>">
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

            <%if (Model.CurrentCustomer != null && Model.CurrentCustomer.StoreCustomerID != Guid.Empty)
                {%>
            <!-- Email -->
            <div style="display: none;">
                <input type="hidden" name="Email" id="Email" value="<%=Model.CurrentCustomer.Email %>">
            </div>
            <%}
                else
                {
            %>
            <div class="fieldset__take-all form message">
                <%
                    var emailMessage = ViewData["EmailMessage"] as MvcHtmlString ?? Html.ValidationMessageFor(m => m.Email);
                    var emailIsInvalid = emailMessage != null;
                %>
                <div class="form__field-label">
                    <input type="email" name="Email" id="Email" title="Format example: someone@someplace.com" data-required="true" autocomplete="billing email" placeholder="Email" class="cartParam dtm__restyle form__field <%= emailIsInvalid ? "message__is-invalid" : string.Empty %>" value="<%= ViewData["Email"] %>">
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
            <%
                }%>
        </div>
    </fieldset>
</div>
