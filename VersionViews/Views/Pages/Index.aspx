<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce.Repositories" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="FMLSHOP.PromoCodeHelper" %>
<%@ Import Namespace="FMLSHOP.BlogPosts" %>
<%@ Import Namespace="FMLSHOP.Utils" %>
<%@ Import Namespace="FMLSHOP.Models" %>
<%@ Import Namespace="FMLSHOP.Text" %>
<%@ Import Namespace="FMLSHOP.LimitedTimeOffer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%
    ResourceWriter resourceWriter = ViewData["ResourceWriter"] as ResourceWriter ?? new ResourceWriter();

    Response.Write(resourceWriter.WriteStylePreload("css/Site1/index.css"));
    Response.Write(resourceWriter.WriteLink("css/Site1/index.css"));

    List<FMLSHOP.StructuredData.Review> reviews = ProductReviews.Collagen.Select(pr => new FMLSHOP.StructuredData.Review()
    {
        Author = new FMLSHOP.StructuredData.Person
        {
            Name = pr.Name,
            Address = pr.Location
        },
        ReviewRating = new FMLSHOP.StructuredData.Rating
        {
            RatingValue = "5"
        },
        ReviewBody = pr.Blockquote
    }).ToList();

    Html.RenderPartial("StructuredDataJSONLD", new ViewDataDictionary
    {
        { "Type", "Reviews" },
        { "Reviews", reviews },
        { "ProductName", "Collagen" }
    });
%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];

    PromoCodeViewer promo25 = new PromoCodeViewer("PROMOCODE25");
    FathersDayOffer fathersDay = new FathersDayOffer();
%>

<main aria-labelledby="main-title" class="view content section">
    <div id="hero" class="view__anchor"></div>

    <% if (fathersDay.IsActive) { %>
    <div class="slide slide--fade slide--hero" data-carousel-config='{ "delay" : 3000, "auto" : false }'>
        <div class="slide__into" tabindex="0" id="hero-slider">
            <div class="slide__item slide__item--current">
                <section aria-label="Buy 2 Get 1 Free. Hurry While Supplies Last" class="hero hero--headline-with-image">
                    <div class="view__in hero__in section__in">
                        <picture class="hero__media">
                            <img src="/images/Site1/hero-banners/promos/buy2get1.gif" loading="lazy" alt="" width="2296" height="879">
                        </picture>
                    </div>
                </section>
            </div>
            <div class="slide__item">
                <section aria-label="Men and Father's alike enjoying <%= productName %>" class="hero hero--headline-with-image">
                    <div class="view__in hero__in section__in">
                        <picture class="hero__media">
                            <source srcset="/images/Site1/hero-banners/fml-fathers-day.webp" type="image/webp">
                            <img src="/images/Site1/hero-banners/fml-fathers-day.jpg" loading="lazy" alt="" width="1920" height="747">
                        </picture>
                    </div>
                </section>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="slide slide--fade slide--hero" data-carousel-config='{ "delay" : 3000, "auto" : false }'>
        <div class="slide__into" tabindex="0" id="hero-slider">
            <%--
            <div class="slide__item slide__item--current">
                <section aria-labelledby="hero-first-title" class="hero hero--headline-with-image">
                    <div class="view__in hero__in section__in">
                        <picture class="hero__media">
                            <source srcset="/images/Site1/hero-banners/woman-in-the-water.webp" type="image/webp">
                            <img src="/images/Site1/hero-banners/woman-in-the-water.jpg" loading="lazy" alt="" width="1920" height="975">
                        </picture>
                        <div class="hero__text-layer">
                            <h1 id="hero-first-title" class="hero__title">FLIP THE WAY YOU AGE.</h1>
                        </div>
                    </div>
                </section>
            </div>
            --%>
            <div class="slide__item slide__item--current">
                <section aria-labelledby="hero-second-title" class="hero hero--headline-with-image">
                    <div class="view__in hero__in section__in">
                        <picture class="hero__media">
                            <source srcset="/images/Site1/hero-banners/fml-alt-banners--2.webp" type="image/webp">
                            <img src="/images/Site1/hero-banners/fml-alt-banners--2.jpg" loading="lazy" alt="" width="1920" height="747">
                        </picture>
                        <div class="hero__text-layer">
                            <h2 id="hero-second-title" class="hero__title">DON'T ACT YOUR AGE.</h2> 
                        </div>
                    </div>
                </section>
            </div>
            <div class="slide__item">
                <div class="hero hero--headline-with-image" data-hero-vimeo-id="803274379">
                    <div class="view__in hero__in section__in">
                        <div class="hero__media">
                            <div class="contain contain--hero-image">
                                <iframe src="https://player.vimeo.com/video/803274379?background=1" width="426" height="216" frameborder="0" loading="lazy" allow="autoplay; fullscreen; picture-in-picture" allowfullscreen="" title="Flip The Way You Feel With 1 Shake A Day."></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } %>
</main>

<section aria-labelledby="mission-title" class="view content content--text-block content--grid-4-to-2 section">
    <div id="mission" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <div class="section__block">
            <h2 class="content__title" id="mission-title">Join the Ageless Generation.</h2>
            <p class="content__desc"><a href="#join-the-ageless-generation">Join our mailing list</a> below for FREE VIP access, mindset coaching, webinars, health tips, recipes, and workouts to help speed up results and get the support you need to feel and age better!</p>
        </div>
        <div class="section__block view">
            <div class="view__in" id="products"></div>
            <div class="content__group">
            <%
                    CategoryProductRouterEngine categoryProductRouterEngine = ViewData["CategoryProductRouterEngine"] as CategoryProductRouterEngine ?? new CategoryProductRouterEngine();

                    List<string> productCodes = new List<string> { "F7V", "F7C", "CPB", "SML" };
                    List<CategoryProductRouter> categoryProducts = productCodes.Select(pc => categoryProductRouterEngine.GetCategoryProductByProductCode(pc)).Where(cp => categoryProductRouterEngine.IsValidCategoryProductRouter(cp)).ToList();
                
                    foreach (var categoryProduct in categoryProducts)
                    {
                        var index = categoryProducts.IndexOf(categoryProduct);

                        %>
                        <div class="content__item">
                        <%

                        Html.RenderPartial("CategoryProduct", new ViewDataDictionary
                        {
                            { "CategoryProductRouterEngine", categoryProductRouterEngine },
                            { "CategoryProduct", categoryProduct },
                            { "IsPdpPage", "true" },
                            { "Index", index },
                            { "RenderVariantProductRadioGroup", false },
                            { "CategoryModifier", "category-product--mobile-adjust" },
                            { "Id", "slide-category-products" }
                        });

                        %>
                        </div>
                        <%
                    }
                %>
            </div>
        </div>
        <div class="section__block">
            <blockquote>&ldquo;Our superfood blends are specifically formulated with clean, synergistic ingredients for better absorption and bioavailability to support key pillars of health and help you age better.&rdquo;</blockquote>
            <cite>- Dr. Gerard Farris, Integrative Physician</cite>
        </div>
    </div>
</section>


<%
    Html.RenderPartial("NutritionList");

    List<Review> collagenReviews = ProductReviews.Collagen.Take(4).ToList();
    List<Review> flipReviews = ProductReviews.Flip7.Take(4).ToList();
    List<Review> matchaReviews = ProductReviews.Matcha.Take(4).ToList();

    collagenReviews.ForEach(r => r.Product = "Collagen");
    flipReviews.ForEach(r => r.Product = "Flip 7");
    matchaReviews.ForEach(r => r.Product = "Matcha");

    List<Review> reviews = collagenReviews.Concat(flipReviews).Concat(matchaReviews).OrderBy(r => r.Product).ToList();

    Html.RenderPartial("ReviewGroup", new ViewDataDictionary
    {
        { "Reviews", reviews },
        { "UILayout", "CardCarousel" }
    });
%> 


<section aria-labelledby="science-title" class="view content content--large-video content--has-bkg section">
    <div id="science" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <div class="section__block">
            <div class="content__group">
                <h2 class="content__title" id="science-title">Our Flipping Science</h2>
                <div class="content__video">
                    <!-- will be replaced with main video when done shooting -->
                    <div data-src-iframe="https://player.vimeo.com/video/798942712" data-attr='{ "width" : "525", "height" : "295", "title" : "Video", "allow" : "fullscreen" }' class="contain contain--video"></div>
                </div>
                <div class="content__footer">
                    <a href="Science<%= Model.Extension %>" class="button button--transparent content__button">Learn More</a>
                </div>
            </div>
        </div>
    </div>
</section>

<section aria-label="Product Quote" class="view content content--blockquote-bkg section">
    <div class="view__in section__in">
        <div class="section__block">
            <blockquote>&ldquo;We&rsquo;re more than a nutritional upgrade - we&rsquo;re a movement that gives you access to mindset and wellness coaches to help you on your Flipping journey because we believe when one person is lifted, we all rise. When your energy shifts, we all feel it.&rdquo;</blockquote>
        </div>
        <picture class="section__block content__picture">
            <img src="/images/Site1/pages/home/flip-7-vanilla-in-use.png" alt="" width="950" height="610" loading="lazy">
        </picture>
    </div>
</section>

<section class="view content content--free-workouts section">
    <div class="view__in section__in content__in">
        <div class="section__block content__block">
            <h2 class="content__title">Buy now and get FREE access to exclusive Mindset Coaching and Workouts.</h2>
        </div>
    </div>
</section>

<section aria-label="Read our latest blog articles" class="view content content--post-cards section">
    <div id="latest-blogs" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <div class="section__block">
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
    </div>
</section>

</asp:Content>
