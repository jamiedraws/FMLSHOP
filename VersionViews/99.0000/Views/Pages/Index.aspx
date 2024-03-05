<%@ Page Language="C#" MasterPageFile="~/VersionViews/99.0000/Views/Layouts/InternalLayout.master" Inherits="System.Web.Mvc.ViewPage<OrderPageViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.UIComponents" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server"></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<%
	string productName = SettingsManager.ContextSettings["Label.ProductName"];

	OrderButton orderButton = ViewData["OrderButton"] as OrderButton ?? new OrderButton();
%>

<main aria-label="Products" class="view product-cards section">
	<div class="view__anchor" id="main"></div>
	<div class="view__in product-cards__in section__in">

		<div class="product-cards__group">
			<div class="product-card product-card--chocolate">
				<div class="product-card__text">
					<div class="product-card__title">Flip 7</div>
					<div class="product-card__desc">Superfood meal replacement chocolate courage shake</div>
					<div class="product-card__price">Price: $44.95</div>
					<div class="product-card__action">
						<a href="#flip-7-chocolate" class="button">
							<span>Order Now</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/flip-7-chocolate.png" alt="Bag of the flip 7 chocolate shake" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="F7C-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Flip 7 Chocolate Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/F7C-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>

			<div class="product-card product-card--vanilla">
				<div class="product-card__text">
					<div class="product-card__title">Flip 7</div>
					<div class="product-card__desc">Superfood meal replacement vita vanilla shake</div>
					<div class="product-card__price">Price: $44.95</div>
					<div class="product-card__action">
						<a href="#flip-7-vanilla" class="button">
							<span>Order Now</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/flip-7-vanilla.png" alt="Bag of the flip 7 vanilla shake" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="F7V-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Flip 7 Vanilla Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/F7V-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>

			<div class="product-card product-card--pomegranate">
				<div class="product-card__text">
					<div class="product-card__title">Collagen<br>Peptides + Biotin</div>
					<div class="product-card__desc">Hair &bull; Skin &bull; Nails</div>
					<div class="product-card__price">Price: $29.95</div>
					<div class="product-card__action">
						<a href="#collagen-peptides-biotin" class="button">
							<span>Order Now</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/collagen-peptides-biotin.png" alt="Bag of the collagen peptides + biotin" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="CPB-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Collagen Peptides + Biotin Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/CPB-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>
	
			<div class="product-card product-card--matcha">
				<div class="product-card__text">
					<div class="product-card__title">Super<br>Matcha Latte</div>
					<div class="product-card__desc">Japanese Ceremonial Blend</div>
					<div class="product-card__price">Price: $24.95</div>
					<div class="product-card__action">
						<a href="#super-matcha-latte" class="button">
							<span>Order Now</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/super-matcha-latte.png" alt="Bag of the super matcha latte" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="SML-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Super Matcha Latte Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/SML-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>
		
			<div class="product-card product-card--cacao">
				<div class="product-card__text">
					<div class="product-card__title">Mega 4<br>Mushroom</div>
					<div class="product-card__desc">Muscles & joint repair</div>
					<div class="product-card__price">Price: $24.95</div>
					<div class="product-card__action">
						<a href="#order" class="button">
							<span>Coming Soon</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/mega-4-mushroom.png" alt="Bag of the mega 4 mushroom" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="M4M-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Mega 4 Mushroom Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/M4M-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>
	
			<div class="product-card product-card--berry-mint">
				<div class="product-card__text">
					<div class="product-card__title">Relax &<br>Sleep</div>
					<div class="product-card__desc">Mind + body blend<br>for natural sleep</div>
					<div class="product-card__price">Price: $29.95</div>
					<div class="product-card__action">
						<a href="#order" class="button">
							<span>Coming Soon</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/relax-sleep.png" alt="Bag of the relax & sleep" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="RS-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Relax & Sleep Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/RS-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>
	
			<div class="product-card product-card--smart-coffee">
				<div class="product-card__text">
					<div class="product-card__title">Brain<br>Boost</div>
					<div class="product-card__desc">Ultimate nootropic blend</div>
					<div class="product-card__price">Price: $19.95</div>
					<div class="product-card__action">
						<a href="#order" class="button">
							<span>Coming Soon</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/brain-boost.png" alt="Bag of the brain boost" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="BB-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Brain Boost Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/BB-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>
	
			<div class="product-card product-card--unflavored">
				<div class="product-card__text">
					<div class="product-card__title">Bone Broth<br>Protein</div>
					<div class="product-card__desc">Muscles & joint repair</div>
					<div class="product-card__price">Price: $24.95</div>
					<div class="product-card__action">
						<a href="#order" class="button">
							<span>Coming Soon</span>
						</a>
					</div>
				</div>
				<div class="product-card__picture">
					<picture>
						<img src="/images/Site99/bone-broth-protein.png" alt="Bag of the bone broth protein" width="240" height="242">
					</picture>
					<button type="button" data-modal-dialog-id="BBP-product-label" data-modal-dialog-actor="open" data-modal-dialog-title="Bone Broth Protein Product Label" data-modal-dialog-template-modifier="product-label" data-modal-dialog-iframe="/images/Site99/product-labels/BBP-product-label.png" class="button">
						<span>Product Label</span>
					</button>
				</div>
			</div>
		</div>

	</div>
</main>

<section aria-label="Features and Benefits" class="view features-benefits section">
	<div class="view__in section__in">
		<ul>
			<li>Gluten free</li>
			<li>100% vegan</li>
			<li>Preservative free</li>
			<li>Soy free</li>
			<li>Non GMO</li>
			<li>Keto friendly</li>
		</ul>
	</div>
</section>

</asp:Content>