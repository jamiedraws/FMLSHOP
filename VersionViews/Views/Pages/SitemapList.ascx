<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];
    var ext = DtmContext.ApplicationExtension;

    var renderSitemap = false;
    var renderSitemapValue = ViewData["renderFooter"] as string ?? "True";
    Boolean.TryParse(renderSitemapValue, out renderSitemap);
    var labelCategory = ViewData["labelCategory"] as string ?? "Footer";
    var labelId = labelCategory.Replace(" ", "-").ToLower();

    var classList = ViewData["ClassList"] as string ?? string.Empty;
%>

<div>
    <nav aria-label="<%= String.Format("{0} {1}", labelCategory, "Offer information") %>" class="<%= classList %> list"> 
        <%
            var sitemap = ViewData["Sitemap"] as Sitemap ?? new Sitemap();
            var entries = sitemap.SitemapList.GetItemsByIdRange(new List<string> { 
                "index", 
                "story", 
                "articles",
                "account", 
                "customer-service",
                "find-in-store",
                "offers",
                "about", 
                "product-registration",
                "privacy-policy",
                "shipping-policy",
                "guarantee",
                "return-policy",
                "sitemap"
            });

            if (!renderSitemap)
            {
                entries = entries.Where(e => e.Id != "sitemap").ToList();
            }

            foreach (var entry in entries)
            {
                var attributeList = string.Format(@"id=""{0}-{1}"" href=""{2}""", labelId, entry.Id, entry.Page);

                if (entry.IsExternal)
                {
                    attributeList = string.Format(@"{0} target=""_blank""", attributeList);
                }
                %>
                <span>
                    <a <%= attributeList %>><%= entry.Name %></a>
                </span>
                <%
            }

        if (renderSitemap)
            {
                %>
                <li>
                    <a href="javascript:void(0);" class="optanon-toggle-display">Do Not Sell My Personal Information</a>
                </li>
                <%
            }
        %>
    </nav>
</div>