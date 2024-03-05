<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.Text" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-CPB-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/CPB/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/CPB/product.jpg" alt="Collagen Peptides + Biotin" width="620" height="708">
                </picture>
                <div class="hero__text">
                    <span id="hero-CPB-title" class="hero__title">
                        I AM FLIPPING BEAUTIFUL.
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
    <button type="button" aria-label="Product video 1" class="contain contain--square" data-modal-dialog-id="pdp-video-1" data-modal-dialog-actor="open" data-modal-dialog-iframe="https://player.vimeo.com/video/827002445?title=0&byline=0&portrait=0" data-modal-dialog-title="Video" data-modal-dialog-template-modifier="video" data-src-img="/images/Site1/products/default.svg" data-attr='{ "width":"120", "height":"163", "loading":"lazy", "alt": ""}'>
    </button>
</asp:Content> 

<asp:Content ID="ProductTitle" ContentPlaceHolderID="ProductTitle" runat="server">
    Collagen, Peptides + Biotin
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Ageless Beauty Blend
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>I AM READY TO GLOW</span>
        <small>26 servings</small>
        <small>Better Absorption to Grow, Glow and Strengthen Hair, Skin and Nails. Specially formulated for noticeable results.</small>
    </h3>

    <h4>COLLAGEN, PEPTIDES + BIOTIN AGELESS BEAUTY BLEND GLOWING POMEGRANATE</h4>
    <p>You are flipping beautiful and this progressive, antioxidant rich, skin-smoothing, hair and nail strengthening formula was made to support your hair skin and nails while giving you noticeable results. The proprietary blend uses synergistic ingredients for improved synthesis, metabolization and crucial nutrients to support your daily ageless beauty routine. And the bonus? An extra 9 grams of clean protein in your day.</p>

    <p>Gluten Free &bull; Preservative Free &bull; Soy Free &bull; Non GMO &bull; Keto Friendly</p>

    <div class="product__block">
        <h3>Features &amp; Benefits:</h3>
        <ul data-column-count="2">
            <li>Noticeable improvements in the growth and strength of hair and nails</li>
            <li>Skin smoothing and hydration</li>
            <li>Muscle and Joint support</li>
            <li>Plumper, more elastic skin</li>
            <li>Skin hydration</li>
            <li>Skin smoothing</li>
            <li>Strand Strength and Hair Growth</li>
            <li>Nail Strength and Growth</li>
            <li>Gut Support</li>
            <li>Fight free-radicals that cause premature aging</li>
            <li>Muscle + Join support</li>
            <li>9 grams of added protein</li>
        </ul>
    </div>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>Ingredients</h3>
    <ul>
        <li>Collagen Peptides</li>
        <li>Biotin</li>
        <li>Vitamin C</li>
        <li>Hyaluronic Acid</li>
        <li>Vitamin B6</li>
        <li>Copper</li>
        <li>Zinc</li>
        <li>Niacin</li>
        <li>Aronia Berry</li>
    </ul>
</asp:Content> 

<asp:Content ID="DirectionsSection" ContentPlaceHolderID="DirectionsSection" runat="server">
    <h3>How To Use</h3>
    <p>For stronger hair, nails and glowing skin, add 1 scoop to 8 oz cold or hot water or to your daily smoothie. Stir or blend well.</p>
</asp:Content> 

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">Formulated with the the finest type 1 &amp; III grass fed bovine hydrolyzed collagen</div>
    <div class="content__header">
        <h2 class="content__title">Plus we added a super dose of Biotin for accelerated results</h2>
        <p>+ Vitamin C, Hyaluronic Acid, B6, Zinc, Copper, Niacin and Aronia Berry</p>
    </div>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Vitamin C</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="vitaminc-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Vitamin C">
                <span>Vitamin C</span>
                <img loading="lazy" src="/images/Site1/ingredients/vitaminc.jpg" alt="Oranges" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Hyaluronic Acid</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="hyaluronicacid-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Hyaluronic Acid">
                <span>Hyaluronic Acid</span>
                <img loading="lazy" src="/images/Site1/ingredients/hyaluronicacid.jpg" alt="Limes" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Vitamin B6</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="vitaminb6-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Vitamin B6">
                <span>Vitamin B6</span>
                <img loading="lazy" src="/images/Site1/ingredients/vitaminb6.jpg" alt="Melon" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Zinc</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="zinc-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Zinc">
                <span>Zinc</span>
                <img loading="lazy" src="/images/Site1/ingredients/zinc.jpg" alt="Spinach" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Copper</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="copper-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Copper">
                <span>Copper</span>
                <img loading="lazy" src="/images/Site1/ingredients/copper.jpg" alt="Bowls of grains" width="270" height="390">
            </button>
        </div>
      
        <div class="content__item">
            <h3 class="content__header">
                <span>Niacin</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="niacin-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Niacin">
                <span>Niacin</span>
                <img loading="lazy" src="/images/Site1/ingredients/niacin.jpg" alt="Almonds" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Aronia Berry</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="aroniaberry-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Aronia Berry">
                <span>Aronia Berry</span>
                <img loading="lazy" src="/images/Site1/ingredients/aroniaberry.jpg" alt="Aronia Berries" width="270" height="390">
            </button>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ProductReviews" ContentPlaceHolderID="ProductReviews" runat="server">
  	<%= Html.Partial("ReviewGroup", new ViewDataDictionary
    {
        { "ImageUrl", "/images/Site1/reviews/CPB/photo.jpg" },
        { "ImageAlt", "" },
        { "Reviews", ProductReviews.Collagen }
    }) %>
</asp:Content> 