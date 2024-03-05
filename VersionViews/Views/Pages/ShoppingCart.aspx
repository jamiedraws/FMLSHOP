<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="preload" href="/css/Site1/checkout.css" as="style" />
    <link rel="stylesheet" href="/css/Site1/checkout.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%-- 8. View Cart --%>
<main aria-labelledby="account-title" class="view store section">
  <div id="main" class="view__anchor"></div>
  <div class="view__in section__in">
      <div class="section__block checkout account">
          <h1 id="story-title" class="store__banner">Your Cart</h1>
          <div class="store__contain store__copy">
            <%
                var categoryProductRouterEngine = new CategoryProductRouterEngine();

                var subTotal = DtmContext.ShoppingCart.SubTotal.ToString("C");
                var shoppingCartItems = DtmContext.ShoppingCart.Items
                    .Where(i => i.CampaignProduct.ProductTypeId == 1 || i.CampaignProduct.ProductTypeId == 2 || i.CampaignProduct.ProductTypeId == 8)
                    .Select(sc => categoryProductRouterEngine.GetCategoryProductByCampaignProductView(sc.CampaignProduct))
                    .ToList();
                var hasItems = (shoppingCartItems.Count() > 0) ? true : false;

                var landingPageUrl = string.Format("/{0}/{1}/{2}{3}#products",
                    DtmContext.OfferCode,
                    DtmContext.Version,
                    "Index",
                    DtmContext.ApplicationExtension);

                var exitUrl = string.Format("/{0}/{1}/{2}{3}",
                      DtmContext.OfferCode,
                      DtmContext.Version,
                      "Checkout",
                      DtmContext.ApplicationExtension);

                if (hasItems)
                {
            %>
                <div style="display:none">
                    <% Html.RenderPartial("OrderFormReviewTable"); %>
                </div>
              <div class="store__group" id="cartContainer">
                  <form class="store__form store__copy">
                      <h2 class="store__header">Products</h2>

                      <div class="product-grid">
                        <div class="product-grid__group">
                        <% 
                            foreach (var cartItem in shoppingCartItems) {
                                Html.RenderPartial("CategoryProduct", new ViewDataDictionary
                                {
                                    { "CategoryProductRouterEngine", categoryProductRouterEngine },
                                    { "CategoryProduct", cartItem },
                                    { "IsPDP", false },
                                    { "IsShoppingCart", true }
                                });
                            } 
                        %>
                        </div>
                    </div>
                  </form>
                  <aside class="store__sidebar">
                      <div class="store__copy view__scroll">
                          <h2 class="store__header">
                              <span>Order Summary</span>
                          </h2>
                          <div role="status" class="store__group checkout__order-item">
                              <span>Sub Total</span>
                              <span id="summarySubTotal"><%=subTotal%></span>
                          </div>
                          <hr />
                          <nav aria-label="Order summary" class="store__group store__nav">
                            <a href="<%= exitUrl %>" id="order-summary-checkout" class="button button--second">Proceed To Checkout</a>
                            <a href="<%= landingPageUrl %>" id="order-summary-shopping" class="button button--second">Continue Shopping</a>
                          </nav>
                      </div>
                  </aside>
              </div>
            <% } else { %>
              <div class="store__space store__copy">
                <h2 class="store__header">Details</h2>
                <p>Your cart is currently empty.</p>
                <a href="<%= landingPageUrl %>" class="button button--second">Continue Shopping</a>
              </div>
            <% } %>
          </div>
      </div>
  </div>
</main>

</asp:Content>