<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.UIComponents" %>

<%
	bool isStartPage = DtmContext.Page.IsStartPageType;
	bool isIndex = DtmContext.PageCode == "Index";

	// represents the product name 
	string productName = SettingsManager.ContextSettings["Label.ProductName"];

	NavigationList sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
	NavigationItem homeLink = sitemap.GetItemById("home");

	// bypass repetitive content and navigate directly to the main content
	string skipLink = "#main";

	if (DtmContext.Page.PageType.Equals("upsell", StringComparison.InvariantCultureIgnoreCase))
	{
		skipLink = "#upsellTxt";
	} else if (!isStartPage)
	{
		skipLink = "#content_top";
	}

	// if the current page is a landing page, set the destination to the home page; otherwise, set the destination to the main landmark region
	string logoLink = isStartPage ? homeLink.Page : skipLink;

	// define the HTML template for the logo
	string logoTemplate = @"<a href=""{0}"" aria-label=""{1}"" class=""logo-text__group"">
		<img class=""logo-text__logo"" src=""/images/Site99/logo.png"" alt=""{1}"" width=""90"" height=""85"">
	</a>";

	// merge the HTML template with the appropriate link and the product name
	string logo = string.Format(logoTemplate, logoLink, productName);

	OrderButton orderButton = (ViewData["OrderButton"] as OrderButton ?? new OrderButton());
%>
	
<header aria-labelledby="header-title" class="view header section @print-only-hide">
	<span class="skip-link">
		<a href="<%= skipLink %>" class="skip-link__button" id="skip-link">
			<span>Skip To Main Content?</span>
		</a>
	</span>

	<% if (isStartPage) { %>
	<div class="header__banner">Get 10% off your first order. <button type="button" data-modal-dialog-id="disclaimer-container" data-modal-dialog-actor="open" aria-haspopup="true">See details</button></div>
	<template data-modal-dialog-template>
		<section id="disclaimer-container" aria-labelledby="disclaimer-title" data-modal-dialog-title="Disclaimer details" data-modal-dialog-container class="view content content--modal section">
			<div id="disclaimer" class="view__anchor"></div>
			<div class="view__in content__text section__in">
				<h2 id="disclaimer-title">Disclaimer</h2>
				<p>*Subscribe and Save: Save 10% today when you choose Subscribe and Save. You will then automatically receive a new supply every 30 days, charged to the same payment method used on today's order. You may send an email to <a href="mailto:support@flipmylifewellness.com">support@flipmylifewellness.com</a> to cancel your subscription. Please contact us at least 3 business days prior to your next billing to avoid being charged for the upcoming month.</p>
			</div>
		</section>
	</template>
	<% } %>

	<div class="view__in header__in section__in">
		<div class="header__group">
			<div class="header__logo">
				<%= logo %>
			</div>
		</div>
	</div>
</header>