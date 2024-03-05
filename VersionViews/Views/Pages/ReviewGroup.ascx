<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>
<%@ Import Namespace="FMLSHOP.Models" %>

<%
    string imageUrl = ViewData["ImageUrl"] as string ?? "/images/Site1/pages/home/girl-with-collagen-product.jpg";
    string imageAlt = ViewData["ImageAlt"] as string ?? "Girl holding the Collagen Peptides + Biotin product";
    string uiLayout = ViewData["UILayout"] as string ?? "PictureCarousel";

    List<Review> reviews = ViewData["Reviews"] as List<Review> ?? new List<Review>();

    if (reviews.Count > 0) {
        switch(uiLayout)
        {
            case "PictureCarousel":
                %>
                <section aria-labelledby="reviews-title" class="view content content--reviews section">
                    <div id="reviews" class="view__anchor"></div>
                    <div class="view__in content__in section__in">
                        <div class="section__block">
                            <div class="content__group">
                                <picture class="content__picture">
                                    <img src="<%= imageUrl %>" loading="lazy" alt="<%= imageAlt %>" width="520" height="565" loading="lazy">
                                </picture>
                                <div class="content__text">
                                    <h2 class="content__title" id="reviews-title">
                                        <span>Real People</span>
                                        <span>Real Reviews!</span>
                                    </h2>
                                    <div class="content__rating">
                                        <div class="stars stars--alt5" aria-label="5 stars"></div>
                                    </div>
                                    <div class="content__carousel">
                                        <div class="slide slide--carousel slide--small-nav">
                                            <div class="slide__into" tabindex="0" id="reviews-slider">
                                                <%
                                                    reviews.ForEach(review =>
                                                    {
                                                        %>
                                                        <figure class="slide__item">
                                                            <blockquote>&ldquo;<%= review.Blockquote %>&rdquo;</blockquote>
                                                            <figcaption>
                                                                <h3><%= review.Name %></h3>
                                                                <address><%= review.Location %></address>
                                                            </figcaption>
                                                        </figure>
                                                        <%
                                                    });  
                                                %>
                                            </div>
                                            <div class="slide__nav">
                                                <button aria-label="Previous" class="slide__prev" type="button">
                                                    <span>&laquo;</span>
                                                    <span>Previous</span>
                                                </button>
                                                <span class="slide__spacer">|</span>
                                                <button aria-label="Next" class="slide__next" type="button">
                                                    <span>Next</span>
                                                    <span>&raquo;</span>
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <%
                break;
            case "CardCarousel":
                %>
                <section aria-labelledby="reviews-title" class="view content content--reviews-with-card-carousel section">
                    <div id="reviews" class="view__anchor"></div>
                    <div class="view__in content__in section__in">
                        <div class="section__block">
                            <h2 class="content__title" id="reviews-title">
                                <span>Reviews related to Collagen, Flip 7 and Matcha</span>
                            </h2>
                            <div class="slide slide--review-card-carousel">
                                <div class="slide__into" tabindex="0" id="card-reviews-slider">
                                    <%
                                        reviews.ForEach(review =>
                                        {
                                            %>
                                            <figure class="slide__item">
                                                <div class="review-card">
                                                    <div class="review-card__group">
                                                        <figcaption class="review-card__caption">
                                                            <p class="review-card__product-name"><%= review.Product %></p>
                                                            <h3 class="review-card__name"><%= review.Name %></h3>
                                                            <address class="review-card__address"><%= review.Location %></address>
                                                        </figcaption>
                                                        <div class="review-card__rating">
                                                            <div class="stars stars--alt5" aria-label="5 stars"></div>
                                                        </div>
                                                        <blockquote class="review-card__blockquote">&ldquo;<%= review.Blockquote %>&rdquo;</blockquote>
                                                    </div>
                                                </div>
                                            </figure>
                                            <%
                                        });  
                                    %>
                                </div>
                                <div class="slide__nav">
                                    <button aria-label="Next" class="slide__next" type="button">
                                        <svg class="icon">
                                            <use href="#icon-double-chevron"></use>
                                        </svg>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <%
                break;
        }
    } 
%>