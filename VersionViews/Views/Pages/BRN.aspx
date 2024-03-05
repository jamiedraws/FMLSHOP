<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-BRN-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/BRN/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/BRN/product.jpg" alt="Brain Boost" width="579" height="775">
                </picture>
                <div class="hero__text">
                    <span id="hero-BRN-title" class="hero__title">
                        A Natural way to boost your brain.
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
    Brain Boost
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    THE ULTIMATE NOOTROPIC BLEND & PROPRIETARY THERMOGENIC COMPLEX    
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>Smart Coffee</span>
        <small>30 Servings</small>
        <small>Give Your Brain A Boost</small>
    </h3>

    <p>The most comprehensive formula for an aging brain with our proprietary NOOTROPIC SMART START COMPLEX AND THERMOGENIC ENERGY BOOSTER blends. This super formula is made with clean ingredients and combines the very best plant derived extracts to safely support and enhance brain function including clarity, memory, mood and motivation so you can say flip brain fog to focus and cognitive clarity. </p>

    <p><i>No Bloat! 100% Delicious.</i></p>

    <h3>Features &amp; Benefits:</h3>
    <p>Daily use of Brain Boost may support:</p>
    <ul data-column-count="2">
        <li>Memory</li>
        <li>Cognition</li>
        <li>Clarity</li>
        <li>Focus</li>
        <li>Energy</li>
        <li>Mood</li>
        <li>Motivation</li>
    </ul>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3>NOOTROPIC SMART START COMPLEX AND THERMOGENIC ENERGY BOOSTER</h3>
    <p>We use only cutting-edge natural ingredients such as Ginkgo Biloba, Lion&rsquo;s Mane Mushroom, Alpha GPC, Rhodiola, B12.</p>

    <ul>
        <li>
            <div>
                <h4>Ginkgo Biloba</h4>
                <p>Ginkgo Biloba has antioxidant and anti-aging properties that may also enhance memory, improve learning and thinking, increase dopamine levels, adapt to stress, help ease depression and anxiety, improve vision and blood circulation to the brain.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Rhodiola Rosea</h4>
                <p>Rhodiola Rosea is an adaptogen used to support the reduction of stress, fight fatigue, and may increase mood, mental performance, memory, plus physical and mental fitness, and resilience.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Lion&rsquo;s Mane</h4>
                <p>Called the &ldquo;smart mushroom,&rdquo; Lion&rsquo;s Mane can potentially improve memory, focus, clarity and help protect against both physical and mental stress. Research suggests the plant compounds in Lion&rsquo;s Mane mushrooms may help stimulate the growth of new brain cells, improve cognition, may relieve depression and anxiety, support gut health, heart health, and immunity.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Chicory Root</h4>
                <p>Chicory Root is rich in essential minerals and antioxidant properties that may protect against cognitive decline. It has fiber and prebiotics that may also boost digestive health, help regulate blood sugar, fight inflammation and aid in weight loss.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Alpha GPC</h4>
                <p>Used by athletes for muscle and athletic performance, Alpha GPC also may increase mental performance, memory, and cognitive function, increase blood flow to the brain, improve thinking skills and learning abilities.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>L-theanine</h4>
                <p>L-theanine has a range of potential benefits for overall mind and body well-being.  It may help with stress reduction, have a calming effect on the mind, reduce feelings of anxiety, promote relaxation and help reduce inflammation.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Brahmi Bacopa</h4>
                <p>Bacopa is a plant that has been used for centuries in Ayurvedic medicine that may increase certain brain chemicals involved in thinking, learning, memory while elevating attention, cognition and impulse controls as well as while reducing anxiety. It is rich with antioxidant and anti-inflammatory properties.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Green Coffee Bean Extract</h4>
                <p>Green coffee bean extract may assist with boosting metabolism, easing stress, increasing energy and weight loss. It may also promote blood sugar regulation and improve health markers, such as blood pressure and cholesterol.</p>
            </div>
        </li>
    </ul>
</asp:Content>

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">NOOTROPIC SMART START COMPLEX AND THERMOGENIC ENERGY BOOSTER</div>
    <h2 class="content__title">We use only cutting-edge natural ingredients such as Ginkgo Biloba, Lion’s Mane Mushroom, Alpha GPC, Rhodiola, B12</h2>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Ginkgo Biloba</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="ginkgobiloba-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Ginkgo Biloba">
                <span>Ginkgo Biloba</span>
                <img loading="lazy" src="/images/Site1/ingredients/ginkgobiloba.jpg" alt="Ginkgo Biloba" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Rhodiola Rosea</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="rhodiolarosea-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Rhodiola Rosea">
                <span>Rhodiola Rosea</span>
                <img loading="lazy" src="/images/Site1/ingredients/rhodiolarosea.jpg" alt="Rhodiola Rosea" width="270" height="390">
            </button>
        </div>

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
                <span>Chicory Root</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="chicoryroot-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Chicory Root">
                <span>Chicory Root</span>
                <img loading="lazy" src="/images/Site1/ingredients/chicoryroot.jpg" alt="Chicory Root" width="270" height="390">
            </button>
        </div>
        
        <div class="content__item">
            <h3 class="content__header">
                <span>Alpha GPC</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="alphagpc-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Alpha GPC">
                <span>Alpha GPC</span>
                <img loading="lazy" src="/images/Site1/ingredients/alphagpc.jpg" alt="Alpha GPC" width="270" height="390">
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
                <span>Brahmi Bacopa</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="brahmibacopa-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Brahmi Bacopa">
                <span>Brahmi Bacopa</span>
                <img loading="lazy" src="/images/Site1/ingredients/brahmibacopa.jpg" alt="Brahmi Bacopa" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
               <span>Green Coffee Bean Extract</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="greencoffeebeanextract-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Green Coffee Bean Extract">
                <span>Green Coffee Bean Extract</span>
                <img loading="lazy" src="/images/Site1/ingredients/greencoffeebeanextract.jpg" alt="Green Coffee Bean Extract" width="270" height="390">
            </button>
        </div>
    </div>
</asp:Content>