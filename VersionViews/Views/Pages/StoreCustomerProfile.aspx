<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="FMLSHOP.Classes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <%

        var accountType = ViewData["AccountType"] as AccountType?;
        var isPro = accountType.HasValue && accountType.Value == AccountType.Professional;

        switch (Model.Action)
        {
            case "CreateAccount":
    %>
    <%-- 3. Create An Account --%>
    <main aria-labelledby="account-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="account-title" class="logo-title-hero__title">Create <%= isPro ? "a Professional" : "an"  %> Account</h1>
            </div>
        </div>

        <div class=" view__in section__in">
            <div class="section__block store__copy">
                <%
                    using (Html.BeginForm(Model.Action, "Profile", new { isPro = isPro }, FormMethod.Post, new { @class = "store__copy store__form form message fieldset", @data_validate_form = "" }))
                    {
                %>
                    <div class="form">
                        <div class="form__error">
                            <%=Html.ValidationSummary("The following errors have occured")%>
                        </div>
                        <div class="form__label">
                            <span class="form__error">*</span> Indicates a required field
                        </div>
                    </div>
                    <div class="fieldset fieldset--create-account">
                        <div class="fieldset__group">
                            <!-- First Name -->
                            <div class="fieldset__take-some form message">
                                <div class="form__field-label">
                                    <input type="text" id="FirstName" autocomplete="given-name" name="CurrentCustomer.FirstName" placeholder="First Name" data-required="true" data-pattern="^[A-z]+([A-z .,'-]*)?$" class="form__field" required>
                                    <label for="FirstName" class="message__label">
                                        <span class="form__error">* </span>First Name
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter a first name.</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Last Name -->
                            <div class="fieldset__take-some form message">
                                <div class="form__field-label">
                                    <input type="text" id="LastName" autocomplete="family-name" name="CurrentCustomer.LastName" placeholder="Last Name" data-required="true" data-pattern="^[A-z]+([A-z .,'-]*)?$" class="form__field" required>
                                    <label for="LastName" class="message__label">
                                        <span class="form__error">* </span>Last Name
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter a last name.</span>
                                    </div>
                                </div>
                            </div>
                            
<%
                            if(isPro)
                            {
%>
                             <div class="fieldset__take-some form message">
                                <div class="form__field-label">
                                    <input type="text" id="Phone" autocomplete="tel" name="CurrentCustomer.Phone" placeholder="Phone" data-required="true"  class="form__field" required>
                                    <label for="Phone" class="message__label">
                                        <span class="form__error">* </span>Phone
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter a phone number.</span>
                                    </div>
                                </div>
                            </div>
<%
                            }
%>
                            <!-- Email -->
                            <div class="fieldset__take-some form message">
                                <div class="form__field-label">
                                    <input type="email" name="CurrentCustomer.Email" id="EmailAddress" autocomplete="email" placeholder="Email Address" data-required="true" data-pattern="^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$" class="form__field" required>
                                    <label for="EmailAddress" class="message__label">
                                        <span class="form__error">* </span>Email Address
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter an email address.</span>
                                    </div>
                                </div>
                            </div>


                            <!-- Password -->
                            <div class="form message">
                                <div class="form__field-label">
                                    <input type="password" name="CurrentCustomer.Password" id="Password" data-required="true" placeholder="Password" class="form__field" autocomplete="new-password" required>
                                    <label for="Password" class="message__label">
                                        <span class="form__error">* </span>Password
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter a password.</span>
                                    </div>
                                </div>
                            </div>

                            <div class="fieldset__take-all store__nav">
                                <div class="store__group">
                                    <button data-validate-form-type="submit" type="submit" id="Save" value="Save" class="button">Create an account</button>
                                    <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index" class="store__link">Return to Login</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%
                        }
                    %>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <%
            break;
        case "Profile":

            var mode = Request.Params["mode"] ?? string.Empty;
            var errors = TempData["ModelErrors"] as string ?? string.Empty;
            switch (mode)
            {
                case "addAddress":
    %>

    <%-- 7. Add New Address --%>
    <main aria-labelledby="account-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="store__contain store__copy">
                    <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index" class="store__link">Return to Account Details</a>

                    <div class="store__group">
                        <%
                            using (Html.BeginForm("AddAddress", "Profile", FormMethod.Post, new { @class = "store__copy store__form form message", @data_validate_form = "" }))
                            {
                        %>

                        <%if (errors.Length > 0)
                            { %>
                            <div class="form">
                                <div class="form__error">
                                    <div class="validation-summary-errors o-box--msg-error"><span>Please correct the following issues:</span>
                                        <%=TempData["ModelErrors"] %>
                                    </div>
                                </div>
                            </div>
                            <%} %>

                        <fieldset class="fieldset">
                            <div class="fieldset__group">
                                <h1 class="fieldset__take-all store__header">Add New Address</h1>

                                <!-- First Name -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingFirstName" id="FirstName" autocomplete="billing given-name" placeholder="First Name" data-required="true" data-pattern="^[A-z]+([A-z .,'-]*)?$" required class="form__field">
                                        <label for="FirstName" class="message__label">
                                            <span class="form__error">* </span>First Name
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a first name.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Last Name -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingLastName" id="LastName" autocomplete="" placeholder="Last Name" data-required="true" data-pattern="^[A-z]+([A-z .,'-]*)?$" required class="form__field">
                                        <label for="LastName" class="message__label">
                                            <span class="form__error">* </span>Last Name
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a last name.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Street -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.Street" id="Street" autocomplete="billing address-line1" placeholder="Address" data-required="true" required class="form__field">
                                        <label for="Street" class="message__label">
                                            <span class="form__error">* </span>Address
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter an address.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Street 2 -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.Street2" id="Street2" autocomplete="billing address-line2" placeholder="Address 2" class="form__field">
                                        <label for="Street2" class="message__label">Address</label>
                                    </div>
                                </div>

                                <!-- City -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.City" id="City" autocomplete="billing address-level2" placeholder="City" data-required="true" required class="form__field">
                                        <label for="City" class="message__label">
                                            <span class="form__error">* </span>City
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a city.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- State -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <div class="form form--select message__select">
                                            <div class="form__contain">
                                                <%=Html.DropDownListFor(m => m.BillingAddress.State, new SelectList(Model.States, "StateCode", "StateName", Model.BillingAddress.State), new { @class = "form__field", @autocomplete="billing address-level1" })%>
                                                <span class="form__field form__button">
                                                    <svg class="icon icon--combobox">
                                                        <use href="#icon-chevron"></use></svg>
                                                </span>
                                            </div>
                                        </div>
                                        <label for="BillingAddress_State" class="message__label">
                                            <span class="form__error">* </span>State
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please choose a state.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Zip -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.Zip" id="Zip" maxlength="5" autocomplete="billing postal-code" placeholder="Zip Code" data-required="true" required class="form__field">
                                        <label for="Zip" class="message__label">
                                            <span class="form__error">* </span>Zip Code
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a zip code.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Country -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <div class="form form--select message__select">
                                            <div class="form__contain">
                                                <%= Html.DropDownListFor(m => m.BillingAddress.Country,  new SelectList(Model.Countries, "CountryCode", "CountryName", Model.BillingAddress.Country), new { @class="form__field", @autocomplete = "billing country" })%>
                                                <span class="form__field form__button">
                                                    <svg class="icon icon--combobox">
                                                        <use href="#icon-chevron"></use></svg>
                                                </span>
                                            </div>
                                        </div>
                                        <label for="BillingAddress_Country" class="message__label">
                                            <span class="form__error">* </span>Country
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please choose a country.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Default Address -->
                                <div class="form--checkbox fieldset__take-all form message">
                                    <label class="form__checkbox-label">
                                        <input name="IsDefault" value="true" type="checkbox">
                                        <span class="form__checkbox"></span>
                                        <span class="form__label">Set as default address <small>(This address can be applied during checkout)</small></span>
                                    </label>
                                </div>

                                <!-- Shipping Address -->
                                <div class="fieldset__take-all form message">
                                    <label class="form__checkbox-label">
                                        <input name="IsShipping" value="true" type="checkbox">
                                        <span class="form__checkbox"></span>
                                        <span>Set as shipping address</span>
                                    </label>
                                </div>
                            </div>
                        </fieldset>
                        <nav aria-label="Add address or cancel" class="store__nav">
                            <div class="store__group">
                                <button type="submit" data-validate-form-type="submit" class="button">
                                    <span>Add Address</span>
                                </button>
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile">Cancel</a>
                            </div>
                        </nav>
                        <%
                            }
                        %>
                        <div class="store__address">
                            <div class="view__scroll store__copy">
                                <%= Html.Partial("CustomerAddressBook", Model) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%
            break;
        case "editAddress":

            var addressIdParam = Request.Params["addressId"] ?? string.Empty;
            Guid addressId;
            Guid.TryParse(addressIdParam, out addressId);
            var editAddress = Model.CurrentCustomer.StoreCustomerAddresses.Where(s => s.StoreCustomerAddressID == addressId).FirstOrDefault()
                ?? new StoreCustomerAddress();

    %>
    <%-- 6. Edit Address --%>
    <main aria-labelledby="account-title" class="view store section">
        <div id="account" class="view__anchor"></div>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="store__copy">
                    <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index" class="store__link">Return to Account Details</a>

                    <div class="store__group">
                        <%
                            using (Html.BeginForm("EditAddress", "Profile", FormMethod.Post, new { @class = "store__copy store__form form message", @data_validate_form = "" }))
                            {
                                var errorsSummary = Html.ValidationSummary("The following errors have occured");
                        %>
                        <% if (errorsSummary != null) { %>
                            <div class="form">
                                <div class="form__error">
                                    <%= errorsSummary %>
                                </div>
                            </div>
                        <% } %>

                        <fieldset class="fieldset">
                            <div class="fieldset__group">
                                <h1 class="fieldset__take-all store__header">Edit Address</h1>

                                <!-- First Name -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingFirstName" id="FirstName" autocomplete="billing given-name" placeholder="First Name" data-required="true" data-pattern="^[A-z]+([A-z .,'-]*)?$" required class="form__field" value="<%=editAddress.FirstName %>">
                                        <label for="FirstName" class="message__label">
                                            <span class="form__error">* </span>First Name
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a first name.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Last Name -->
                                <div class="form message">
                                    <div class="form__field-label"> 
                                        <input type="text" name="BillingLastName" id="LastName" autocomplete="billing family-name" placeholder="Last Name" data-required="true" data-pattern="^[A-z]+([A-z .,'-]*)?$" required class="form__field" value="<%=editAddress.LastName %>">
                                        <label for="LastName" class="message__label">
                                            <span class="form__error">* </span>Last Name
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a last name.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Street -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.Street" id="Street" autocomplete="billing address-line1" placeholder="Address" data-required="true" required class="form__field" value="<%=editAddress.Street %>">
                                        <label for="Street" class="message__label">
                                            <span class="form__error">* </span>Address
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter an address.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Street 2 -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.Street2" id="Street2" autocomplete="billing address-line2" placeholder="Address 2" class="form__field" value="<%=editAddress.Street2 %>">
                                        <label for="Street2" class="message__label">Address</label>
                                    </div>
                                </div>

                                <!-- City -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.City" id="City" autocomplete="billing address-level2" placeholder="City" data-required="true" required class="form__field" value="<%=editAddress.City %>">
                                        <label for="City" class="message__label">
                                            <span class="form__error">* </span>City
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a city.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- State -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <div class="form form--select message__select">
                                            <div class="form__contain">
                                                <%=Html.DropDownListFor(m => m.BillingAddress.State, new SelectList(Model.States, "StateCode", "StateName", editAddress.State), new { @class="form__field", @autocomplete="billing address-level1" })%>
                                                <span class="form__field form__button">
                                                    <svg class="icon icon--combobox">
                                                        <use href="#icon-chevron"></use></svg>
                                                </span>
                                            </div>
                                        </div>
                                        <label for="BillingAddress_State" class="message__label">
                                            <span class="form__error">* </span>State
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please choose a state.</span>
                                        </div>
                                    </div>
                                </div>
                                <script>
                                    function selectElement(id, valueToSelect) {
                                        let element = document.getElementById(id);
                                        element.value = valueToSelect;
                                    }
                                    selectElement("BillingAddress_State", "<%=editAddress.State%>");
                                </script>
                                <!-- Zip -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <input type="text" name="BillingAddress.Zip" id="Zip" autocomplete="billing postal-code" placeholder="Zip Code" data-required="true" maxlength="5" required class="form__field" value="<%=editAddress.Zip %>">
                                        <label for="Zip" class="message__label">
                                            <span class="form__error">* </span>Zip Code
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please enter a zip code.</span>
                                        </div>
                                    </div>
                                </div>
    
                                <!-- Country -->
                                <div class="form message">
                                    <div class="form__field-label">
                                        <div class="form form--select message__select">
                                            <div class="form__contain">
                                                <%=Html.DropDownListFor(m => m.BillingAddress.Country,  new SelectList(Model.Countries, "CountryCode", "CountryName", editAddress.Country), new { @class="form__field", @autocomplete = "billing country" })%>
                                                <span class="form__field form__button">
                                                    <svg class="icon icon--combobox">
                                                        <use href="#icon-chevron"></use>
                                                    </svg>
                                                </span>
                                            </div>
                                        </div>
                                        <label for="BillingAddress_Country" class="message__label">
                                            <span class="form__error">* </span>Country
                                        </label>
                                        <div class="message__group" role="alert">
                                            <span class="message__invalid">Please choose a country.</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Default Address -->
                                <div class="form--checkbox fieldset__take-all form message">
                                    <label class="form__checkbox-label">
                                        <input name="IsDefault" value="true" type="checkbox" <%=editAddress.IsDefault.HasValue && editAddress.IsDefault.Value ? "checked" : string.Empty %> >
                                        <span class="form__checkbox"></span>
                                        <span class="form__label">Set as default address <small>(This address can be applied during checkout)</small></span>
                                    </label>
                                </div>

                                <!-- Shipping Address -->
                                <div class="fieldset__take-all form message">
                                    <label class="form__checkbox-label">
                                        <input name="IsShipping" value="true" type="checkbox" <%=editAddress.IsShipping.HasValue && editAddress.IsShipping.Value ? "checked" : string.Empty %>  >
                                        <span class="form__checkbox"></span>
                                        <span>Set as shipping address</span>
                                    </label>
                                </div>
                            </div>
                        </fieldset>

                        <nav aria-label="Update address or cancel" class="store__nav">
                            <div class="store__group">
                                <input type="hidden" name="BillingAddress.AddressId" value="<%=addressId %>" />
                                <button type="submit" data-validate-form-type="submit" class="button button--second form_validation_required">Update Address</button>
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index">Cancel</a>
                            </div>
                        </nav>
                        <%
                            }
                        %>
                        <div class="store__address">
                            <div class="view__scroll store__copy">
                                <%= Html.Partial("CustomerAddressBook", Model, new ViewDataDictionary {
    { "customerAddresses", Model.CurrentCustomer.StoreCustomerAddresses.Where(s => s.StoreCustomerAddressID != addressId).ToList() }
                                }) %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <%
            break;
        default:
    %>
    <%-- 5. View Addresses --%>
    <main aria-labelledby="account-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="account-title" class="logo-title-hero__title">My Account</h1>
            </div>
        </div>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="store__contain store__space store__copy">
                    <nav aria-label="Add address" class="store__nav">
                        <div class="store__group">
                            <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile?mode=addAddress" class="button">Add new address</a>
                            <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index" class="store__link">Return to Account Details</a>
                        </div>
                    </nav>

                    <%= Html.Partial("CustomerAddressBook", Model) %>
                </div>
            </div>
        </div>
    </main>
    <%
                break;
            }

            break;
        }
    %>
    <svg class="syg-symbols">
        <symbol id="icon-checkmark" viewBox="0 0 52 52">
            <path d="M14.1 27.2l7.1 7.2 16.7-16.8"/>
        </symbol>
    </svg>
    <script type="text/javascript">
        (function () {

            var eles = document.getElementsByClassName("removeAddress");

            for (var i = 0; i < eles.length; i++) {
                eles[i].addEventListener("click", removeAddress);
            }

            function removeAddress() {
                var xhttp = new XMLHttpRequest();

                xhttp.onreadystatechange = function () {
                    if (this.readyState === 4) {
                        window.location = "/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Profile";
                    }
                }

                xhttp.open("POST", "/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Profile/DeleteAddress", true);

                xhttp.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');

                xhttp.send("addressId=" + this.dataset.addressid);
            }

            
        })();
    </script>
</asp:Content>
