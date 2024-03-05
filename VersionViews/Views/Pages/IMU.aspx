<%@ Page Language="C#" MasterPageFile="~/VersionViews/1.0000/Views/Layouts/ProductDetailLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="Dtm.Framework.Base.Models" %>

<asp:Content ID="ProductHeroBanner" ContentPlaceHolderID="ProductHeroBanner" runat="server">
    <section aria-labelledby="hero-IMU-title" class="hero hero--product-detail-banner">
        <div class="view__in hero__in section__in">
            <div class="hero__group">
                <picture class="hero__media">
                    <source srcset="/images/Site1/hero-banners/IMU/product.webp" type="image/webp">
                    <img src="/images/Site1/hero-banners/IMU/product.jpg" alt="Super Immunity" width="604" height="814">
                </picture>
                <div class="hero__text">
                    <span id="hero-IMU-title" class="hero__title">
                        POWER UP AND FEEL SUPER!
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
    <span>Super Immunity</span>
    <span>ELECTROLYTE BOOST</span>
</asp:Content> 

<asp:Content ID="ProductDescription" ContentPlaceHolderID="ProductDescription" runat="server">
    Cellular hydration &bull; Performance &bull; Recovery
</asp:Content> 

<asp:Content ID="FeaturesSection" ContentPlaceHolderID="FeaturesSection" runat="server">
    <h3 class="product__headline">
        <span>Electric Berry</span>
        <small>16 Servings</small>
        <small>START FEELING SUPER.</small>
    </h3>

    <p>A super dose of health and wellness delivered straight to your cells. Our SUPER IMMUNITY and Electrolyte Boost is a powerful proprietary blend with over 30 vitamins, minerals and antioxidant rich berries and other synergistic ingredients to deliver the most rejuvenating blend of hydration and crucial electrolytes into the cells of your body.  Cellular hydration is essential to overall health, aging, immunity, performance, recovery, cognition and whole body wellness.  It helps get rid of brain fog, fatigue and overall sluggishness by increasing your hydration on the CELLULAR level.</p>

    <p><i>No Bloat! 100% Delicious.</i></p>

    <h3>Features &amp; Benefits:</h3>
    <p>Daily use of Super Immunity may support:</p>
    <ul data-column-count="2">
        <li>Cellular Hydration</li>
        <li>Immunity</li>
        <li>Performance</li>
        <li>Recovery</li>
        <li>Brain Fog</li>
        <li>Energy</li>
        <li>Whole Body Balance</li>
    </ul>
</asp:Content> 

<asp:Content ID="IngredientsSection" ContentPlaceHolderID="IngredientsSection" runat="server">
    <h3 class="product__headline">
        <span>Immunity Blend:</span>
        <span>CELLULAR HYDRATION FROM A MEGA DOSE OF VITAMINS, MINERALS & BERRIES</span>
        <small>Super charge your electrolytes and load up on immunity.</small>
    </h3>

    <p>Supercharge your electrolytes and load up with a proprietary Immunity Blend, Hydration Drip plus critical Vitamins, Minerals and Berries to work at the cellular level.</p>

    <ul>
        <li>
            <div>
                <h4>Vitamin C</h4>
                <p>Vitamin C is essential to protect cells against aging effects of free radicals. It may also shore up the skin&rsquo;s defense system, strengthen skin barriers, boost the immune system, aid in iron absorption, and help reduce the risk of chronic disease and inflammation.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Vitamin D</h4>
                <p>Called the &ldquo;sunshine vitamin,&rdquo; Vitamin D is essential for the immune system, and critical to the ability to absorb calcium and phosphorus for bone strength. Its anti-inflammatory, antioxidant and neuro-protective properties support immune health plus muscle function and brain cell activity. In appropriate doses, may also support kidney function, healthy blood vessels, may help accelerate wound healing and potentially help fight depression</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Vitamin B6</h4> 
                <p>B6 is essential for over 200 chemical reactions in your body and is necessary for transporting oxygen through the body, brain development and may help guard against infection. It supports the brain and body from the effects of stress and inflammation and promotes a healthy nervous system, blood vessels and better circulation.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Vitamin B12</h4>
                <p>B12 helps make DNA in your body, helps keep blood and nerve cells healthy and is helps prevent anemia which affects energy levels and mood. It may support bone health and help prevent osteoporosis and may reduce risk of macular degeneration as well as decrease homocysteine levels. </p>
            </div>
        </li>
        <li>
            <div>
                <h4>Echinacea</h4>
                <p>Echinacea is an herb with anti-inflammatory and immune boosting properties and may help prevent and fight off infections such as the common cold and flu. It contains antibacterial and antiviral properties that may protect the body from harmful pathogens and promote overall well-being.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Aronia Berry</h4>
                <p>Aronia Berries are packed with antioxidants that help boost the immune system, fight free radicals, and reduce inflammation. They may help boost cellular immunity and strengthen the body&rsquo;s defenses against infections, help regulate blood sugar levels and reduce the risk of chronic diseases.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Elderberry</h4>
                <p>Elderberry extract is rich in antioxidants and may be important to reducing oxidative stress and inflammation on the body. Its immune boosting properties may help fight off viral and bacterial infections and support shortening the symptoms and duration of the flu.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Zinc</h4>
                <p>Zinc is an essential mineral that supports the immune system by helping boost the production of white blood cells that help fight infection and disease. It has been linked to a reduced risk of respiratory infections and may help reduce severity and duration of illness. Zinc also may play a role in wound healing, DNA synthesis and the regulation of taste and smell.</p>
            </div>
        </li>
        <li>
            <div>
                <h4>Magnesium</h4>
                <p>Magnesium is vital to immunity and its role in the regulation of white blood cells and supporting the production of antibodies. It may assist with chronic inflammation and oxidative stress is essential for energy production, DNA replication and the synthesis of proteins and neurotransmitters.</p>
            </div>
        </li>
    </ul>
</asp:Content>

<asp:Content ID="ProductIngredients" ContentPlaceHolderID="ProductIngredients" runat="server">
    <div class="banner content__banner">CELLULAR HYDRATION FROM A MEGA DOSE OF VITAMINS, MINERALS & BERRIES</div>
    <h2 class="content__title">Supercharge your electrolytes and load up with a proprietary Immunity Blend, Hydration Drip plus critical Vitamins, Minerals and Berries to work at the cellular level.</h2>
    <div class="content__group">
        <div class="content__item">
            <h3 class="content__header">
                <span>Vitamin C</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="vitaminc-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Vitamin C">
                <span>Vitamin C</span>
                <img loading="lazy" src="/images/Site1/ingredients/vitaminc.jpg" alt="Vitamin C" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Vitamin D</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="vitamind-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Vitamin D">
                <span>Vitamin D</span>
                <img loading="lazy" src="/images/Site1/ingredients/vitamind.jpg" alt="Vitamin D" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Vitamin B6</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="vitaminb6-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Vitamin B6">
                <span>Vitamin B6</span>
                <img loading="lazy" src="/images/Site1/ingredients/vitaminb6.jpg" alt="Vitamin B6" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Vitamin B12</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="vitaminb12-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Vitamin B12">
                <span>Vitamin B12</span>
                <img loading="lazy" src="/images/Site1/ingredients/vitaminb12.jpg" alt="Vitamin B12" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Echinacea</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="echinacea-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Echinacea">
                <span>Echinacea</span>
                <img loading="lazy" src="/images/Site1/ingredients/echinacea.jpg" alt="Echinacea" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Aronia Berry</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="aroniaberry-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Aronia Berry">
                <span>Aronia Berry</span>
                <img loading="lazy" src="/images/Site1/ingredients/aroniaberry.jpg" alt="Aronia Berry" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Elderberry</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="elderberry-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Elderberry">
                <span>Elderberry</span>
                <img loading="lazy" src="/images/Site1/ingredients/elderberry.jpg" alt="Elderberry" width="270" height="390">
            </button>
        </div>

        <div class="content__item">
            <h3 class="content__header">
                <span>Zinc</span>
            </h3>
            <button class="content__button" type="button" data-modal-dialog-id="zinc-container" data-modal-dialog-actor="open" data-ingredient-id="<%= DtmContext.VersionId %>" data-ingredient-name="Zinc">
                <span>Zinc</span>
                <img loading="lazy" src="/images/Site1/ingredients/zinc.jpg" alt="Zinc" width="270" height="390">
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