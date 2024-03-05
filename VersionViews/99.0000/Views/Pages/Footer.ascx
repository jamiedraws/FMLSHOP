<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<footer aria-label="Copyright and Policies" class="view footer section @print-only-hide">
	<div id="footer" class="view__anchor"></div>
	<div class="view__in footer__in section__in">
	<% 
		Html.RenderPartial("SitemapList");
	%>
	</div>
</footer>

