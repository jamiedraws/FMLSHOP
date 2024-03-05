<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>

<%
    // instance provided by the controller
    var categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

    // the current category product
    var categoryProduct = ViewData["CategoryProduct"] as CategoryProductRouter ?? new CategoryProductRouter();

    var categoryCode = ViewData["Category"] as string ?? string.Empty;
    var categoryModifier = ViewData["CategoryModifier"] as string ?? string.Empty;

    // represents the unique index to increment through other related category product entries
    var index = ViewData["Index"] as int? ?? 0;

    var id = ViewData["Id"] as string ?? "default";

    // the current campaign product
    var product = categoryProduct.CampaignProduct;

    if (product != null)
    {
        // the name of the product
        var name = product.GetProductTitle();

        var productCode = product.ProductCode;

        // the images associated with the current product
        var productImages = ViewData["ProductImages"] as ProductImages ?? new ProductImages(productCode, "images/Site1/products/" + productCode);
        
        // represents the BazaarVoice product id
        var bazaarVoiceId = product.PropertyIndexer["BazaarVoiceID"];

        // determines if there is a BazaarVoice product id
        var hasBazaarVoice = !string.IsNullOrWhiteSpace(bazaarVoiceId);

        // image and name overrides (using for replacement heads to show under "new")
        var categoryListingNameOverride = product.PropertyIndexer["CategoryListingNameOverride"];

        var routeToProductDetailPage = categoryProduct.RouteToProductDetailPage;

        if (routeToProductDetailPage.Contains("#"))
        {
            var productDetailPageUri = new Uri(DtmContext.Domain.FullDomainCustomPath(routeToProductDetailPage));

            routeToProductDetailPage = routeToProductDetailPage.Replace(productDetailPageUri.Fragment, string.Format("?cver={0}{1}", DtmContext.VersionId, productDetailPageUri.Fragment));
        } 
        else
        {
            routeToProductDetailPage = string.Format("{0}", routeToProductDetailPage, DtmContext.VersionId);
        }
%> 

<div class="category-product category-product--listing element-controller <%= categoryModifier %>" data-variant-product-permalink="<%= categoryProduct.RouteToProductDetailPage %>">
    <a href="<%= routeToProductDetailPage %>" class="category-product__picture product">
        <div class="product__image product__image-container">
			<%
				string firstImage = productImages.GetFallbackImages().FirstOrDefault() 
                    ?? productImages.GetFirstFallbackImage() 
                    ?? string.Empty;

                bool hasImage = !string.IsNullOrEmpty(firstImage);

                if (!hasImage)
                {
                    %>
                    <img src="/images/Site1/products/default.svg" alt="" width="500" height="500" loading="lazy" />
                    <%
                }

                if (hasImage)
                {
                    string picture = productImages.BuildHTMLPictureElement(firstImage, true);

                    string vimeoId = product.PropertyIndexer["AnimationVimeoId", string.Empty];

                    bool hasVimeoId = !string.IsNullOrWhiteSpace(vimeoId);

                    if (hasVimeoId)
                    {
                        %>
                        <div class="slide slide--fade slide--product-beauty-shot contain contain--product-beauty-shot">
                            <div class="slide__into" id="product-beauty-shot-carousel-<%= product.ProductCode %>">
                                <div class="slide__item">
                                    <%= picture %>
                                </div>
                                <div class="slide__item">
                                    <div id="product-beauty-shot-animation-<%= id %>-<%= product.ProductCode %>-<%= vimeoId %>" data-vimeo-carousel-id="<%= vimeoId %>" class="contain contain--product-beauty-shot"></div>
                                </div>
                            </div>
                        </div>
                        <%
                    }
                    else
                    {
                        Response.Write(picture);
                    }
                }

                if (product.IsProductNew())
                {
                    %>
                    <span class="product__new"><b>New</b></span>
                    <%
                }
			%>
        </div>
    </a>

    <div class="category-product__group">
        <p class="category-product__title"><%= name %></p>

        <div class="category-product__price-reviews">
            <p class="category-product__price"><%= product.FormatPriceHTML() %></p>
        </div>

        <p class="category-product__desc"><%= product.DisplayText %></p>

        <div class="category-product__reviews stars stars--5"></div>
    </div>

    <% if (hasBazaarVoice) {
            var bvRedirectUrl = string.Format("{0}#reviews", DtmContext.Domain.FullDomainCustomPath(categoryProduct.RouteToProductDetailPage));    
        %>
        <div class="contain contain--bazaarvoice-inline-rating">
            <div data-variant-product-type="bazaarvoice-inline-rating" class="contain contain--bazaarvoice-inline-rating">
                <div data-bv-show="inline_rating" data-bv-redirect-url="<%= bvRedirectUrl %>" data-bv-product-id="<%= bazaarVoiceId %>"></div>
            </div>
        </div>
    <% } %>
</div>
<%
    }
%>