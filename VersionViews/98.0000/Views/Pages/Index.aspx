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

		<% if (DtmContext.IsProxyIpAddress || DtmContext.CampaignDomains.Any(d => d.DomainId == DtmContext.DomainId && d.Domain.ToLower().Contains("dtmstage"))) { %>

			<meta name="robots" content="noindex, nofollow">

		<% } else { %>

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
		
			Response.Write(resourceWriter.WriteStylePreload("css/Site98/style.css"));
			Response.Write(resourceWriter.WriteLink("css/Site98/style.css"));
		%>
	</head>
	<body>
		<main aria-label="Products" class="view hero section">
			<div class="view__anchor" id="main"></div>
			<div class="view__in hero__in section__in">
				<div class="hero__logo">
					<img src="/images/Site98/logo.svg" alt="" width="250" height="250">
				</div>
			</div>
		</main>

		<div>
		<% 
			Html.RenderSiteControls(SiteControlLocation.ContentTop);
			Html.RenderSiteControls(SiteControlLocation.ContentBottom);
			Html.RenderSiteControls(SiteControlLocation.PageBottom);
		%>
		</div>
	</body>
</html>

</asp:Content>