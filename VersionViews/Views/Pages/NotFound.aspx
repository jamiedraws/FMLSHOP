<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<main class="view section">
    <div id="main" class="view__anchor"></div>
    <div class="view__in section__in">
        <%
            var content = ViewData["NotFound"];
        %>

        <h1>We're sorry but this page was not found.</h1>

        <a href="/Products">View All Products</a>
    </div>
</main>

</asp:Content>