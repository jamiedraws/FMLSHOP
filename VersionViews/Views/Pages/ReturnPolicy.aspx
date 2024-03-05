<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--returns section">
    <div id="main" class="view__anchor"></div>
    <article class="view__in section__in">
        <div class="section__block content__text">
            <h1 id="main-title" class="content__title">Return Policy</h1>
            
            <p>
                Your Complete satisfaction is guaranteed or your money back! 60-Day Money Back Guarantee (Less S&amp;H). If you&rsquo;re not absolutely delighted with any of our products, for any reason, simply contact our customer service team to return your product within 60 days of receipt for a refund of your purchase price (less S&amp;H).
            </p>
            <address>
                Finishing Touch Flawless&trade; Beauty <br>
                400 Returns Rd <br>
                Wallingford, CT 06494
            </address>
            
        </div>
    </article>
</main>

</asp:Content>