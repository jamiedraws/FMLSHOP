<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.Models.Ecommerce" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Enums" %>
<%@ Import Namespace="System.Web" %>
<%@ Import Namespace="System.IO" %>

<div class="store store--discovery-banner">
    <div class="store__copy">
        <h1 class="store__header">Welcome to the Flip My Life Family!</h1>

        <div class="store__text">
            <p>Please click <a href="https://www.flipmylifetips1.com/QR/?mid=12114941">HERE</a> to sign up for order status and to start your Flip My Life journey, where you'll find weekly MINDSET WORKSHOPS AND TIPS, PHYSICAL MOVEMENT VIDEOS, and even HEALTHY TIPS from our medical staff to enhance your transformation!</p>

            <%
                string customerServiceEmail = SettingsManager.ContextSettings["CustomerService.EmailAddress"];    
            %>
            <p>Please feel free to contact us any time at <a href="mailto:<%= customerServiceEmail %>"><%= customerServiceEmail %></a>.</p>
        </div>
    </div>
</div>