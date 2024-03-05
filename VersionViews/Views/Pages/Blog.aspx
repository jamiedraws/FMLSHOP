<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/BlogLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce.Repositories" %>
<%@ Import Namespace="FMLSHOP.BlogPosts" %>
<%@ Import Namespace="FMLSHOP.Utils" %>
<%@ Import Namespace="HtmlAgilityPack" %>

<asp:Content ID="PageMetadata" ContentPlaceHolderID="PageMetadata" runat="server">

<%
    // the product name
    var productName = SettingsManager.ContextSettings["Label.ProductName"];

    // the current blog category post, provided by the controller
    var category = ViewData["BlogCategory"] as BlogPostView ?? new BlogPostView();

    // the current category name, provided by the controller
    var categoryTitle = ViewData["BlogCategoryName"] as string ?? ViewData["BlogTagName"] as string ?? Model.PageTitle;

    // parse and strip html tags from the category description
    var htmlDoc = new HtmlDocument();
    htmlDoc.LoadHtml(category.ShortDescription ?? String.Empty);

    // default category description
    var defaultDescription = DtmContext.Page.MetaDescription ?? string.Empty;

    // the current blog category description
    var categoryDescription = !string.IsNullOrWhiteSpace(category.ShortDescription) 
        ? htmlDoc.DocumentNode.InnerText 
        : defaultDescription;

    // the current blog category image 
    var categoryImage = category.ImageThumbnailPath ?? "";

    // the current blog post permalink route, provided by the controller
    var blogPermalinkRoute = ViewData["BlogPermalinkRoute"] as string;

    // the main blog roll category route, provided by the controller
    var blogCategoryRoute = ViewData["BlogCategoryRoute"] as string;

    // the main blog roll tag route, provided by the controller
    var blogTagRoute = ViewData["BlogTagRoute"] as string;

    var blogUrl = blogPermalinkRoute
        ?? blogCategoryRoute
        ?? blogTagRoute
        ?? string.Empty;

    var categoryMetaTitle = string.Format("{0} | {1}", categoryTitle, productName);    
%>

<title><%= categoryMetaTitle %></title>

<%= Html.Partial("MetaFavicon", new ViewDataDictionary
{
    { "Title", categoryMetaTitle },
    { "Description", categoryDescription },
    { "Url", blogUrl },
    { "Image", categoryImage } 
}) %>

</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%
    ResourceWriter resourceWriter = ViewData["ResourceWriter"] as ResourceWriter ?? new ResourceWriter();   
        
    Response.Write(resourceWriter.WriteStylePreload("css/Site1/blog-category.css"));
    Response.Write(resourceWriter.WriteLink("css/Site1/blog-category.css"));
%>
</asp:Content>

<asp:Content ID="PosterImage" ContentPlaceHolderID="PosterImage" runat="server">
    <main aria-labelledby="main-blog-title" class="view content content--post-cards section">
        <div class="view__anchor" id="main"></div>
        <div class="hero hero--headline-with-image">
            <div class="view__in hero__in section__in">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/people-laying-on-the-floor.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/people-laying-on-the-floor.jpg" loading="lazy" alt="" width="1920" height="975">
                </picture>
                <div class="hero__text-layer">
                    <h1 id="main-blog-title" class="hero__title">FEEL GOOD BLOG</h1>
                </div>
            </div>
        </div>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="content__header content__text">
                    <p>Welcome to The Feel Good Blog where you'll find everything you need to know to help keep your skin and belly beautiful, including recipes, stories and wellness inspiration.</p>
                </div>
            </div>
        </div>
    </main>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

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
%>

<section aria-label="Blog Posts" class="view content content--post-cards section">
    <div class="view__in section__in">
        <div class="section__block">
            <div class="content__group">
                <%
                    ImageEngine logos = new ImageEngine("brands", "images/brands");

                    categoryPosts = categoryPosts
                        .OrderByDescending(cp => cp.Tags.Any(t => string.Equals(t, "EXTERNAL", StringComparison.InvariantCultureIgnoreCase)))
                        .ThenByDescending(cp => cp.ChangeDate).ToList();

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
            <%= Html.Partial("PaginateList") %>
        </div>
    </div>
</section>

</asp:Content>