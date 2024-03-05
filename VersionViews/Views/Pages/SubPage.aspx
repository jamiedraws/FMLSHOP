<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var sitemap = (ViewData["Sitemap"] as Sitemap ?? new Sitemap()).SitemapList;
%>

<main aria-labelledby="main-title" class="view content content--sub-page section">
    <div id="main" class="view__anchor"></div>
    <article class="content__text">
        <% 
            var title = Model.UpsellTitle ?? string.Empty;
            var text = Model.UpsellText ?? string.Empty;
            var hasTitle = !String.IsNullOrEmpty(title);
            var hasText = !String.IsNullOrEmpty(text);

            if (hasTitle)
            {
                %>
                <div class="logo-title-hero logo-title-hero--page-banner">
                    <div class="logo-title-hero__group">
                        <h1 id="main-title" class="logo-title-hero__title"><%= title %></h1>
                    </div>
                </div>
                <%
            } else
            {
                Html.RenderSnippet("SUBPAGE-TITLE-" + DtmContext.PageCode);
            }
            %>
            <div class="view__in section__in">
                <div class="content__text">
            <%
            if (hasText)
            {
                var testimonials = sitemap.GetItemById("testimonials").Page;
                var privacy = sitemap.GetItemById("privacy-policy").Page;

                text = text.Replace("/Testimonials", testimonials)
                        .Replace("/index#reviews", testimonials)
                        .Replace(@"href=""Privacy-Policy""", string.Format(@"href=""{0}"" target=""_blank""", privacy));

                Response.Write(text);
            } else
            {
                Html.RenderSubPageContent(DtmContext.PageCode);
            }
            %>
                </div>
            </div>
    </article>
</main>

</asp:Content>