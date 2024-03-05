<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    string productCode = ViewData["ProductCode"] as string ?? string.Empty;

    bool isDairyFree = new List<string>{ "CPB", "BBP" }.Contains(productCode);
    bool isVeganFriendly = !isDairyFree;
%>

<section aria-label="Nutritional Features" class="view content content--nutrition section">
    <div id="nutrition" class="view__anchor"></div>
    <div class="view__in content__in section__in">
        <ul class="content__group">
            <li class="content__icon content__icon--gluten">
                <span>Gluten</span>
                <span>Free</span>
            </li>

            <% if (isVeganFriendly) { %>
            <li class="content__icon content__icon--vegan">
                <span>Vegan</span>
                <span>Friendly</span>
            </li>
            <% } %>

            <% if (isDairyFree) { %>
            <li class="content__icon content__icon--dairy">
                <span>Dairy</span>
                <span>Free</span>
            </li>
            <% } %>

            <li class="content__icon content__icon--preservative">
                <span>Preservative</span>
                <span>Free</span>
            </li>
            <li class="content__icon content__icon--soy">
                <span>Soy</span>
                <span>Free</span>
            </li>
            <li class="content__icon content__icon--gmo">
                <span>Non</span>
                <span>GMO</span>
            </li>
            <li class="content__icon content__icon--keto">
                <span>Keto</span>
                <span>Friendly</span>
            </li>
        </ul>
    </div>
</section>