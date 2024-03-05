<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>

<%
    var isStartPage = DtmContext.Page.IsStartPageType;
    var isShoppingCart = string.Equals(DtmContext.PageCode, "shoppingcart", StringComparison.OrdinalIgnoreCase);
    var isCheckout = string.Equals(DtmContext.PageCode, "checkout", StringComparison.OrdinalIgnoreCase);
%>

<script src="/shared/js/jquery.min.js"></script>
<script type="text/javascript" src="/shared/js/common.js"></script>
<script>
    addEventListener("SessionLoaded", function () {
        handleCartChange();
    });
</script>

<% if (isStartPage)
    { 
        var sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
        var cart = sitemap.GetItemById("cart");
    %>
        <script type="text/templates" id="CustomerCartStatusTemplate">
            <section id="customer-cart-status" data-modal-dialog-container data-modal-dialog-title="Customer Cart Status" aria-labelledby="customer-cart-status-title" class="view customer-cart-status section">
                <div class="view__in customer-cart-status__in section__in">
                    <div class="customer-cart-status__group">
                        <div id="customer-cart-status-title" class="customer-cart-status__response">{{Status}}</div>
                        <div data-template-test class="customer-cart-status__action">
                            <button type="button" data-modal-dialog-actor="close" data-modal-dialog-id="customer-cart-status" class="button customer-cart-status__button">
                                <span>Continue Shopping</span>
                            </button>
                        </div>
                        <div class="customer-cart-status__action">
                            <a href="<%= cart.Page %>" class="button customer-cart-status__button">
                                <span>Checkout</span>
                            </a>
                        </div>
                    </div>
                </div>
            </section>
        </script>

        <%= Html.Partial("WaitlistForm") %>
    
    <% Html.RenderPartial("FrameworkJs");

        if (isCheckout)
        {%>
        <script>
            $(window).on("load", function () {
                $('.ddlPromoButton').on('keyup keypress', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
                    }
                });

                document.getElementById("AcceptOfferButton").addEventListener("click", validateForm);
            });
			
			//disable enter key on loginForm submitButtons
            $('#loginForm').on("keydown", ":input:not(:submit)", function (event) {
                if (event.key == "Enter") {
                    event.preventDefault();
                }
            });

            //Logic to handle prepopulation of addresses for Current Customers
            $('[data-prepopulate-address]').on('change', function () {

                let dropDown = $(this);
                let dValue = dropDown.val();
                let type = $(this).data('prepopulate-address');

                if (dValue != "") {
                    let option = $('option[value=' + dValue + ']');
                    if (typeof option !== "undefined") {
                        $('#' + type + 'FirstName').val(option.attr('data-firstName'));
                        $('#' + type + 'LastName').val(option.attr('data-lastName'));
                        $('#' + type + 'Street').val(option.attr('data-street'));
                        $('#' + type + 'Street2').val(option.attr('data-street2'));
                        $('#' + type + 'City').val(option.attr('data-city'));
                        $('#' + type + 'State').val(option.attr('data-state'));
                        $('#' + type + 'Zip').val(option.attr('data-zip'));
                    }
                }

            });

            $('#ShippingIsDifferentThanBilling').on('click', function () {
                $('[data-prepopulate-address]').change();
            });

            if ("_dtm" in window && "expressCheckout" in _dtm) {
                 _dtm.expressCheckout = function () {};
            }
        </script>
       
      <%} else { %>
        <div class="hide">
            <%= Html.Partial("OrderFormReviewTable") %>
        </div>
     <% } %>

<% }  %>

<div class="l-controls left-absolute top-absolute @print-only-hide">
    <% Html.RenderSiteControls(SiteControlLocation.ContentTop); %>
    <% Html.RenderSiteControls(SiteControlLocation.ContentBottom); %>
    <% Html.RenderSiteControls(SiteControlLocation.PageBottom); %>
</div>

