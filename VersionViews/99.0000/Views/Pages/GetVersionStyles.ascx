<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="FMLSHOP.Utils" %>

<link rel="preconnect" href="https://use.typekit.net/" crossorigin>
<link rel="dns-prefetch" href="https://use.typekit.net/">
<link rel="stylesheet" href="https://use.typekit.net/has0isc.css">

<%
    ResourceWriter resourceWriter = new ResourceWriter();

    Response.Write(resourceWriter.WriteStylePreload("css/Site99/style.css"));
    Response.Write(resourceWriter.WriteLink("css/Site99/style.css"));
    Response.Write(resourceWriter.WriteScript("js/Site99/app.es5.js"));
%>