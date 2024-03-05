<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--sub-page content--shipping section">
    <div id="main" class="view__anchor"></div>
    <div class="content__header">
        <h1 id="main-title" class="content__title">Shipping Policy</h1>
    </div>
    <article class="view__in section__in">
        <div class="section__block content__text">            
            <p>
                We offer FREE Standard shipping on all U.S. orders over $29.99- plus receive a FREE COSMETIC BAG GIFT. No promo code needed, offer auto applied at checkout. *Offer valid on standard shipping to the continental US.
            </p>
            <p>
                Standard shipping on orders under $29.98 will be charged $5.99 S&H.
            </p>
            <p>
                When your order is placed, it takes 1-3 business days to get it processed, packaged, and ready to go. Once we ship it, we will send you and shipment confirmation email with tracking. Packages usually take 3-7 business days to arrive once shipped. 
            </p>
            <p>
                To check the status of your order, please <a href="https://customerstatus.com/SearchUpdate.aspx" class="link" title="Track your order, opens in a new window" target="_blank">click here <span class="link__advisal"> <span class="link__container">Opens in a new window</span></span></a>.
            </p>
        </div>
    </article>
</main>

</asp:Content>