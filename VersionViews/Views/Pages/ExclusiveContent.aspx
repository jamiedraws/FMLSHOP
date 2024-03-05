<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Navigation" %>
<%@ Import Namespace="FMLSHOP.Utils" %>

<script runat="server">
    public class VimeoCaption
    {
        public string Id { get; set; }
        public string Caption { get; set; }
    }
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%
    ResourceWriter resourceWriter = ViewData["ResourceWriter"] as ResourceWriter ?? new ResourceWriter();   
        
    Response.Write(resourceWriter.WriteStylePreload("css/Site1/exclusive-content.css"));
    Response.Write(resourceWriter.WriteLink("css/Site1/exclusive-content.css"));
%>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--videos section">
    <div id="main" class="view__anchor"></div>
    <article class="content__text">
        <div class="logo-title-hero logo-title-hero--page-banner">
            <div class="logo-title-hero__group">
                <h1 id="main-title" class="logo-title-hero__title">Exclusive Videos</h1>
            </div>
        </div>
        <%
            List<VimeoCaption> vimeoCaptions = new List<VimeoCaption>
            {
                new VimeoCaption
                {
                    Id = "810978401",
                    Caption = "Daily Flip 1"
                },
                new VimeoCaption
                {
                    Id = "810979082",
                    Caption = "Daily Flip 2"
                },
                new VimeoCaption
                {
                    Id = "810979398",
                    Caption = "Daily Flip 3"
                },
                new VimeoCaption
                {
                    Id = "810979667",
                    Caption = "Daily Flip 4"
                },
                new VimeoCaption
                {
                    Id = "810980006",
                    Caption = "Daily Flip 5"
                },
                new VimeoCaption
                {
                    Id = "810980481",
                    Caption = "Daily Flip 6"
                },
                new VimeoCaption
                {
                    Id = "810980819",
                    Caption = "Daily Flip 7"
                }
            };
        %>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="vimeo-gallery">
                    <div class="vimeo-gallery__group">
                        <%
                            vimeoCaptions.ForEach(vimeoCaption =>
                            {
                                int index = vimeoCaptions.IndexOf(vimeoCaption);
                                string id = string.Format("pdp-video-{0}", index);
                                string label = string.Format("Product video {0}", index);
                                %>
                                <div class="vimeo-gallery__item view">
                                    <div class="view__anchor" id="daily-flip-<%= index + 1 %>"></div>
                                    <div class="vimeo-gallery__item">
                                        <div class="vimeo-gallery__poster">
                                            <button type="button" aria-label="<%= label %>" class="contain contain--video" data-modal-dialog-id="<%= id %>" data-modal-dialog-actor="open" data-modal-dialog-url-contains="#daily-flip-<%= index + 1 %>" data-modal-dialog-iframe="https://player.vimeo.com/video/<%= vimeoCaption.Id %>" data-modal-dialog-title="Video" data-modal-dialog-template-modifier="video" data-src-img="/images/products/default.svg" data-attr='{ "width":"1200", "height":"675", "loading":"lazy", "alt": ""}'>
                                            </button>
                                        </div>
                                        <div class="vimeo-gallery__title"><%= vimeoCaption.Caption %></div>
                                    </div>
                                </div>                        
                                <%
                            });  
                        %>
                    </div>
                </div>
            </div>
        </div>
    </article>
</main>

</asp:Content>