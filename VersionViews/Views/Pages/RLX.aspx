<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-RLX-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/RLX/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/RLX/product.jpg" alt="Relax & Sleep" width="585" height="810">
                </picture>
                <div class="hero__text">
                    <span id="hero-RLX-title" class="hero__title">
                        Dream On. Better Sleep is Here. 
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
    Relax & Sleep
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Mind + Body Blend for Natural Sleep
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>Berry Mint Dream</span>
        <small>30 Servings</small>
        <small>Sleep Better. Feel Better.</small>
    </h3>

    <p>Good sleep is crucial to physical, emotional, energy and hormone regulation and regeneration. Our proprietary SLEEP COMPLEX POWDER AND HERBAL COMPLEX blend in Relax & Sleep is a  non-addictive, natural way to calm your body and mind for deeper relaxation, restoration and rejuvenating sleep.  Make it part of your nightly routine and blend the delicious Berry Mint powder with tea or hot water to sleep better and feel better without risks you get from other sleep aids such as inaccurate dosing, high sugar content or dependency. The sleep of your dreams is here.</p>

    <p><i>No Bloat. 100% Delicious.</i></p>

    <h3>Features &amp; Benefits:</h3>
    <p>Daily use of Relax & Sleep may support:</p>
    <ul data-column-count="2">
        <li>Deeper Natural Sleep</li>
        <li>Mind & Body Relaxation</li>
        <li>Waking Performance</li>
        <li>Overall Health & Wellness</li>
    </ul>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>Ingredients</h3>
    <ul>
        <li>
            <div>
                <h4>Ashwagandha</h4>
                <p>Ashwagandha is an adaptogen that may improve cognitive function, help calm the brain, reduce brain fog and enhance mood. It promotes better immunity and increased quality of sleep and may assist with greater resiliency against anxiety and physical and mental stress.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>L-theanine</h4>
                <p>L-theanine has a range of potential benefits for mind, body, overall health, and well-being.  It may help with stress reduction, have a calming effect on the mind and reduce feelings of anxiety, reduce inflammation, and promote relaxation, assisting with better sleep quality.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Melatonin</h4>
                <p>Melatonin may help regulate sleep patterns, reset circadian rhythms, assist with insomnia and overall longer and better quality of sleep. It may also help reduce anxiety and stress, have a positive effect on mood and symptoms of depression. The antioxidant properties may protect against free radicals, reduce inflammation, and enhance immune function. </p>
            </div>
        </li>
        <li>
            <div>
                <h4>Matcha</h4>
                <p>Matcha contains beneficial L-Theanine, chlorophyll, essential amino acids and EGCG, a type of catechin that promotes fat oxidation and thermogenesis.  Matcha may increase cognitive function, focus, promote relaxation and increase alpha waves in the brain, reducing mental stress.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Passionflower</h4>
                <p>Passionflower has been used in traditional medicine to treat and reduce anxiety and insomnia. It is considered a natural mild sedative that may help promote a calmer state of mind and greater quality of sleep.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Holy Basil</h4>
                <p>Holy Basil is an herb that has been revered in parts of the world as a sacred plant with antioxidant and anti-inflammatory properties. It may promote relaxation and is considered an adaptogen that may help the body cope with stress and anxiety.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Magnesium</h4>
                <p>Magnesium is an essential mineral that plays a role in over 300 biochemical reactions within the body and may improve sleep quality and duration by promoting relaxation, helping reduce stress and anxiety, and supporting the parasympathetic nervous system which is responsible for rest and relaxation. Magnesium may also help regulate melatonin supporting healthier sleep/wake cycles.</p>
            </div>
        </li>
    </ul>
</asp:Content>

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Ashwagandha</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="ashwagandha-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Ashwagandha">
                <span>Ashwagandha</span>
                <img loading="lazy" src="/images/Site1/ingredients/ashwagandha.jpg" alt="Ashwagandha" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>L-theanine</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="l-theanine-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="L-Theanine">
                <span>L-theanine</span>
                <img loading="lazy" src="/images/Site1/ingredients/ltheanine.jpg" alt="L-theanine" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Melatonin</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="melatonin-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Melatonin">
                <span>Melatonin</span>
                <img loading="lazy" src="/images/Site1/ingredients/melatonin.jpg" alt="Melatonin" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Matcha</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="matcha-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Matcha">
                <span>Matcha</span>
                <img loading="lazy" src="/images/Site1/ingredients/matcha.jpg" alt="Matcha" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Passionflower</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="passionflower-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Passionflower">
                <span>Passionflower</span>
                <img loading="lazy" src="/images/Site1/ingredients/passionflower.jpg" alt="Passionflower" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Holy Basil</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="holybasil-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Holy Basil">
                <span>Holy Basil</span>
                <img loading="lazy" src="/images/Site1/ingredients/holybasil.jpg" alt="Holy Basil" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Magnesium</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="magnesium-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Magnesium">
                <span>Magnesium</span>
                <img loading="lazy" src="/images/Site1/ingredients/magnesium.jpg" alt="Magnesium" width="270" height="390">
            </button>
        </div>
    </div>
</asp:Content>