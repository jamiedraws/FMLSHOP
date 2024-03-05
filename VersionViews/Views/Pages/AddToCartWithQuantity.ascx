<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>

<%
    CampaignProductView product = ViewData["Product"] as CampaignProductView ?? null;

    bool isPDP = ViewData["IsPDP"] as bool? ?? true;
    string pageViewName = isPDP ? "PDP" : "PLP";

    string name = product.GetProductName();
    string id = product.ProductCode;
    bool isOOS = product.IsProductOutOfStock();

    string plpQtyId = string.Format("{0}Qty", product.ProductCode);
    string qtyId = string.Format("{0}{1}", plpQtyId, isPDP ? "_PDP" : string.Empty);
    string addCartId = string.Format("{0}-{1}-AddCart", id, pageViewName);
    string outOfStockId = isOOS ? "sold-out" : "";

    string attributeList = string.Format(@"
        id=""element-controller-{0}-{1}"" 
        class=""form form--icon-field-combobox form--label-combobox element-controller__element""",
        product.ProductCode, pageViewName);
%>

<div <%= attributeList %>>
    <% if (product.IsSubscribable) { %>
        <%
            string checkboxId = string.Format("terms-{0}-{1}", id, pageViewName);
            string checkboxLabelId = string.Format("{0}-label", checkboxId);
        %>
        <div class="form form--checkbox message">
          <div class="form__checkbox-label">
              <input
                  type="checkbox"
                  id="<%= checkboxId %>"
                  name="<%= checkboxId %>"
                  required
                  aria-controls="<%= addCartId %>"
                  aria-labelledby="<%= checkboxLabelId %>"
                  data-product-code="<%= id %>" />
              <label for="<%= checkboxId %>" class="form__label">
                  <span class="form__checkbox"></span>
                  <span id="<%= checkboxLabelId %>" class="form__label-text">
                    <%
                        string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];    
                    %>
                    <span><strong>*Subscribe and Save: </strong> Save 20% today when you choose Subscribe and Save. You will then automatically receive a new supply every 30 days, charged to the same payment method used on today's order. You may send an email to <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a> to cancel your subscription. Please contact us at least 3 business days prior to your next billing to avoid being charged for the upcoming month.</span>
 
                    <span>Please note that our subscribe and save discounted offer requires a minimum of 2 months commitment. You will not be billed for your second month until after 30 days from your initial purchase and you can cancel any time after 30 days, by contacting us at <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a>. We do offer a 30-day money-back guarantee with the return of the product.</span>
                  </span>
              </label>
              <div class="message__group" role="alert">
                  <span class="message__invalid">Please check the <b>Subscribe and Save</b> checkbox first.</span>
              </div>
          </div>
        </div>
    <% } %>

    <%
        string colorVariantName = product.PropertyIndexer["Color", string.Empty];
        
        if (!string.IsNullOrWhiteSpace(colorVariantName) && isPDP)
        {
            string colorVariantNameAttribute = colorVariantName.Replace(" ", "-").ToLower();
            %>
            <label for="<%= qtyId %>" data-variant-product-color-name="<%= colorVariantNameAttribute %>" class="form__label"><%= colorVariantName %></label>
            <%
        }
    %>

    <% if (!isOOS) { %>
    <div class="form__contain">
        <button type="button" id="<%= qtyId %>-minus" aria-label="Remove 1 of <%= name %> from your cart" class="form__field form__button" data-shopping-cart-quantity-modifier="minus" aria-controls="<%= qtyId %>" data-shopping-cart-action="update" data-shopping-cart-product-code="<%= product.ProductCode %>">
            <svg class="icon">
                <use href="#icon-minus"></use>
            </svg>
        </button>

        <%
            var qtyPattern = string.Format("[{0}-{1}]", product.MinQuantity, product.MaxQuantity);
        %>

        <input min="<%= product.MinQuantity %>" max="<%= product.MaxQuantity %>" class="form__field form__input" type="number" value="1" aria-label="Current quantity" id="<%= qtyId %>" data-shopping-cart-product-code="<%= product.ProductCode %>" name="<%= qtyId %>" pattern="<%= qtyPattern %>" title="Up to <%= product.MaxQuantity %> are allowed">
        <button type="button" id="<%= qtyId %>-plus" aria-label="Add 1 of <%= name %> to your cart" class="form__field form__button" data-shopping-cart-quantity-modifier="plus" aria-controls="<%= qtyId %>" data-shopping-cart-action="update" data-shopping-cart-product-code="<%= product.ProductCode %>">
            <svg class="icon">
                <use href="#icon-plus"></use>
            </svg>
        </button>
    </div>
    <% } %>

    <%
        if (isOOS)
        {
            string klaviyoFormId = product.PropertyIndexer["KlaviyoFormId", string.Empty];

            if (!string.IsNullOrWhiteSpace(klaviyoFormId))
            {
                %>
                <span class="product__oos-message">Coming Soon</span>
                <button type="button" class="button delay-input" aria-haspopup="true" data-klaviyo-template-id="klaviyo-waitlist-template" data-klaviyo-view-id="klaviyo-waitlist-form" data-klaviyo-form data-klaviyo-product-catalog-id="<%= product.CampaignProductId %>" data-modal-dialog-id="klaviyo-waitlist-placeholder" data-modal-dialog-actor="open" data-modal-dialog-title="Join the Waitlist" hidden>
                    <span>Join the Waitlist</span>
                </button>
                <%
            } 
            else
            {
                %>
                <div class="button button--view-products">
                    <span>SOLD OUT</span>
                </div>
                <%
            }
        }
        else
        {
            %>
            <button type="button" id="<%= addCartId %>" aria-controls="<%= qtyId %>" data-modal-dialog-id="customer-cart" data-modal-dialog-actor="open" data-modal-dialog-type="document" data-modal-dialog-title="Customer Cart Status" data-shopping-cart-action="increment" data-shopping-cart-product-code="<%= product.ProductCode %>" class="button" id="<%= outOfStockId %>">Add To Cart</button>
            <%
        }
    %>
</div>