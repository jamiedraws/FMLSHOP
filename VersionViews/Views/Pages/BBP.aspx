<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-BBP-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/BBP/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/BBP/product.jpg" alt="Bone Broth Protein" width="579" height="775">
                </picture>
                <div class="hero__text">
                    <span id="hero-BBP-title" class="hero__title">
                        Fuel Your Aging Muscles, Joints + Bones
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
    Bone Broth Protein
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Muscle &amp; Joint Repair
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>Supports Body Aches, Joint Health, Inflammation &amp; Pain</span>
        <small>20 servings</small>
    </h3>
    <p>Get 20g of the most effective and bioavailable Hydrolyzed Bovine Collagen I &amp; III to help bring muscles, tendons and joints into top performance, help reduce inflammation and provide anti-aging, skin-smoothing support. Our unique and scientific blend helps boost gut health, supports immune system function and makes getting the protein you need a no brainer.</p>
    <p>Simply mix into hot or warm water or add to a smoothie and start feeling brand new.</p>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>Ingredients</h3>
    <ul>
        <li>Hydrolyzed Bovine Collagen I &amp; III</li>
        <li>Turmeric Root</li>
        <li>Boswella Serrata</li>
        <li>Ginger</li>
        <li>Cardamom</li>
        <li>Nutmeg</li>
        <li>Apple Cider Vinegar</li>
    </ul>
</asp:Content> 

<asp:Content ID="DirectionsSection" ContentPlaceHolderID="DirectionsSection" runat="server">
    <h3>How To Use</h3>
    <p>Mix 1 serving in 8-12 oz of hot or cold water to add to your daily shake. Stir or blend well.</p>
</asp:Content>

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">Only the best ingredients with advanced synergistic value for better results</div>
    <span class="content__title">&nbsp;</span>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Apple Cider Vinegar</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="applecidervinegar-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Apple Cider Vinegar">
                <span>Apple Cider Vinegar</span>
                <img loading="lazy" src="/images/Site1/ingredients/applecidervinegar.jpg" alt="Apple Cider Vinegar" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Hydrolized Bovine Collagen I & III</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="hydrolizedbovinecollagen-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Hydrolized Bovine Collagen">
                <span>Hydrolized Bovine Collagen I & III</span>
                <img loading="lazy" src="/images/Site1/ingredients/hydrolizedbovinecollagen.jpg" alt="Hydrolized Bovine Collagen I & III" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Turmeric Root</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="turmericroot-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Turmeric Root">
                <span>Turmeric Root</span>
                <img loading="lazy" src="/images/Site1/ingredients/turmericroot.jpg" alt="Turmeric Root" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Boswella Serrata</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="boswellaserrata-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Boswella Serrata">
                <span>Boswella Serrata</span>
                <img loading="lazy" src="/images/Site1/ingredients/boswellaserrata.jpg" alt="Boswella Serrata" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Ginger</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="ginger-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Ginger">
                <span>Ginger</span>
                <img loading="lazy" src="/images/Site1/ingredients/ginger.jpg" alt="Ginger" width="270" height="390">
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
    </div>
</asp:Content>