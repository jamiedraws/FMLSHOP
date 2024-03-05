<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="/css/Site1/index.css" rel="preload" as="style" />
    <link href="/css/Site1/index.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
var productName = SettingsManager.ContextSettings["Label.ProductName"];
%>

<main aria-labelledby="main-title" class="view content content--find-in-store section">
    <div id="main" class="view__anchor"></div>
    <article class="content__text">
        <h1 id="main-title" class="content__title">Find Us In Stores</h1>
        <p>Find our Finishing Touch Flawless&trade; products in one of our retail partners nearest you.</p>
        <p>Click on the logos below to go to their respective online store locator.</p>
        </div>
        <div class="view__in section__in">
            <div class="section__block">
                <div class="content__group">
                    <a target="_blank" href="https://www.walmart.com/store/finder" title="Find <%= productName %> products at Walmart, links opens in a new tab" id="store-locator-walmart">
                        <img src="/images/Site1/pages/stores/walmart.svg" loading="lazy" alt="Walmart" width="234" height="56">
                    </a>
                    <a target="_blank" href="https://www.target.com/store-locator/find-stores" title="Find <%= productName %> products in Target, links opens in a new tab" id="store-locator-target">
                        <img src="/images/Site1/pages/stores/target.svg" loading="lazy" alt="Target" width="609" height="635">
                    </a>
                    <a target="_blank" href="https://www.ulta.com/stores?_DARGS=ultastoresstorelocator.jsp" title="Find <%= productName %> products in Ulta Beauty, links opens in a new tab" id="store-locator-ulta">
                        <img src="/images/Site1/pages/stores/ulta.svg" loading="lazy" alt="Ulta Beauty" width="1154" height="474">
                    </a>
                    <a target="_blank" href="https://www.cvs.com/store-locator/landing" title="Find <%= productName %> products in CVS pharmacy stores, links opens in a new tab" id="store-locator-cvs">
                        <img src="/images/Site1/pages/stores/cvs.svg" loading="lazy" alt="CVS" width="1187" height="290">
                    </a>
                    <a target="_blank" href="https://www.walgreens.com/storelocator/find.jsp" title="Find <%= productName %> products in Walgreens, links opens in a new tab" id="store-locator-walgreens">
                        <img src="/images/Site1/pages/stores/walgreens.svg" loading="lazy" alt="Walgreens" width="2157" height="447">
                    </a>
                    <a target="_blank" href="https://www.bedbathandbeyond.com/store/selfservice/FindStore" title="Find <%= productName %> products in Bed, Bath and Beyond, links opens in a new tab" id="store-locator-bbb">
                        <img src="/images/Site1/pages/stores/bbb.svg" loading="lazy" alt="Bed, Bath and Beyond" width="1640" height="510">
                    </a>
                    <a target="_blank" href="https://www.riteaid.com/locations/" title="Find <%= productName %> products in Rite Aid, links opens in a new tab" id="store-locator-riteaid">
                        <img src="/images/Site1/pages/stores/rite-aid.svg" loading="lazy" alt="Rite Aid" width="1239" height="578">
                    </a>
                    <a target="_blank" href="https://www.amazon.com/stores/FinishingTouchFlawless/page/0EF9ACBC-A567-4544-9E56-18FC77240BCF?maas=maas_adg_5AE7945B7840A96F5833ABD539435259_afap_abs&ref_=aa_maas&tag=maas&ref_=ast_bln " title="Find <%= productName %> products online at Amazon, links opens in a new tab" id="store-locator-amazon">
                        <img src="/images/Site1/pages/stores/amazon.svg" loading="lazy" alt="Available at Amazon" width="1437" height="721">
                    </a>
                </div>
                
            </div>
        </div>
    </article>
</main>

</asp:Content>