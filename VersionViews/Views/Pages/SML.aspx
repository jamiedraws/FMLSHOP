<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.Text" %>


<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-SML-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/SML/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/SML/product.jpg" alt="Super Matcha Latte" width="574" height="775">
                </picture>
                <div class="hero__text">
                    <span id="hero-SML-title" class="hero__title">
                        MANIFEST BETTER HEALTH.
                    </span>
                </div>
                <svg class="hero__badge">
                    <use href="#delicious-badge"></use>
                </svg>
            </div>
        </div>
    </section>
</asp:Content> 

<asp:Content ID="ProductImageCarouselThumbnail" ContentPlaceHolderID="ProductImageCarouselThumbnail" runat="server">
    <button type="button" aria-label="Product video 1" class="contain contain--square" data-modal-dialog-id="pdp-video-1" data-modal-dialog-actor="open" data-modal-dialog-iframe="https://player.vimeo.com/video/827002498?title=0&byline=0&portrait=0" data-modal-dialog-title="Video" data-modal-dialog-template-modifier="video" data-src-img="/images/Site1/products/default.svg" data-attr='{ "width":"120", "height":"163", "loading":"lazy", "alt": ""}'>
    </button>
</asp:Content> 

<asp:Content ID="ProductTitle" ContentPlaceHolderID="ProductTitle" runat="server">
    SUPER MATCHA LATTE
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Japanese ceremonial blend
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>I FLIPPING DESERVE THIS.</span>
        <small>30 servings</small>
    </h3>

    <h4>Creamy, Super Matcha Latte with MCT Oil for energy, renewal, focus, detox and peace of mind.</h4> 
    <p>Upgrade your morning routine with our creamy, barista style SUPER MATCHA LATTE made exclusively with a proprietary blend of first crop premium Japanese Ceremonial Blend Green Tea and added MCT oil to activate energy, focus, gut health, assist with weight management and mind, body wellness with only 35 calories per serving.</p>

    <p>Guten Free &bull; Vegan &bull; Preservative Free &bull; Soy Free &bull; Non GMO &bull; Keto Friendly</p>

    <div class="product__block">
        <h3>Features &amp; Benefits:</h3>
        <ul>
            <li>Energy</li>
            <li>Focus</li>
            <li>Renewal</li>
            <li>Gut Health</li>
            <li>Weight Loss Management</li>
            <li>Anti-inflammatory</li>
            <li>Antioxidant rich</li>
        </ul>
    </div>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>Ingredients</h3>
    <ul>
        <li>Organic Matcha Tea Leaf</li>
        <li>Natural MCT Oil </li>
        <li>Almond</li>
        <li>Cardamom</li>
        <li>Nutmeg</li>
        <li>Pistachio</li>
    </ul>
</asp:Content> 

<asp:Content ID="DirectionsSection" ContentPlaceHolderID="DirectionsSection" runat="server">
    <h3>How To Use</h3>
    <p>Add 1 scoop of Super Matcha to 8 oz hot water, your favorite milk or over ice. For creamier texture, blend, froth or whisk.</p>
</asp:Content>

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">We only use Organic Japanese Ceremonial Grade Matcha Leaf</div>
    <h2 class="content__title">and with no China imported ingredients like so many others</h2>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Organic</span>
                <span>Matcha</span>
                <span>tea leaf</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="organicmatchatealeaf-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Organic Matcha Tea Leaf">
                <span>Organic</span>
                <span>Matcha</span>
                <span>tea leaf</span>
                <img loading="lazy" src="/images/Site1/ingredients/organicmatchatealeaf.jpg" alt="Tea plants" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Coconut Oil</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="coconutoil-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Coconut Oil">
                <span>Coconut Oil</span>
                <img loading="lazy" src="/images/Site1/ingredients/coconutoil.jpg" alt="Coconut Oil" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Almond</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="almond-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Almond">
                <span>Almond</span>
                <img loading="lazy" src="/images/Site1/ingredients/almond.jpg" alt="Almonds" width="270" height="390">
            </button>
        </div>
        
        <div class="content__item">
            <h3 class="content__header">
                <span>Cardamom</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="cardamom-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Cardamom">
                <span>Cardamom</span>
                <img loading="lazy" src="/images/Site1/ingredients/cardamom.jpg" alt="Cardamom" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Nutmeg</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="nutmeg-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Nutmeg">
                <span>Nutmeg</span>
                <img loading="lazy" src="/images/Site1/ingredients/nutmeg.jpg" alt="Nutmeg" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Pistachio</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="pistachio-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Pistachio">
                <span>Pistachio</span>
                <img loading="lazy" src="/images/Site1/ingredients/pistachio.jpg" alt="Pistachios" width="270" height="390">
            </button>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ProductReviews" ContentPlaceHolderID="ProductReviews" runat="server">
  	<%= Html.Partial("ReviewGroup", new ViewDataDictionary
    {
        { "ImageUrl", "/images/Site1/reviews/SML/photo.jpg" },
        { "ImageAlt", "" },
        { "Reviews", ProductReviews.Matcha }
    }) %>
</asp:Content> 