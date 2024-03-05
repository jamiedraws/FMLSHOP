<%@ Page Language="C#" MasterPageFile="~/VersionViews/99.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--sub-page section">
    <div id="main" class="view__anchor"></div>
    <article class="view__in content__in section__in">
        <div class="section__block content__text">
        <% 
            // represents the page title from the upsell page editor
            string title = Model.UpsellTitle ?? string.Empty;

            // represents the page text from the upsell page editor
            string text = Model.UpsellText ?? string.Empty;

            // determines if therre is a title
            bool hasTitle = !String.IsNullOrEmpty(title);

            // detertmines if there is text
            bool hasText = !String.IsNullOrEmpty(text);

            if (hasTitle)
            {
                %>
                <h1 id="main-title" class="content__title"><%= title %></h1>
                <%
            } else
            {
                Html.RenderSnippet("SUBPAGE-TITLE-" + DtmContext.PageCode);
            }

            if (hasText)
            {
                text = text
                    .Replace("[#optout#]", DtmContext.OptOutLink)
                    .Replace("[#support#]", DtmContext.SupportEmail)
                    .Replace("[#ext#]", DtmContext.ApplicationExtension);

                Response.Write(text);
            } else
            {
                Html.RenderSubPageContent(DtmContext.PageCode);
            }
        %>
        </div>
    </article>
</main>

</asp:Content>