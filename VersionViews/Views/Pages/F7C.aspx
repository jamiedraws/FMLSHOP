<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>
<%@ Import Namespace="FMLSHOP.Text" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-F7C-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/F7C/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/F7C/product.jpg" alt="Flip 7 Chocolate" width="585" height="799">
                </picture>
                <div class="hero__text">
                    <span id="hero-F7C-title" class="hero__title">
                        FLIP HOW YOU FEEL.
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
</asp:Content> 

<asp:Content ID="ProductTitle" ContentPlaceHolderID="ProductTitle" runat="server">
    FLIP 7 MEAL REPLACEMENT
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Chocolate Courage
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>FLIP THE WAY YOU AGE WITH 1 SHAKE A DAY.</span>
        <small>15 servings</small>
        <small>Clean, Convenient SuperFood Meal Replacement</small>
    </h3>

    <h4>CHOCOLATE COURAGE SHAKE</h4>
    <p>Feel better, fast with one shake a day.  FLIP 7 is an unmatched, all-in-one meal replacement SUPER FOOD powder with the most nutrient rich balance of health extending blends formulated to support whole body and mind wellness.The vegan, plant based formula is made with proprietary doctor-tested blends and clean ingredients that work synergistically to enhance metabolism and provide all the super greens, adaptogens, prebiotics, probiotics, digestive enzymes, vitamins and minerals plus 20 grams of protein in each serving without bloat you get from other powders. </p>

    <p><i>No Bloat! 100% Delicious. Smooth, creamy texture.</i></p>

    <p>Gluten Free &bull; Vegan &bull; Preservative Free &bull; Soy Free &bull; Non GMO &bull; Keto Friendly</p>

    <h3>Features &amp; Benefits:</h3>
    <ul data-column-count="2">
        <li>Whole Body Wellness</li>
        <li>Energy</li>
        <li>Better Sleep</li>
        <li>Weight Management</li>
        <li>Immunity</li>
        <li>Gut Health</li>
        <li>Microbiome Balance</li>
        <li>Brain Support</li>
        <li>Adrenal Support</li>
        <li>Recovery</li>
        <li>Reduce Cravings</li>
        <li>Vitamin + Mineral Boost</li>
    </ul>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>Ingredients</h3>
    <p>7 Health Extending Mega Blends + 22 grams of plant - based protein in each serving. 85 ingredients that work synergistically to help you age and feel better.</p>
    <ul>
        <li>Plant Proteins</li>
        <li>Antioxidants</li>
        <li>SuperFood Greens</li>
        <li>Premium Adaptogenics</li>
        <li>PreBiotics</li>
        <li>ProBiotics</li>
        <li>Digestive Enzymes</li>
        <li>25 Vitamins + Minerals</li>
    </ul>
</asp:Content> 

<asp:Content ID="DirectionsSection" ContentPlaceHolderID="DirectionsSection" runat="server">
    <h3>How To Use</h3>
    <p>For the healthiest meal of your day simply add 2 scoops of FLIP 7 to 8-12 ounces of cold water, or your daily smoothie. Shake vigorously or blend and enjoy.</p>
</asp:Content> 

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">85 ageless ingredients in one meal</div>
    <h2 class="content__title">7 HEALTH EXTENDING MEGA BLENDS</h2>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Plant</span>
                <span>Proteins</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="plantproteins-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Plant Proteins">
                <span>Plant</span>
                <span>Proteins</span>
                <img loading="lazy" src="/images/Site1/ingredients/plantproteins.jpg" alt="Mushrooms" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Antioxidants</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="antioxidants-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Antioxidants">
                <span>Antioxidants</span>
                <img loading="lazy" src="/images/Site1/ingredients/antioxidant.jpg" alt="Onion" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Superfood</span>
                <span>Greens</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="superfoodgreens-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="superfoodgreens">
                <span>Superfood</span>
                <span>Greens</span>
                <img loading="lazy" src="/images/Site1/ingredients/superfoodgreens.jpg" alt="Growing plants" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Premium</span>
                <span>Adaptogenics</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="premimumadaptogenics-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="premimumadaptogenics">
                <span>Premium</span>
                <span>Adaptogenics</span>
                <img loading="lazy" src="/images/Site1/ingredients/premimumadaptogenics.jpg" alt="Maca Powder" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Prebiotics</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="prebiotics-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="prebiotics">
                <span>Prebiotics</span>
                <img loading="lazy" src="/images/Site1/ingredients/prebiotics.jpg" alt="White Powder" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Digestive</span>
                <span>Enzymes</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="digestiveenzymes-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="digestiveenzymes">
                <span>Digestive</span>
                <span>Enzymes</span>
                <img loading="lazy" src="/images/Site1/ingredients/digestiveenzymes.jpg" alt="Small pools of water" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>25 Vitamins</span>
                <span>And Minerals</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="25vitaminsandminerals-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="25vitaminsandminerals">
                <span>25 Vitamins</span>
                <span>And Minerals</span>
                <img loading="lazy" src="/images/Site1/ingredients/25vitaminsandminerals.jpg" alt="A bunch of different varieties of fruit" width="270" height="390">
            </button>
        </div>
    </div>
</asp:Content>

<asp:Content ID="ProductReviews" ContentPlaceHolderID="ProductReviews" runat="server">
    <%
        ProductReviews.Flip7.ForEach(review => review.Product = "Flip 7");    
    %>
  	<%= Html.Partial("ReviewGroup", new ViewDataDictionary
    {
        { "ImageUrl", "/images/Site1/reviews/F7C/photo.jpg" },
        { "ImageAlt", "" },
        { "Reviews", ProductReviews.Flip7 }
    }) %>
</asp:Content> 