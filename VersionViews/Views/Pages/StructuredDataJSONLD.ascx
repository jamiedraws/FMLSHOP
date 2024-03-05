<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Newtonsoft.Json.Linq" %>
<%@ Import Namespace="FMLSHOP.StructuredData" %>

<%
    var type = ViewData["Type"] as string ?? string.Empty;

    if (type.Equals("BreadcrumbList"))
    {
        var listItems = ViewData["ListItems"] as List<FMLSHOP.StructuredData.ListItem> ?? new List<FMLSHOP.StructuredData.ListItem>();
        %>
        <script type="application/ld+json">
        <%
            var structuredData = new JObject(
                new JProperty("@context", "https://schema.org"),
                new JProperty("@type", "BreadcrumbList"),
                new JProperty("itemListElement",
                    new JArray(
                        from listItem in listItems
                        select new JObject(
                            new JProperty("@type", "ListItem"),
                            new JProperty("position", (listItems.IndexOf(listItem) + 1).ToString()),
                            new JProperty("name", listItem.Name),
                            new JProperty("item", listItem.Item)
                        )
                    )
                )
            );

            Response.Write(structuredData.ToString());
        %>
        </script>
        <%
    }

    if (type.Equals("Product"))
    {
        var product = ViewData["Product"] as FMLSHOP.StructuredData.Product ?? new FMLSHOP.StructuredData.Product();
        %>
        <script type="application/ld+json">
        <% 
           	JObject structuredData = new JObject(
				new JProperty("@context", "https://schema.org"),
                new JProperty("@type", "Product"),
				new JProperty("@id", product.Id),
				new JProperty("name", product.Name),
                new JProperty("description", product.Description),
				new JProperty("image", product.Image),
				new JProperty("sku", product.Sku),
				new JProperty("brand", product.Brand),
                new JProperty("offers",
                    new JArray(
                        from offer in product.Offers
                        select new JObject(
                            new JProperty("@type", "Offer"),
                            new JProperty("availability", offer.Avaiability),
                            new JProperty("price", offer.Price),
                            new JProperty("priceCurrency", offer.PriceCurrency),
                            new JProperty("description", offer.Description),
                            new JProperty("sku", offer.Sku)
                        )
                    )
                ),
                new JProperty("review", 
                    new JArray(
                        from review in product.Review
                        select new JObject(
                            new JProperty("@type", "Review"),
                            new JProperty("author", new JObject(
                                new JProperty("@type", "Person"),
                                new JProperty("name", review.Author.Name),
                                new JProperty("address", review.Author.Address)
                            )),
                            new JProperty("reviewRating", new JObject(
                                 new JProperty("@type", "Rating"),
                                 new JProperty("ratingValue", review.ReviewRating.RatingValue)
                            )),
                            new JProperty("reviewBody", review.ReviewBody)
                        )
                    )
                )
			);

			Response.Write(structuredData.ToString());
        %>
        </script>
        <%
    }

    if (type.Equals("Reviews"))
    {
        var reviews = ViewData["Reviews"] as List<FMLSHOP.StructuredData.Review> ?? new List<FMLSHOP.StructuredData.Review>();
        var product = ViewData["ProductName"] as string ?? string.Empty;

        reviews.ForEach(review =>
        {
            %>
            <script type="application/ld+json">
            <% 
                JObject structuredData = new JObject(
                    new JProperty("@context", "https://schema.org"),
                    new JProperty("@type", "Review"),
                    new JProperty("itemReviewed", new JObject(
                        new JProperty("@type", "Product"),
                        new JProperty("name", product)
                    )),
                    new JProperty("author", new JObject(
                        new JProperty("@type", "Person"),
                        new JProperty("name", review.Author.Name),
                        new JProperty("address", review.Author.Address)
                    )),
                    new JProperty("reviewRating", new JObject(
                            new JProperty("@type", "Rating"),
                            new JProperty("ratingValue", review.ReviewRating.RatingValue)
                    )),
                    new JProperty("reviewBody", review.ReviewBody)
                );

                Response.Write(structuredData.ToString());
            %>
            </script>
            <%
        });
    }
%>