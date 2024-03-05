<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.Utils" %>
<%@ Import Namespace="FMLSHOP.BlogPosts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%
    ResourceWriter resourceWriter = ViewData["ResourceWriter"] as ResourceWriter ?? new ResourceWriter();   
        
    Response.Write(resourceWriter.WriteStylePreload("css/Site1/index.css"));
    Response.Write(resourceWriter.WriteLink("css/Site1/index.css"));
%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--sitemap section">
    <div id="main" class="view__anchor"></div>
    <div class="content__text">
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="main-title" class="logo-title-hero__title">Site Map</h1>
            </div>
        </div>

    <div class="view__in section__in">
        <div class="section__block content__text">           
            <div class="content__group">
                <%
                    CategoryProductRouterEngine categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

                    var defaultProductCategory = categoryProductRouterEngine.GetCampaignCategoryByCategoryCode("CATEGORY1");
                    List<CategoryProductRouter> categoryProducts = categoryProductRouterEngine.GetProductsByCategoryView(defaultProductCategory).Where(cp => categoryProductRouterEngine.IsValidCategoryProductRouter(cp)).ToList();

                    if (categoryProducts.Count > 0)
                    {
                        %>
                        <nav aria-labelledby="shop-title" class="content__text">
                            <h2 id="shop-title">Products</h2>
                            <ul class="content__list">
                                <%
                                    var parentCampaignCategory = categoryProductRouterEngine.GetParentCategoryByChildCategory(defaultProductCategory);  
                                %>
                                <li><a href="<%= categoryProductRouterEngine.GetRouteToProductCategoryPageByCategoryCode(parentCampaignCategory.Code) %>">View All Products</a></li>
                                <%
                                    categoryProducts.ForEach(categoryProduct =>
                                    {
                                        %>
                                        <li><a href="<%= categoryProduct.RouteToProductDetailPage %>"><%= categoryProduct.CampaignProduct.GetProductTitle() %></a></li>
                                        <%
                                    });  
                                %>
                            </ul>
                        </nav>
                        <%
                    }

                    BlogPostsEngine blogPostsEngine = ViewData["BlogPostsEngine"] as BlogPostsEngine ?? new BlogPostsEngine();

                    string tagSlug = "articles";
                    List<BlogPostView> blogPosts = blogPostsEngine.GetBlogPostsByTagSlug(tagSlug).ToList();

                    if (blogPosts.Count > 0)
                    {
                        %>
                        <nav aria-labelledby="info-title" class="content__text">
                            <h2 id="info-title">Feel Good Blog</h2>
                            <ul class="content__list">
                                <li><a href="<%= blogPostsEngine.GetParentRoute(tagSlug) %>">View All Articles</a></li>
                                <%
                                blogPosts.ForEach(blogPost =>
                                {
                                    %>
                                    <li><a href="<%= blogPostsEngine.GetPermalink(blogPost) %>"><%= blogPost.Title %></a></li>
                                    <%
                                });
                                %>
                            </ul>
                        </nav>
                        <%
                    }

                    NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
                    List<string> itemCodes = new List<string>
                    {
                        "home",
                        "reviews",
                        "science",
                        "story",
                        "customer-service",
                        "shipping-policy",
                        "about",
                        "faq",
                        "facebook-conversation"
                    };

                    if (FMLSHOP.Rules.Expose.Login)
                    {
                        itemCodes.Add("account");
                    }

                    List<NavigationItem> items = sitemap.GetItemsByIdRange(itemCodes);

                    if (items.Count > 0)
                    {
                        %>
                        <nav aria-labelledby="website-title" class="content__text">
                            <h2 id="website-title">Website</h2>
                            <ul class="content__list">
                                <%
                                items.ForEach(item =>
                                {
                                    %>
                                    <li><a href="<%= item.Page %>"><%= item.Name %></a></li>
                                    <%
                                });
                                %>
                            </ul>
                        </nav>
                        <%
                    }
                %>
            </div>
        </div>
    </div>
    </div>
</main>

</asp:Content>