<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>

<%
    // instance provided by the controller
    var categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

    // the current campaign product
    var variantProducts = ViewData["VariantProducts"] as List<CampaignProductView> ?? new List<CampaignProductView>();

    var ownerProduct = ViewData["OwnerProduct"] as CampaignProductView ?? new CampaignProductView();

    // represents the unique index used to increment over other sibling variant products
    var index = ViewData["Index"] as int? ?? 0;

    // label displays on PDP but not when in grid view
    var IsPDP = ViewData["IsPDP"] as bool? ?? true;

    var pageViewName = IsPDP ? "PDP" : "PLP";

    if (variantProducts.Count() > 1) {
%>
<fieldset class="product-variant product-variant--container delay-input delay-input--for-variant-products">
    <div class="product-variant__group">
        <% foreach (var variantProduct in variantProducts) {
                var defaultQuantity = variantProduct == ownerProduct;
                var categoryProduct = categoryProductRouterEngine.GetCategoryProductByCampaignProductView(variantProduct);
                var isOos = variantProduct.IsProductOutOfStock();

                var labelClassList = "product-variant product-variant--button";
                var radioAttributeList = string.Format(@"
                    type=""radio"" 
                    data-variant-product-controller 
                    name=""VariantGroup-{0}-{1}"" 
                    value=""{2}"" 
                    data-variant-product-route=""{3}""
                    class=""product-variant__radio element-controller__controller""
                    aria-controls=""element-controller-{2}-{5}""
                    id=""{2}-{5}""",
                    ownerProduct.ProductCode,
                    index,
                    variantProduct.ProductCode,
                    categoryProduct.RouteToProductDetailPage,
                    isOos ? "oosRadioProduct" : "radioProduct",
                    pageViewName);
                
                string inputLabel = variantProduct.GetInputLabel();

                if (defaultQuantity)
                {
                    labelClassList = String.Format("{0} product-variant--button-is-selected", labelClassList);
                    radioAttributeList = string.Format(@"checked aria-checked=""true"" {0}", radioAttributeList);
                }
        %>
            <label class="<%= labelClassList %>">
                <input <%= radioAttributeList %>/>
                <span class="product-variant__radio"></span>
                <span class="product-variant__label">
                    <span class="product-variant__name">
                        <%= inputLabel %>
                        <% if (inputLabel.Contains("Subscribe")) { %>
                            <button type="button" data-modal-dialog-id="first-order-disclaimer-container" data-modal-dialog-actor="open" aria-haspopup="true" class="promo-banner__link">See details</button>
                        <% } %>
                    </span>
                    <span class="product-variant__price"><%= variantProduct.FormatPriceHTML() %></span>
                </span>
            </label>
        <% } %>
    </div>
</fieldset>
<% } %>