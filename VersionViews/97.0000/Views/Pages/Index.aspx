<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.UIComponents" %>
<%@ Import Namespace="FMLSHOP.Utils" %>

<!DOCTYPE html>
<html lang="en" class="dtm">
<head>
    <title><%= DtmContext.Page.PageTitle %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="<%= DtmContext.Page.MetaDescription %>">
    <meta name="keywords" content="<%= DtmContext.Page.MetaKeywords %>">
    <meta name="facebook-domain-verification" content="apazobq9cmag3m9ite1e3bclrq3o0l" />

    <%
        string androidThemeBarColor = SettingsManager.ContextSettings["AndroidThemeBarColor", "#ffffff"];

        // represents the 1200x630 thumbnail image for Open Graph
        string getFacebookImage = SettingsManager.ContextSettings["SocialPlugins.Facebook.OpenGraphImage"];

        // represents the 1200x630 thumbnail image for Twitter
        string getTwitterImage = SettingsManager.ContextSettings["SocialPlugins.Twitter.OpenGraphImage"];

        string productName = SettingsManager.ContextSettings["Label.ProductName"];
    %>

    <meta name="theme-color" content="<%= androidThemeBarColor %>">

    <%-- Open Graph Metadata --%>
    <meta property="og:title" content="<%= DtmContext.Page.PageTitle %>">
    <meta property="og:type" content="website">
    <meta property="og:description" content="<%= DtmContext.Page.MetaDescription %>">
    <meta property="og:url" content="<%= DtmContext.Domain.FullDomainOfferVersionUrl(DtmContext.PageCode) %>">
    <meta property="og:image" content="<%= getFacebookImage %>">

    <%-- Twitter Metadata --%>
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="<%= DtmContext.Page.PageTitle %>">
    <meta name="twitter:description" content="<%= DtmContext.Page.MetaDescription %>">
    <meta name="twitter:image" content="<%= getTwitterImage %>">
    <meta name="twitter:domain" content="<%= DtmContext.Domain.FullDomainOfferVersionUrl(DtmContext.PageCode) %>">

    <%
        var mainSeoDomain = DtmContext.CampaignDomains
            .Where(cd => cd.IsSEO).FirstOrDefault()
            ?? DtmContext.CampaignDomains
            .Where(cd => cd.IsIndexable).FirstOrDefault()
            ?? DtmContext.Domain;

        string canonicalUrl = DtmContext.PageCode.Equals("Index")
            ? mainSeoDomain.FullDomainContext
            : mainSeoDomain.FullDomainCustomPathContext(DtmContext.Page.PageAlias) + DtmContext.ApplicationExtension;

        canonicalUrl = canonicalUrl.Replace("http://", "https://");
    %>

    <% if (DtmContext.IsProxyIpAddress || DtmContext.CampaignDomains.Any(d => d.DomainId == DtmContext.DomainId && d.Domain.ToLower().Contains("dtmstage")))
        { %>

    <meta name="robots" content="noindex, nofollow">

    <% }
    else
    { %>

    <meta name="google-site-verification" content="<%= DtmContext.Page.MetaVerify %>">
    <meta name="msvalidate.01" content="617F9E44E7841BBC8E57FE0772BB9DD9">
    <link rel="canonical" href="<%= canonicalUrl %>">

    <% } %>

    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png">
    <link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png">
    <link rel="manifest" href="/site.webmanifest">
    <link rel="mask-icon" href="/safari-pinned-tab.svg" color="#30b2e6">
    <meta name="msapplication-TileColor" content="#30b2e6">
    <meta name="theme-color" content="#ffffff">

    <link rel="preconnect" href="https://use.typekit.net/" crossorigin>
    <link rel="dns-prefetch" href="https://use.typekit.net/">
    <link rel="stylesheet" href="https://use.typekit.net/has0isc.css">

    <%
        ResourceWriter resourceWriter = new ResourceWriter();

        Response.Write(resourceWriter.WriteStylePreload("css/Site97/style.css"));
        Response.Write(resourceWriter.WriteLink("css/Site97/style.css"));
    %>
</head>
<body class="dtm__in">
    <div class="view hero section">
        <div class="view__in section__contain">
            <div class="hero__group">
                <div class="hero__text">
                    <div class="hero__scroll-content hero__group-text">
                        <p class="hero__standfirst">Leading Doctors, Wellness and Mindset Coaches have joined forces to show you how to age better with one daily FLIP.</p>
                        <h1 class="hero__callout">Join our FREE VIP mailing list now to find out how to feel better in just 7 days.</h1>
                        <div class="hero__form">
                            <div class="klaviyo-form-WER6ky"></div>
                        </div>
                    </div>
                </div>
                <picture class="hero__picture contain contain--poster-image">
                    <source srcset="/images/Site97/poster-image_499w.webp" type="image/webp" media="(max-width: 1080px)">
                    <source srcset="/images/Site97/poster-image_499w.jpg" media="(max-width: 1080px)">
                    <source srcset="/images/Site97/poster-image.webp" type="image/webp" media="(min-width: 1080px)">
                    <source srcset="/images/Site97/poster-image.jpg" media="(min-width: 1080px)">
                    <img src="/images/Site97/poster-image.jpg" alt="" width="997" height="1080">
                </picture>
            </div>
        </div>
    </div>

    <div>
        <% 
            Html.RenderPartial("Scripts");
            Html.RenderSiteControls(SiteControlLocation.ContentTop);
            Html.RenderSiteControls(SiteControlLocation.ContentBottom);
            Html.RenderSiteControls(SiteControlLocation.PageBottom);
        %>
        <!-- Meta Pixel Code -->
        <script>
            !function (f, b, e, v, n, t, s) {
                if (f.fbq) return; n = f.fbq = function () {
                    n.callMethod ?
                        n.callMethod.apply(n, arguments) : n.queue.push(arguments)
                };
                if (!f._fbq) f._fbq = n; n.push = n; n.loaded = !0; n.version = '2.0';
                n.queue = []; t = b.createElement(e); t.async = !0;
                t.src = v; s = b.getElementsByTagName(e)[0];
                s.parentNode.insertBefore(t, s)
            }(window, document, 'script',
                'https://connect.facebook.net/en_US/fbevents.js');
            fbq('init', '1974618009549263');
            fbq('track', 'PageView');
        </script>
        <noscript>
            <img height="1" width="1" style="display: none"
                src="https://www.facebook.com/tr?id=1974618009549263&ev=PageView&noscript=1" />
        </noscript>
        <!-- End Meta Pixel Code -->
        <script async type="text/javascript" src="//static.klaviyo.com/onsite/js/klaviyo.js?company_id=Ywp4Yb"></script>
        <script>

            window.addEventListener("klaviyoForms", function (e) {
                if (e && e.detail && e.detail.type == 'submit') {
                    fbq('track', 'Lead');
                }
            });

        </script>
    </div>
</body>
</html>

</asp:Content>