<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="FMLSHOP.Classes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <% 
        var url = HttpContext.Current.Request.Url.AbsoluteUri;  
        var uri = new Uri(url);



        if (Request["resettoken"] != null)
        {
    %>
    <main aria-labelledby="account-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="account-title" class="logo-title-hero__title">Reset Your Password</h1>
            </div>
        </div>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="store__group">
                    <% 
                        using (Html.BeginForm("AccountRecovery", "Account", new { resettoken = Request["resettoken"] }, FormMethod.Post, new { @class = "store__copy store__form form message" }))
                        {
                    %>
                    <%= Html.Hidden("Token", Request["resettoken"]) %>
                    <div class="form">
                        <div class="form__error">
                            <%= Html.ValidationSummary("The following errors have occured") %>
                        </div>
                        <div class="form__label">
                            <span class="form__error">*</span> Indicates a required field
                        </div>
                    </div>

                    <div class="fieldset">
                        <div class="fieldset__group">
                            <!-- Email -->
                            <div class="form message">
                                <div class="form__field-label">
                                    <input id="Login" type="email" name="Login" autocomplete="billing email" placeholder="Email Address" data-required="true" data-pattern="^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$" class="form__field" required>
                                    <label for="Login" class="message__label">
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
                                    <input id="Password" maxlength="50" autocomplete="billing new-password" name="Password" type="password" placeholder="Password" data-required="true" class="form__field" required>
                                    <label for="Password" class="message__label">
                                        <span class="form__error">* </span>Password
                                    </label>
                                    <div class="message__group" role="alert">
                                        <span class="message__invalid">Please enter a password.</span>
                                    </div>
                                </div>
                            </div>

                            <div class="fieldset__take-all">
                                <button type="submit" id="customerLogin" name="customerLogin" class="button">Reset</button>
                            </div>
                        </div>
                    </div>

                    <%= Html.HiddenFor(m => m.ReturnUrl) %>
                    <%

                        }
                    %>
                </div>
            </div>
        </div>
    </main>
    <% 
        }
        else if (Request["forgotPassword"] != null)
        {
    %>
    <%-- 2. Forgot Password --%>
    <main aria-labelledby="account-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="account-title" class="logo-title-hero__title">Account</h1>
            </div>
        </div>
        <div class="view__in section__in">
            <div class="section__block checkout">
                <div class="store__group">
                    <div class="store__copy store__form form message">
                        <h2 class="store__header">
                            <span>Returning Customers</span>
                        </h2>
                        <p>We will send you an email to reset your password.</p>
                        <div class="form__label">
                            <span class="form__error">*</span> Indicates a required field
                        </div>
                        <div class="form__field-label">
                            <input type="email" id="Email" placeholder="Email Address" autocomplete="billing email" required data-required="true" data-pattern="^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$" class="form__field">
                            <label class="message__label" for="Email">
                                <span class="form__error">*</span> Email Address</span>
                            </label>
                            <div class="message__group" role="alert">
                                <span class="message__invalid">Please enter a valid email address.</span>
                                <span style="display:none" id="RecoverySuccessMsg">Password Recovery Email has been sent! You may close this tab.</span>
                                <span style="display:none" id="RecoveryErrorMsg">An error occured please check email and try again.</span>
                            </div>
                        </div>
                        <nav aria-label="Recover password or cancel" class="store__nav">
                            <div class="store__group">
                                <button type="button" onclick="submitFp()" class="button button--contrast button--second">Submit</button>
                                or
                            <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Index" class="store__link">Cancel</a>
                            </div>
                        </nav>

                    </div>
                </div>
            </div>
        </div>
    </main>
    <!--
    <div id="submitModal" class="modal" role="dialog" aria-labelledby="modal-text">
        <div class="modal__load-state"></div>
        <div id="submitModalText" class="modal__text">Submitting</div>
    </div>
    -->
    <script>
        let submitting;
        // addEventListener("DOMContentLoaded", function () {
        //     submitting = modal({
        //         modal: {
        //             value: document.getElementById("submitModal")
        //         },
        //         text: {
        //             value: document.getElementById("submitModalText")
        //         },
        //         stateClass: {
        //             value: "modal--is-visible"
        //         }
        //     });
        // });

        function setMessageToValid(element) {
            if (!element) return false;
            element.style = "";
        }

        function setMessageToInvalid(element) {
            if (!element) return false;
            element.classList.add("message__is-invalid");
            element.classList.remove("message__is-valid");
        }

        function removeMessages(element) {
            if (!element) return false;
            element.style = "display:none;";
        }
        let message, errorMsg, emailElement;
        document.addEventListener("DOMContentLoaded", function () {
            message = document.getElementById("RecoverySuccessMsg");
            errorMsg = document.getElementById("RecoveryErrorMsg");
            emailElement = document.getElementById("Email");
            emailElement.addEventListener("keyup", function () {
                
                removeMessages(message);
                removeMessages(errorMsg)
            });
        });

        function submitFp() {
            if (emailElement) {
                var email = emailElement.value;
                if (validEmail(email)) {
                    removeMessages(message);
                    emailElement.classList.remove("message__is-valid");
                    emailElement.classList.remove("message__is-invalid");
                    // submitting.show();
                    var xhttp = new XMLHttpRequest();

                    xhttp.addEventListener("error", function () {
                        setMessageToValid(errorMsg);
                    });

                    xhttp.addEventListener("loadend", function () {
                        try {
                            let response = JSON.parse(xhttp.responseText);
                            message.textContent = response.message;
                            setMessageToValid(message);
                        } catch (error) {
                            errorMsg.textContent = error;
                            setMessageToValid(errorMsg);
                        }
                    });


                    xhttp.open("POST", "/Cart/ForgotMyPassword?email=" + email, true);
                    xhttp.send();
                } else {
                    removeMessages(message);
                    removeMessages(errorMsg);
                    setMessageToInvalid(emailElement);
                }
            }
        }

        function validEmail(value) {
            let emailReg = /^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/;
            if (value === undefined || value === null && value.trim() === "") {
                return false;
            } else if (!emailReg.test(value)) {
                return false;
            }
            return true;
        }
    </script>
    <%
        }
        else
        {


    %>
    <%-- 1. Login / Login Fail --%>
    <main aria-labelledby="account-title" class="view store section">
        <div id="main" class="view__anchor"></div>
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="account-title" class="logo-title-hero__title">Account</h1>
            </div>
        </div>
        <div class="view__in section__in">
            <div class="section__block checkout store">
                <div class="store__contain view">
                    <div class="view__anchor" id="login-destination"></div>
                    <div class="store__group">
                        <% 
                            using (Html.BeginForm("Login", "Profile", new { cver=DtmContext.VersionId },FormMethod.Post, new { @class = "store__copy store__form form message", @data_validate_form = "" }))
                            {
                        %>
                        <h2 class="store__header">Returning Customers</h2>
                        <div class="form__error">
                            <%= Html.ValidationSummary("The following errors have occured") %>
                        </div>
                        <div class="form__label">
                            <span class="form__error">*</span> Indicates a required field
                        </div>
                        <div class="form__field-label">
                            <input id="Login" type="email" name="Login" placeholder="Email Address" autocomplete="email" data-required="true" required data-pattern="^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$" class="form__field">
                            <label for="Login" class="message__group">
                                <span class="message__label"><span class="form__error">* </span>Email Address</span>
                            </label>
                            <div class="message__group" role="alert">
                                <span class="message__invalid">Please enter an email address.</span>
                            </div>
                        </div>
                        <div class="form__field-label">
                            <input id="Password" maxlength="50" name="Password" type="password" autocomplete="current-password" data-required="true" required placeholder="Password" class="form__field">
                            <label for="Password" class="message__group">
                                <span class="message__label"><span class="form__error">* </span>Password</span>
                            </label>
                            <div class="message__group" role="alert">
                                <span class="message__invalid">Please enter a password.</span>
                            </div>
                        </div>
                        <nav aria-label="Login or recover password" class="store__nav">
                            <div class="store__group">
                                <button type="submit" data-validate-form-type="submit" id="customerLogin" name="customerLogin" class="button">Login</button>
                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Account/Login?forgotPassword=1" class="store__link">Forgot your password?</a>
                            </div>
                        </nav>

                        <%= Html.Hidden("ReturnUrl", Request["ReturnUrl"]) %>
                        <%
                            }
                        %>
                        <div class="store__divider divider-line">
                            <span class="burst">Or</span>
                        </div>
                        <aside class="store__sidebar store__copy">
                            <h2 class="store__header">New Customer</h2>
                            <p>Register with us for a faster checkout, to track order history and more.</p>
                            <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Profile/CreateAccount" class="button">Create an account</a>
                            <p class="store__login-direction-desktop">
                                <small>If you already have an account please login to the left on this page.</small>
                            </p>
                            <p class="store__login-direction-mobile">
                                <small>If you already have an account <a href="#login-destination">please login</a>.</small>
                            </p>
                        </aside>

                    </div>
                </div>
            </div>
        </div>
    </main>
    <% 

        }
    %>
</asp:Content>
