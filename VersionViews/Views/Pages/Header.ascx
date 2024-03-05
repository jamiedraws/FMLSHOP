<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.ClientSites.Web" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="FMLSHOP.PromoCodeHelper" %>

<%
    int cartQuantity = DtmContext.ShoppingCart.Where(sc => string.Equals(sc.CampaignProduct.PropertyIndexer["ExcludeFromCartCount", string.Empty], "true", StringComparison.InvariantCultureIgnoreCase) && sc.CampaignProduct.ProductTypeId != 8).Sum(sc => sc.Quantity);

    bool isStartPage = DtmContext.Page.IsStartPageType && DtmContext.PageCode != "PaymentForm";
    var id = DtmContext.VersionId;

    string productAttributeName = SettingsManager.ContextSettings["Label.ProductName"];
    string productName = productAttributeName;

    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
    NavigationItem index = sitemap.GetItemById("home");

    string logo = string.Format(@"<img src=""/images/Site1/logo.svg"" alt=""{0}"" width=""90"" height=""90"">", productAttributeName);

    if (isStartPage)
    {
        logo = string.Format(@"
            <a 
                href=""{0}"" 
                id=""navbar-logo"" 
                class=""nav__logo"" 
                aria-label=""{1}"">
                {2}
            </a>
        ", index.Page, productAttributeName, logo);
    }
    else
    {
        logo = string.Format(@"
            <div class=""nav__logo"">{0}</div>
        ", logo);
    }

    string logoTagline = string.Format(@"
        <div class=""nav__logo-tagline"">
            {0}
        </div>
    ", logo);

    bool eligibleForNav = DtmContext.PageCode != "QR";
    string navClassList = string.Format(@"section nav {0}", isStartPage ? "nav--is-start-page" : "nav--is-end-page");
%>

<% if (isStartPage) { %>
<div data-nav-tracker></div>
<% } %>

<nav id="nav" aria-label="Website page links" class="<%= navClassList %>">
    <span class="skip-link delay-render">
        <a href="#main" class="skip-link__button" id="skip-link"><span>Skip To Main Content?</span></a>
    </span>

    <% if (isStartPage) { %>
    <template data-modal-dialog-template>
        <section id="first-order-disclaimer-container" aria-labelledby="first-order-disclaimer-title" data-modal-dialog-title="10% Off First Order Disclaimer" data-modal-dialog-container class="view content content--modal section">
            <div id="first-order-disclaimer" class="view__anchor"></div>
            <div class="view__in content__text section__in">
                <h2 id="first-order-disclaimer-title">Disclaimer</h2>
                <div class="content__text">
                    <%
                        string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];    
                    %>
                    <p><strong>*Subscribe and Save: </strong> Save 20% today when you choose Subscribe and Save. You will then automatically receive a new supply every 30 days, charged to the same payment method used on today's order. You may send an email to <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a> to cancel your subscription. Please contact us at least 3 business days prior to your next billing to avoid being charged for the upcoming month.</p>
 
                    <p>Please note that our subscribe and save discounted offer requires a minimum of 2 months commitment. You will not be billed for your second month until after 30 days from your initial purchase and you can cancel any time after 30 days, by contacting us at <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a>. We do offer a 30-day money-back guarantee with the return of the product.</p>
                </div>
            </div>
        </section>
    </template>
    <% } %>


        <div class="section__in nav__in nav__group">
            <%= logoTagline %>

            <% if (isStartPage) { %>
            <% if (eligibleForNav) { %>
            <button type="button" class="nav__label" aria-label="Toggle Menu">
                <span></span>
            </button>
            <div class="nav__underlay"></div>
            <div class="nav__pane">
                <div class="nav__list">
                    <%= logoTagline.Replace("navbar-logo", "navbar-header-logo") %>

                    <%
                        CategoryProductRouterEngine categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

                        Func<CategoryProductRouter, string> renderProductLink = ((CategoryProductRouter categoryProduct) =>
                        {
                            string imageHTML = @"<picture><img src=""/images/Site1/products/default.svg"" alt="""" loading=""lazy"" width=""100"" height=""100""></picture>";
                            string productSlug = categoryProduct.CampaignProduct.PropertyIndexer["UrlSlug"];
                            ProductImages productImage = new ProductImages(productSlug, "images/Site1/nav/products/" + productSlug);
                            string productRoute = categoryProduct.RouteToProductDetailPage;
                            string productNavName = categoryProduct.CampaignProduct.GetProductShortName();

                            if (productImage.Images.Any())
                            {
                                imageHTML = productImage.BuildHTMLPictureElement(productImage.GetFirstFallbackImage(), true);
                            }

                            return string.Format(@"<a href=""{0}""><span>{1}</span></a>",
                                productRoute,
                                productNavName
                            );
                        });

                        Func<string, string, string> renderCategoryProductList = ((string categoryCode, string linkName) =>
                        {
                            string HTML = string.Empty;

                            var captureCampaignCategory = categoryProductRouterEngine.ProductCategories.Where(pc => pc.Code.Equals(categoryCode));

                            if (captureCampaignCategory.Any())
                            {
                                var campaignCategory = captureCampaignCategory.FirstOrDefault();
                                var categoryProducts = categoryProductRouterEngine
                                    .GetProductsByCategorySlug(campaignCategory.RedirectUrl)
                                    .Where(cp => categoryProductRouterEngine.IsValidCategoryProductRouter(cp))
                                    .ToList();

                                if (categoryProducts.Any())
                                {
                                    string productLinkHTML = string.Empty;

                                    categoryProducts.ForEach(categoryProduct =>
                                    {
                                        productLinkHTML += renderProductLink(categoryProduct);
                                    });

                                    var parentCampaignCategory = categoryProductRouterEngine.GetParentCategoryByChildCategory(campaignCategory);
                                    string productListingRoute = categoryProductRouterEngine.CreateRouteToProductListingPage(categoryProductRouterEngine.CreateRouteToProductCategoryPage(parentCampaignCategory.RedirectUrl), campaignCategory);

                                    string productCategoryRoute = categoryProductRouterEngine.CreateRouteToProductCategoryPage(parentCampaignCategory.RedirectUrl);

                                    HTML = string.Format(@"
                                    <div class=""flyout flyout--full-width-container delay-input flyout--products-view delay-input--for-flyout"" data-flyout-allow-hover>
                                        <button type=""button"" class=""flyout__button nav__link"" aria-controls=""{0}-container"">
                                            <span>{1}</span>
                                            <span class=""flyout__icon-toggle""></span>
                                        </button>
                                        <div id=""{0}-container"" class=""flyout__container"">
                                            <div class=""flyout__content"">
                                                <div class=""product-card"">
                                                    <div class=""product-card__group"">
                                                        {2}
                                                        <a href=""{3}"">
                                                            <span>Shop All Products</span>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    ", categoryCode.ToLower(), linkName ?? campaignCategory.Name, productLinkHTML, productCategoryRoute);
                                }

                            }

                            return HTML;
                        });

                        //Response.Write(renderCategoryProductList("CATEGORY1", "Shop All"));

                        NavigationItem products = sitemap.GetItemById("products");

                        if (sitemap.HasItem(products))
                        {
                            %>
                            <a href="<%= products.Page %>" class="nav__link">
                                <span>Shop All</span>
                            </a>
                            <%
                        }

                        NavigationItem science = sitemap.GetItemById("science");

                        if (sitemap.HasItem(science))
                        {
                            %>
                            <a href="<%= science.Page %>" class="nav__link">
                                <span><%= science.Name %></span>
                            </a>
                            <%
                        }

                        NavigationItem reviews = sitemap.GetItemById("reviews");

                        if (sitemap.HasItem(reviews))
                        {
                            %>
                            <a href="<%= reviews.Page %>" class="nav__link">
                                <span>Real Reviews</span>
                            </a>
                            <%
                        }

                        NavigationItem faq = sitemap.GetItemById("faq");

                        if (sitemap.HasItem(faq))
                        {
                            %>
                            <a href="<%= faq.Page %>" class="nav__link">
                                <span><%= faq.Name %></span>
                            </a>
                            <%
                        }

                        NavigationItem story = sitemap.GetItemById("story");

                        if (sitemap.HasItem(story))
                        {
                            %>
                            <a href="<%= story.Page %>" class="nav__link">
                                <span><%= story.Name %></span>
                            </a>
                            <%
                        }

                        NavigationItem blog = sitemap.GetItemById("blog");

                        if (sitemap.HasItem(blog))
                        {
                            %>
                            <a href="<%= blog.Page %>" class="nav__link">
                                <span>Blogs</span>
                            </a>
                            <%
                        }

                        NavigationItem customerService = sitemap.GetItemById("customer-service");

                        if (sitemap.HasItem(customerService))
                        {
                            %>
                            <a href="<%= customerService.Page %>" class="nav__link">
                                <span>Say Hello</span>
                            </a>
                            <%
                        }
                    %>
                </div>
            </div>
            <% } %>
            <div class="nav__actions">
                <div class="text-button-icon">
                    <div class="text-button-icon__group">
                        <div id="search-form" class="flyout flyout--full-width-container delay-input delay-input--for-flyout">
                            <button type="button" class="flyout__button text-button-icon__button" aria-label="Toggle Search Form" aria-controls="search-form-container">
                                <svg class="icon text-button-icon__icon">
                                    <use href="#icon-search"></use>
                                </svg>
                            </button>
                            <div id="search-form-container" class="flyout__container">
                                <div class="flyout__content">
                                    <form action="/Search?cver=<%= DtmContext.VersionId %>" data-processing-message="Searching" method="post" class="view search-form section">
                                        <input id="text" name="text" type="hidden" value="">
                                        <input id="versionNumber" name="versionNumber" type="hidden" value="<%= DtmContext.Version.ToString("N4") %>">
                                        <div class="view__in search-form__in section__in">
                                            <div class="search-form__group message message--search">
                                                <div class="search-form__field message__select">
                                                    <div class="form form--field-button form--search">
                                                        <div class="form__contain form__field-button">
                                                            <input type="text" id="textS" name="textS" required data-required aria-label="Product Search" placeholder="Search..." title="Search for a product by name or by type" pattern="^[a-zA-Z0-9()-_ ]*$" class="form__field">
                                                            <button type="submit" class="button form__button">
                                                                <span>Search</span>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="message__group" role="alert">
                                                    <span class="message__invalid">
                                                        Please enter a valid search term
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <%
                            NavigationItem stores = sitemap.GetItemById("find-in-store");
                            
                            if (sitemap.HasItem(stores))
                            {
                                %>
                                <a href="<%= stores.Page %>" aria-label="<%= stores.Name %>" class="text-button-icon__button">
                                    <svg class="icon text-button-icon__icon">
                                        <use href="#icon-location"></use>
                                    </svg>
                                </a>
                                <%
                            }

                            NavigationItem account = sitemap.GetItemById("account");    

                            if (sitemap.HasItem(account) && FMLSHOP.Rules.Expose.Login)
                            {
                                bool isLoggedIn = DtmContext.StoreCustomerId != Guid.Empty;
                                %>
                                <div id="customer-account" class="flyout flyout--for-customer-account delay-input delay-input--for-flyout">
                                    <button type="button" class="flyout__button text-button-icon__button" aria-label="Toggle Customer Account Settings" aria-controls="customer-account-container">
                                        <svg class="icon text-button-icon__icon">
                                            <use href="#icon-person"></use>
                                        </svg>
                                        <svg x="0px" y="0px" viewBox="0 0 87 76" class="flyout__pointer">
	                                        <polygon points="43.5,0.5 0.2,75.5 86.8,75.5"/>
                                        </svg>
                                    </button>
                                    <div id="customer-account-container" class="flyout__container">
                                        <div class="flyout__content customer-account-menubar">
                                            <div class="customer-account-menubar__group">
                                                <a href="<%= account.Page %>">
                                                    <%
                                                        string accountLinkText = isLoggedIn ? "My Account" : "Log in";    
                                                    %>
                                                    <span><%= accountLinkText %></span>
                                                </a>
                                                <% if (isLoggedIn) { %>
                                                <a href="/<%=DtmContext.OfferCode %>/<%=DtmContext.Version %>/Profile/Logout">
                                                    <span>Log out</span>
                                                </a>
                                            <% } %>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%
                            }

                            NavigationItem cart = sitemap.GetItemById("cart");    

                            if (sitemap.HasItem(cart))
                            {
                                %>
                                <button type="button" data-modal-dialog-id="customer-cart" data-modal-dialog-actor="open" data-modal-dialog-type="document" data-modal-dialog-title="Customer Cart Status" aria-label="<%= cart.Name %>" class="text-button-icon__button">
                                    <span class="text-button-icon__group">
                                        <span class="text-button-icon__image">
                                            <svg class="icon text-button-icon__icon">
                                                <use href="#icon-cart"></use>
                                            </svg>
                                        </span>
                                        <span role="status" class="text-button-icon__status cartTotalQtyNumbersOnly"><% 
                                            if (cartQuantity > 0)
                                            { 
                                                Response.Write(cartQuantity);
                                            }
                                            %></span>
                                    </span>
                                </button>
                                <%
                            }
                            %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </nav>