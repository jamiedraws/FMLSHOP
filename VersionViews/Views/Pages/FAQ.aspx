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
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="main-title" class="logo-title-hero__title">Frequently Asked Questions</h1>
            </div>
        </div>

        <div class="view__in section__in">
            <div class="content__text">
                <%= Html.Partial("FAQAccordion") %>
            </div>
        </div>
    </article>
</main>

</asp:Content>