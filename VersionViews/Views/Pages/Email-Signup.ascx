<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    var classModifier = ViewData["classModifier"] as string ?? "footer";
%>

<div class="<%= classModifier %> <%= classModifier %>--form delay-input" data-klaviyo-form hidden>
    <div class="footer__form-header">
        Join the Ageless Generation
    </div>
    <div class="klaviyo-form-WER6ky"></div>
    <div class="footer__form-footer">
        Sign up for emails now to be the first to know about our latest sales, new arrivals &amp; special offers.
    </div>
</div>

<script async type="text/javascript" src="//static.klaviyo.com/onsite/js/klaviyo.js?company_id=Ywp4Yb"></script>
<script>

    window.addEventListener("klaviyoForms", function (e) {
        // if (e && e.detail && e.detail.type == 'submit') {
        //     fbq('track', 'Lead');
        // }

        if (!e) return;
        if (!e.detail) return;

        const type = e.detail.type.toLowerCase();
        const container = document.querySelector(".klaviyo-form");

        if (type === "embedopen") {
            container?.classList.add("klaviyo-form--embed-open");
        }

        if (type === "submit") {
            container?.classList.remove("klaviyo-form--embed-open");
            container?.classList.add("klaviyo-form--submit");

            fbq('track', 'Lead');

        }
    });

</script>