<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
    
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
<main aria-labelledby="main-title" class="view content content--sub-page content--large-video section">
    <div id="main" class="view__anchor"></div>
    <article class="content__text">
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="main-title" class="logo-title-hero__title">Our Science</h1>
            </div>
        </div>
        <div class="view__in section__in">
            <div class="content__text">
                <p>Better Blends = Better Results.  Our proprietary formulas are the result of years of nutritional research by our medical founder and specifically formulated with clean, synergistic ingredients to help you age better and feel better.</p>
                <br><br>
                <div class="content__video">
                    <div data-src-iframe="https://player.vimeo.com/video/798942712" data-attr='{ "width" : "525", "height" : "295", "title" : "Video", "allow" : "fullscreen" }' class="contain contain--video"></div>
                </div>
            </div>
        </div>
    </article>
</main>
    
</asp:Content>
