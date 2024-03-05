<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.ClientSites.Web" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>

<%
    var slide = ViewData["slide"] as string ?? string.Empty;
%>

<% if (slide == "original") { %>
<div class="hero__item hero__item--primary hero__item--<%= slide %>">
    <div class="hero__in view__in">
        <div class="hero__group">
            <div class="hero__text">
                <h2 class="hero__title">HAPPY AND HEALTHY ARE IN A RELATIONSHIP</h2>
                <h3 class="hero__tagline">Flip The Way You Age</h3>
                <a href="/products?cver=<%= DtmContext.VersionId %>" class="button hero__button">Shop All Products</a>
            </div>
            <div class="hero__media">
                <div class="hero__badge">
                    <!-- <svg><use href="#no-bloat"></use></svg> -->
                    <img src="/images/Site1/hero-banners/no-bloat.svg" alt="No Bloat. Smooth Texture. 100% Delicious." width="82" height="82">
                </div>
                <picture>
                    <img src="/images/Site1/hero-banners/collagen--original.png" alt="Collagen Peptides + Biotin" width="465" height="546">
                </picture>
            </div>
        </div>
    </div>
</div>
<% } %>

<% if (slide == "flippin-beautiful") { %>
<div class="hero hero--primary hero--<%= slide %>">
    <div class="view__in hero__in section__in">
        <div class="hero__group">
            <div class="hero__media">
                <picture>
                    <source srcset="/images/Site1/hero-banners/collagen-with-shadow.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/collagen-with-shadow.jpg" alt="Collagen Peptides + Biotin" width="720" height="822">
                </picture>
            </div>
            <div class="hero__text">
                <h2 class="hero__title">
                    I AM FLIPPING BEAUTIFUL.
                </h2>
                <h3 class="hero__tagline">
                    <span>Grow, Glow + Strengthen.</span>
                    <span>The best for Hair, Skin + Nails.</span>
                </h3>
            </div>
            <div class="hero__badge">
                <img src="/images/Site1/hero-banners/no-bloat.svg" alt="No Bloat. Smooth Texture. 100% Delicious." width="403" height="403">
            </div>
        </div>
    </div>
</div>
<% } %>

<% if (slide == "manifest") { %>
<div class="hero hero--gray hero--<%= slide %>">
    <div class="view__in hero__in section__in">
        <div class="hero__group">
            <div class="hero__media">
                <picture>
                    <source srcset="/images/Site1/hero-banners/all-products.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/all-products.jpg" loading="lazy" alt="All Flip My Life products" width="1244" height="531">
                </picture>
            </div>
            <div class="hero__text">
                <h2 class="hero__title">
                    <span>MANIFEST</span>
                    <span>BETTER HEALTH.</span>
                </h2>
                <h3 class="hero__tagline">
                    Upgrade your energy, immunity, focus, clarity, gut health, strength, mood, motivation and glow.
                </h3>
            </div>
        </div>
    </div>
</div>
<% } %>

<% if (slide == "way-you-age") { %>
<div class="hero hero--<%= slide %>">
    <div class="view__in hero__in section__in">
        <div class="hero__media">
            <picture>
                <source srcset="/images/Site1/hero-banners/way-you-age.webp" type="image/webp">
                <img src="/images/Site1/hero-banners/way-you-age.jpg" loading="lazy" alt="" width="1920" height="975">
            </picture>
        </div>
        <div class="hero__text-layer">
            <div class="hero__text">
                <div class="hero__title">FLIP</div>
                <div class="hero__title">THE WAY YOU AGE.</div>
            </div>
            <div class="hero__badge">
                <svg class="icon icon--logo">
                    <use href="#logo"></use>
                </svg>
            </div>
        </div>
    </div>
</div>
<% } %>

<% if (slide == "dont-act-your-age") { %>
    <div class="hero hero--<%= slide %>">
        <div class="view__in hero__in section__in">
            <div class="hero__media">
                <picture>
                    <source srcset="/images/Site1/hero-banners/dont-act-your-age.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/dont-act-your-age.jpg" loading="lazy" alt="" width="1920" height="975">
                </picture>
            </div>
            <div class="hero__text-layer">
                <div class="hero__title">DON'T ACT YOUR AGE.</div>
            </div>
        </div>
    </div>
<% } %>