<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <main aria-labelledby="main-title" class="view content content--sub-page content--purpose section">
        <div id="main" class="view__anchor"></div>
        <article class="content__text">
            <div class="content__header">
                <h1 id="main-title" class="content__title">Our Purpose</h1>
            </div>
            <div class="view__in section__in">
                <div class="content__group">
                    <img src="/images/Site1/pages/about/sunglasses.jpg" width="512" height="341" loading="lazy" alt="Women wearing sunglasses">
                    <div class="content__copy">
                        <p>At Flawless, we know that to love our skin is to love ourselves. And loving ourselves is something worth doing. Clearly, Openly, Proudly. So let&rsquo;s have an honest relationship with our skin. That true romance. Let&rsquo;s leave nothing unsaid. Avoid less, Hide less, Feel shame less. Instead, let&rsquo;s love our skin like we love ourselves, because there is really no difference.</p>
                    </div>
                </div>
            </div>
        </article>
    </main>
</asp:Content>