<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
    <%@ Import Namespace="Dtm.Framework.ClientSites" %>

<% 
	if (DtmContext.Page.IsStartPageType) 
	{ 
		Html.RenderPartial("Scripts");
		Html.RenderSnippet("ORDERFORMSCRIPT");
		%>
		<script>
			const setBraintreeHostedFieldsStyles = function () {
				return {
					'font-size': '1em',
					'font-family': 'Helvetica, Arial, sans-serif',
					'font-weight': 'normal',
					'line-height': 'normal',
					'color': '#333',
				};
			};
		</script>
		<%
	}
%>

<%= Model.FrameworkVersion %>

<div>
  <% 
      Html.RenderSiteControls(SiteControlLocation.ContentTop);
      Html.RenderSiteControls(SiteControlLocation.ContentBottom);
      Html.RenderSiteControls(SiteControlLocation.PageBottom);
  %>
</div>