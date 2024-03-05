<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-MEG-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/MEG/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/MEG/product.jpg" alt="Mega4 Mushroom" width="585" height="810">
                </picture>
                <div class="hero__text">
                    <span id="hero-MEG-title" class="hero__title">
                        I AM FOCUSED, RESILIENT & VIBRANT.
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
    Mega4 Mushroom
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Adaptogenic Complex Blend
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>Cocoa Bliss</span>
        <small>12 Servings</small>
        <small>FLIP for the High Vibrational Shift.</small>
    </h3>

    <p>4 Mega Blends including Ayurvedic Herbal Booster, Antioxidant Support, Adaptogenic Complex and Mushroom Blend.</p>
    
    <p>Our Mega4 Mushroom adaptogenic complex is unmatched. It blends the critical four mushrooms in one delicious formula that also includes an Ayurvedic herbal blend, an Antioxidant blend and Adaptogenic complex for anti-aging, and to help elevate mental and physical stress resiliency, immunity, increase oxygenation and performance, improve focus and memory, increase energy and vitality, aid in liver detoxification and boost mood.</p>

    <p><i>No Bloat! 100% Delicious. Smooth, creamy texture.</i></p>

    <p>Gluten Free &bull; Vegan &bull; Preservative Free &bull; Soy Free &bull; Non GMO &bull; Keto Friendly</p>

    <h3>Features &amp; Benefits:</h3>
    <p>Daily use of Mega4 Mushroom may support:</p>
    <ul data-column-count="2">
        <li>Immunity</li>
        <li>Inflammation</li>
        <li>Performance</li>
        <li>Cognition/Memory/Focus</li>
        <li>Balance and Resiliency</li>
        <li>Mood</li>
        <li>Gut Health</li>
        <li>Vitality</li>
    </ul>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>THE PERFECT DOSE OF LION&rsquo;S MANE, TURKEY TAIL, CHAGA & CORDYCEPS</h3>
    <p>Plus we added an Ayurvedic Herbal Booster and Antioxidant Support for optimum mood and vitality.</p>

    <ul>
        <li>
            <div>
                <h4>Lion&rsquo;s Mane</h4>
                <p>Lion&rsquo;s Mane contains many bioactive and anti-inflammatory substances and may improve fat metabolism and lower triglycerides, contributing to healthier weight and heart health. It may support brain health by stimulating the growth of brain cells, protecting against memory loss, helping reduce symptoms of anxiety and depression, stimulating growth and repair of nerve cells, and protecting against stomach ulcers.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Chaga</h4>
                <p>The powerful antioxidants and compounds in Chaga may help prevent inflammation and potentially slow tumor growth, lower cholesterol, help reduce blood sugar and help fight heart disease. Chaga may regulate the production of cytokines, boosting the immune system and the cell&rsquo;s ability to communicate with one another.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Turkey Tail</h4>
                <p>Turkey Tail contains compounds that may help boost the immune system and improve gut health. It has high levels of antioxidants that promote cellular health and may help slow down the aging process as well as potentially reduce the risk of certain cancers.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Cordyceps</h4>
                <p>Cordyceps has powerful antioxidants that help fight cell damage and neutralize free radicals, important to anti-aging. It may reduce fatigue, boost strength, libido, improve the way your body uses oxygen, and increase the production of ATP, essential for delivering energy to muscles for increased sports performance.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Ashwagandha</h4>
                <p>Ashwagandha is an adaptogen that may improve cognitive function, help calm the brain, reduce brain-fog and enhance mood. It promotes better immunity and increased quality of sleep and may assist with greater resiliency against anxiety and physical and mental stress.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Ginger</h4>
                <p>Ginger is loaded with antioxidants, anti-inflammatories and over 400 compounds that may help prevent stress and damage to DNA, increase serotonin and dopamine, aid in digestion, nausea relief, assist with bloating and intestinal gas and reduce inflammation.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Turmeric</h4>
                <p>Turmeric contains high levels of the active ingredient Curcumin and may have strong anti-inflammatory and antioxidant effects for gut health, brain health and heart health. We add Piperine to our blend to assist with the absorption and bioavailability of Curcumin which may enhance its ability to support metabolism, heart health, cognition and various degenerative diseases.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Holy Basil</h4>
                <p>Holy Basil is an herb that has been revered in parts of the world as a sacred plant with antioxidant and anti-inflammatory properties. It may promote relaxation and is considered an adaptogen that may help the body cope with stress and anxiety.</p>
            </div>
        </li>
    </ul>
</asp:Content>

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">THE PERFECT DOSE OF LION’S MANE, TURKEY TAIL, CHAGA & CORDYCEPS</div>
    <h2 class="content__title">Plus we added an Ayurvedic Herbal Booster and Antioxidant Support for optimum mood and vitality.</h2>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Lion’s Mane</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="lionsmane-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Lions Mane">
                <span>Lion’s Mane</span>
                <img loading="lazy" src="/images/Site1/ingredients/lionsmane.jpg" alt="Lion’s Mane" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Chaga</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="chaga-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Chaga">
                <span>Chaga</span>
                <img loading="lazy" src="/images/Site1/ingredients/chaga.jpg" alt="Chaga" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Turkey Tail</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="turkeytail-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Turkey Tail">
                <span>Turkey Tail</span>
                <img loading="lazy" src="/images/Site1/ingredients/turkeytail.jpg" alt="Turkey Tail" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Cordyceps</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="cordyceps-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Cordyceps">
                <span>Cordyceps</span>
                <img loading="lazy" src="/images/Site1/ingredients/cordyceps.jpg" alt="Cordyceps" width="270" height="390">
            </button>
        </div>

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
                <span>Ginger</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="ginger-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Ginger">
                <span>Ginger</span>
                <img loading="lazy" src="/images/Site1/ingredients/ginger.jpg" alt="Ginger" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Turmeric</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="turmeric-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Turmeric">
                <span>Turmeric</span>
                <img loading="lazy" src="/images/Site1/ingredients/turmeric.jpg" alt="Turmeric" width="270" height="390">
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
    </div>
</asp:Content>