<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="FMLSHOP.BlogPosts" %>
<%@ Import Namespace="FMLSHOP.Utils" %>
<%@ Import Namespace="HtmlAgilityPack" %>

<%
    // the instance provided by the controller
    var blogPostsEngine = ViewData["BlogPostsEngine"] as BlogPostsEngine ?? new BlogPostsEngine();

    // the current blog post entry provided by the controller
    var blogPost = ViewData["BlogPost"] as BlogPostView ?? new BlogPostView();

    ImageEngine logos = ViewData["Logos"] as ImageEngine ?? new ImageEngine("brands", "images/brands");

    string postCardClassList = "post-card content__figure";

    // Fetch unique post thumbnail or default thumbnail
    var thumbnail = blogPostsEngine.GetThumbnail(blogPost);

    // Get permalink by external tag or default permalink
    var url =  blogPostsEngine.GetPermalinkByExternalTagOrDefault(blogPost);

    bool isExternal = blogPostsEngine.IsExternal(blogPost);

    // set the link attribute list
    var linkAttributeList = string.Format(@"href=""{0}""", url);

    // set target to open in a new tab if the permalink is external
    if (isExternal)
    {
        linkAttributeList = string.Format(@"{0} target=""_blank""", linkAttributeList);

        string host = new Uri(url).Host;
        string domain = host.Substring(host.LastIndexOf('.', host.LastIndexOf('.') - 1) + 1).Split('.').FirstOrDefault() ?? String.Empty;

        if (!string.IsNullOrEmpty(domain))
        {
            postCardClassList = string.Format("{0} post-card--{1}", postCardClassList, domain);
        }
    }

    // truncate description
    var maxDescriptionChars = 50;

    // parse and strip html tags from the category description
    var htmlDoc = new HtmlDocument();
    htmlDoc.LoadHtml(blogPost.ShortDescription ?? String.Empty);

    var description = htmlDoc.DocumentNode.InnerText;
    var shortDescription = description;

    if (description.Length >= maxDescriptionChars)
    {
        shortDescription = string.Format(@"{0}...", shortDescription.Substring(0, maxDescriptionChars));
    }
    %>
    <figure class="<%= postCardClassList %>">
        <a <%= linkAttributeList %> class="post-card__picture contain contain--post-card">
            <img src="<%= blogPostsEngine.GetThumbnail(blogPost) %>" alt="" width="" height="" loading="lazy" />
        </a>
        <%
            if (isExternal)
            {
                string host = new Uri(url).Host;
                string domain = host.Substring(host.LastIndexOf('.', host.LastIndexOf('.') - 1) + 1).Split('.').FirstOrDefault() ?? String.Empty;
                string logo = logos.FallbackImages.FirstOrDefault(fi => domain.Contains(logos.GetImageFileName(fi)));

                if (!string.IsNullOrEmpty(logo))
                {
                    %>
                    <picture class="post-card__logo">
                        <img src="<%= logos.FormatRelativeImagePath(logo) %>" alt="" loading="lazy"/>
                    </picture>
                    <%
                }
            }
        %>
        <h2 class="post-card__title"><%= blogPost.Title %></h2>
        <figcaption class="post-card__caption" title="<%= description %>"><%= shortDescription %></figcaption>
        <div class="post-card__footer">
            <a <%= linkAttributeList %> class="button">
                <span>Read More</span>
            </a>
        </div>
    </figure>