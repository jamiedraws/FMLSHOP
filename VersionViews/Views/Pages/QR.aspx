<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.BlogPosts" %>
<%@ Import Namespace="FMLSHOP.Utils" %>
<%@ Import Namespace="FMLSHOP.Models" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;

    bool isCustomerLoggedOut = Model.CurrentCustomer == null || Model.CurrentCustomer.StoreCustomerID == Guid.Empty;
%>

<% if (isCustomerLoggedOut && FMLSHOP.Rules.Expose.Login) { %>
<section aria-labelledby="customer-login-title" class="view customer-login-banner section">
    <div class="view__in section__in">
        <div class="section__block">
            <div class="customer-login-banner__group">
                <div class="customer-login-banner__text">
                    <h2 id="customer-login-title" class="customer-login-banner__title">Get Access to Exclusive Content</h2>
                    <p>Login or create an account to get free exclusive access to mindset workshops, physical movement tips and workouts, and overall health tips and advice from our medical team.</p>
                </div>
                <div class="customer-login-banner__actions">
                <%
                    NavigationItem login = sitemap.GetItemById("login"); 
                    
                    if (sitemap.HasItem(login))
                {
                    %>
                    <a href="<%= login.Page %>" class="button">
                        <span>Login</span>
                    </a>
                    <%
                }
                %>
                  <span>or</span>  
                <%
                    NavigationItem createAccount = sitemap.GetItemById("create-account");

                    if (sitemap.HasItem(createAccount))
                {
                    %>
                    <a href="<%= createAccount.Page %>" class="button">
                        <span>Create an Account</span>
                    </a>
                    <%
                }
                %>
                </div>
            </div>
        </div>
    </div>
</section>
<% } %>

<main aria-labelledby="main-title" class="view content content--qr-page section">
    <div id="main" class="view__anchor"></div>
    <div class="view__in section__in">
        <div class="section__block">
            <div class="content__video">
                <div data-src-iframe="https://player.vimeo.com/video/808715442" data-attr='{ "width" : "525", "height" : "295", "title" : "Welcome Video | Flip My Life", "allow" : "fullscreen" }' class="contain contain--video"></div>
            </div>
        </div>
        <div class="section__block">
            <div class="content__text">
                <h1 id="main-title" class="content__title">Your Daily Flip Starts Now!</h2>
            </div>
        </div>
    </div>
</main>

<section aria-label="Beauty shots and lifestyle images" class="view content content--post-cards section">
    <div id="gallery" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <div class="slide slide--responsive slide--category-products">
            <div class="slide__into" tabindex="0" id="slide-category-products">
            <%
                CategoryProductRouterEngine categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

                List<string> productCodes = new List<string> { "F7V", "F7C", "CPB", "SML" };
                List<CategoryProductRouter> categoryProducts = productCodes.Select(pc => categoryProductRouterEngine.GetCategoryProductByProductCode(pc)).Where(cp => categoryProductRouterEngine.IsValidCategoryProductRouter(cp)).ToList();
                
                foreach (var categoryProduct in categoryProducts)
                {
                    var index = categoryProducts.IndexOf(categoryProduct);

                    %>
                    <div class="slide__item">
                    <%

                    Html.RenderPartial("CategoryProduct", new ViewDataDictionary
                    {
                        { "CategoryProductRouterEngine", categoryProductRouterEngine },
                        { "CategoryProduct", categoryProduct },
                        { "IsPdpPage", "true" },
                        { "Index", index },
                        { "RenderVariantProductRadioGroup", false },
                        { "Id", "slide-category-products" }
                    });

                    %>
                    </div>
                    <%
                }
            %>
            </div>
            <div class="slide__nav">
                <button aria-label="Previous" class="slide__prev" type="button">
                    <svg class="icon">
                        <use href="#icon-double-chevron"></use>
                    </svg>
                </button>
                <button aria-label="Next" class="slide__next" type="button">
                    <svg class="icon">
                        <use href="#icon-double-chevron"></use>
                    </svg>
                </button>
            </div>
        </div>
    </div>
</section>

<div id="accordion" class="view accordion accordion--tabs element-controller section">
    <div class="view__in section__in">
        <div class="section__block">
            <div class="accordion__group">
                <h2 class="accordion__header">
                    <button type="button" class="accordion__button button" aria-controls="faq-section" aria-expanded="true" id="features-title">FAQ</button>
                </h2>
<%--                <h2 class="accordion__header">
                    <button type="button" class="accordion__button button" aria-controls="how-to-section" id="ingredients-title">How To</button>
                </h2>--%>
            </div>
            <section aria-labelledby="features-title" id="faq-section" class="accordion__section">
                <div class="accordion__content">
                    <%= Html.Partial("FAQAccordion") %>
                </div>
            </section>
<%--            <section id="how-to-section" aria-labelledby="ingredients-title" hidden class="accordion__section">
                <div class="accordion__content">
                    <h3>How To</h3>
                    <p>Lorem ipsum dolor, sit amet consectetur adipisicing elit. Itaque iusto, cum eveniet voluptatibus quis quam adipisci nesciunt dignissimos recusandae nobis cupiditate debitis blanditiis veniam inventore eius quia, iste praesentium repellendus!</p>
                </div>
            </section>--%>
        </div>
    </div>
</div>

<section aria-label="Read our latest blog articles" class="view content content--post-cards section">
    <div id="latest-blogs" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <div class="content__group">
            <%
                // the instance provided by the controller
                var blogPostsEngine = ViewData["BlogPostsEngine"] as BlogPostsEngine ?? new BlogPostsEngine();
            
                // the collection of blog posts related to the current category, provided by the controller
                var categoryPosts = ViewData["BlogPosts"] as List<BlogPostView> ?? blogPostsEngine.GetBlogPostsByTagSlug("articles");
            
                // the current blog category post, provided by the controller
                var category = ViewData["BlogCategory"] as BlogPostView ?? new BlogPostView();
            
                // the current category name, provided by the controller
                var categoryTitle = ViewData["BlogCategoryName"] as string ?? ViewData["BlogTagName"] as string ?? string.Empty;
            
                var isCategoryPage = blogPostsEngine.BlogPostExists(category);

                ImageEngine logos = new ImageEngine("brands", "images/brands");

                categoryPosts = categoryPosts
                    .OrderByDescending(cp => cp.Tags.Any(t => string.Equals(t, "EXTERNAL", StringComparison.InvariantCultureIgnoreCase)))
                    .ThenByDescending(cp => cp.ChangeDate).ToList();

                categoryPosts = categoryPosts.GetRange(0,3);

                foreach (var blogPost in categoryPosts)
                {
                    Html.RenderPartial("BlogArticleExcerpt", new ViewDataDictionary
                    {
                        { "BlogPost", blogPost },
                        { "BlogPostsEngine", blogPostsEngine },
                        { "Logos", logos }
                    });
                }
            %>
        </div>
    </div>
</section>

</asp:Content>