<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%@ Import Namespace="FMLSHOP.Extensions" %>
<%@ Import Namespace="FMLSHOP.CategoryRouter" %>
<%@ Import Namespace="FMLSHOP.CampaignProduct" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="FMLSHOP.Utils" %>
<%@ Import Namespace="FMLSHOP.PromoCodeHelper" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
    var productName = SettingsManager.ContextSettings["Label.ProductName"];

    PromoCodeViewer viewHR30 = new PromoCodeViewer("HR30");
%>

<main aria-labelledby="main-title" class="view content content--sub-page content--online-offers section">
    <div id="main" class="view__anchor"></div>
    <article class="content__text">
        <div class="content__header">
            <h1 id="main-title" class="content__title">Online Offers</h1>
        </div>
        <div class="view__in section__in">
            <% if (viewHR30.IsActive) { %>
            <div class="content__offer">
                <picture class="content__image">
                    <source srcset="/images/Site1/pages/offers/hair.webp" type="image/webp">
                    <img src="/images/Site1/pages/offers/hair.jpg" alt="Save on hair products" width="498" height="248">
                </picture>
                <div class="content__text">
                    <h2 class="content__offer-title"><b>Save 30%</b> on <b>Hair Removal</b> products with code <b>HR30</b></h2>
                    <p>Valid 1/15-1/30 <button type="button" data-modal-dialog-id="promo-disclaimer-container" data-modal-dialog-actor="open" aria-haspopup="true"><em>view details</em></button></p>
                </div>
            </div>
            <% } %>

            <div class="content__offer">
                <picture class="content__image">
                    <source srcset="/images/Site1/pages/offers/sale.webp" type="image/webp">
                    <img src="/images/Site1/pages/offers/sale.jpg" alt="Sale" width="498" height="248">
                </picture>
                <div class="content__text">
                    <h2 class="content__offer-title"><b>SALE!</b></h2>
                    <p>These items MUST GO! Don't miss out on our limited time offers.</p>
                    <a href="/products/sale?cver=<%= DtmContext.VersionId %>" class="button" id="offer-free-shipping-and-bag">Shop Sale Items</a>
                </div>
            </div>
            <div class="content__offer">
                <picture class="content__image">
                    <source srcset="/images/Site1/pages/offers/lux-gift.webp" type="image/webp">
                    <img src="/images/Site1/pages/offers/lux-gift.jpg" alt="Look flawless this holiday season our lux gift set" width="500" height="249">
                </picture>
                <div class="content__text">
                    <h2 class="content__offer-title"><b>Free Luxe Gift Set &amp; Free Shipping</b></h2>
                    <p>on orders OVER $29.99!</p>
                    <p>Hanky Panky Lace Thong (Valued at $24!)<br> Use Code: HANKY at checkout. <button type="button" data-modal-dialog-id="hanky-disclaimer-container" data-modal-dialog-actor="open" aria-haspopup="true"><em>view details</em></button></p>
                </div>
            </div>
            <div class="content__offer">
                <picture class="content__image">
                    <source srcset="/images/Site1/pages/offers/ten-percent-off.webp" type="image/webp">
                    <img src="/images/Site1/pages/offers/ten-percent-off.jpg" alt="10% Off Your First Order" width="498" height="248">
                </picture>
                <div class="content__text">
                    <h2 class="content__offer-title"><b>10% Off Your First Order</b> When You Sign Up!</h2>
                    <p>Subscribe to unlock 10% off your first order, plus be in the know about exclusive offers, launches and more!</p>
                    <%= Html.Partial("Email-Signup", new ViewDataDictionary {
                        { "submitText", "Sign Up Now" },
                        { "classModifier", "klaviyo" },
                        { "showCopy", false }
                    }) %>
                </div>
            </div>
        </div>
    </article>
</main>

</asp:Content>