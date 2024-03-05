<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main aria-labelledby="main-title" class="view content content--contact section">
    <div id="main" class="view__anchor"></div>
    <article class="view__in section__in">
        <div class="section__block content__text">
            <h1 id="main-title" class="content__title">About Finishing Touch Flawless<sup>&trade;</sup></h1>
            
            <p><a href="mailto:customerservice@ideavillage.com" title="We'd like to hear your feedback">Email us</a> with your questions and feedback. Please allow 24 &ndash; 48 hours for a member of our team to respond. We apologize, but our customer service representatives are not available on Saturday or Sunday.</p>
            
            <p>PR Inquiries Please <a href="mailto:jenny@ideavillage.com" title="Get in touch with our PR team">contact us</a> for any PR inquiries.</p>
            
        </div>
    </article>
</main>

</asp:Content>