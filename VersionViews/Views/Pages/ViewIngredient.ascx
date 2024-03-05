<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<ClientSiteViewData>" %>
<%@ Import Namespace="Dtm.Framework.ClientSites" %>

<%
    string ingredient = ViewData["Ingredient"] as string ?? string.Empty;

    List<string> ingredients = new List<string>
    {
        "Plant Proteins",
        "Antioxidants",
        "Superfood Greens",
        "Premimum Adaptogenics",
        "Prebiotics",
        "Digestive Enzymes",
        "25 Vitamins and Minerals",
        "Vitamin C",
        "Hyaluronic Acid",
        "Vitamin B6",
        "Zinc",
        "Copper",
        "Niacin",
        "Aronia Berry",
        "Organic Matcha Tea Leaf",
        "Coconut Oil",
        "Organic Matcha",
        "Almond",
        "Cardamom",
        "Nutmeg",
        "Pistachio",
        "Ashwagandha",
        "Cacao",
        "Chaga",
        "Cordyceps",
        "Ginger",
        "Lions Mane",
        "Turkey Tail",
        "Turmeric",
        "Holy Basil",
        "Melatonin",
        "Matcha",
        "Passionflower",
        "Magnesium",
        "Ginkgo Biloba",
        "Rhodiola Rosea",
        "Chicory Root",
        "Alpha GPC",
        "Ginkgo Biloba",
        "Brahmi Bacopa",
        "Green Coffee Bean Extract",
        "L-Theanine",
        "Vitamin D",
        "Vitamin B12",
        "Elderberry",
        "Echinacea",
        "Apple Cider Vinegar",
        "Boswella Serrata",
        "Hydrolized Bovine Collagen",
        "Turmeric Root"
    };

    string ingredientCode = ingredient.ToLower().Replace(" ", string.Empty);
    List<string> ingredientCodes = ingredients.Select(i => i.ToLower().Replace(" ", string.Empty)).ToList();

    if (ingredientCodes.Contains(ingredientCode))
    {
        string sectionId = string.Format("{0}-container", ingredientCode);
        string titleId = string.Format("{0}-title", sectionId);

        string title = ingredients.ElementAt(ingredientCodes.IndexOf(ingredientCode)) ?? string.Empty;
        %>
        <section id="<%= sectionId %>" aria-labelledby="<%= titleId %>" data-modal-dialog-title="<%= title %>" data-modal-dialog-template-modifier="ingredients" data-modal-dialog-container class="view ingredient section">
            <div class="view__in content__text section__in ingredient__in">
                <% switch (ingredientCode) { %>
                    <% case "plantproteins": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/plantproteins.jpg" alt="Mushrooms" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">Plant Proteins</h2>
                                <ul>
                                    <li>Pea protein</li>
                                    <li>Organic brown rice protein</li>
                                    <li>Organic Sacha inchi protein</li>
                                    <li>Amaranth</li>
                                    <li>Organic quinoa</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "antioxidants": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/antioxidant.jpg" alt="Onion" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">Antioxidants</h2>
                                <ul>
                                    <li>Organic coconut flower nectar</li>
                                    <li>Organic acai berry</li>
                                    <li>Organic maqui berry</li>
                                    <li>Organic camu camu</li>
                                    <li>Organic strawberry</li>
                                    <li>Organic acerola</li>
                                    <li>Aronia berry</li>
                                    <li>Organic blackberry</li>
                                    <li>Organic blueberry</li>
                                    <li>Organic raspberry</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "superfoodgreens": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/superfoodgreens.jpg" alt="Growing plants" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">Superfood Greens</h2>
                                <ul class="ingredient__col-2">
                                    <li>Organic beet</li>
                                    <li>Organic carrot</li>
                                    <li>Organic tomato</li>
                                    <li>Organic spinach</li>
                                    <li>Organic spirulina</li>
                                    <li>Organic broccoli</li>
                                    <li>Organic kale</li>
                                    <li>Cabbage</li>
                                    <li>Organic parsley leaf</li>
                                    <li>Brussel sprouts</li>
                                    <li>Cucumber</li>
                                    <li>Organic celery</li>
                                    <li>Organic sweet potato</li>
                                    <li>Green bell pepper</li>
                                    <li>Cauliflower</li>
                                    <li>Asparagus</li>
                                    <li>Organic chlorella</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "premimumadaptogenics": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/premimumadaptogenics.jpg" alt="Maca Powder" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Premium</span>
                                    <span>Adaptogenics</span>
                                </h2>
                                <ul>
                                    <li>Maca root</li>
                                    <li>Organic ashwagandha root</li>
                                    <li>Organic lion&rsquo;s mane</li>
                                    <li>Organic reishi</li>
                                    <li>Organic shiitake</li>
                                    <li>Organic cordyceps</li>
                                    <li>Organic ginger root</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "prebiotics": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/prebiotics.jpg" alt="White powder" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">Prebiotics</h2>
                                <ul>
                                    <li>Lactobacillus rhamnosus</li>
                                    <li>Bifidobacterium bifidum</li>
                                    <li>Bifidobacterium longum</li>
                                    <li>Lactobacillus acidophilus</li>
                                    <li>Lactobacillus casei</li>
                                    <li>Streptococcus thermophilus</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "digestiveenzymes": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/digestiveenzymes.jpg" alt="Small pools of water" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Digestive</span>
                                    <span>Enzymes</span>
                                </h2>
                                <ul>
                                    <li>Cellulase</li>
                                    <li>Amylase</li>
                                    <li>Protease</li>
                                    <li>Lipase</li>
                                    <li>Lactase</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "25vitaminsandminerals": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/25vitaminsandminerals.jpg" alt="A bunch of different fruit varieties" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>25 Vitamins</span>
                                    <span>And Minerals</span>
                                </h2>
                                <ul class="ingredient__col-3">
                                    <li>Vitamin A</li>
                                    <li>Vitamin C</li>
                                    <li>Vitamin D</li>
                                    <li>Vitamin E</li>
                                    <li>Thiamin</li>
                                    <li>Riboflavin</li>
                                    <li>Niacin</li>
                                    <li>Vitamin B6</li>
                                    <li>Folate</li>
                                    <li>Vitamin B12</li>
                                    <li>Biotin</li>
                                    <li>Pantothenic acid</li>
                                    <li>Calcium</li>
                                    <li>Iron</li>
                                    <li>Phosphorus</li>
                                    <li>Iodine</li>
                                    <li>Magnesium</li>
                                    <li>Zinc</li>
                                    <li>Selenium</li>
                                    <li>Copper</li>
                                    <li>Manganese</li>
                                    <li>Chromium</li>
                                    <li>Chloride</li>
                                    <li>Sodium</li>
                                    <li>Potassium</li>
                                </ul>
                            </div>
                        </div>
                    <% break; %>

                    <% case "vitaminc": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/vitaminc.jpg" alt="Oranges" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Vitamin C</span>
                                </h2>
                                <p>Vitamin C is essential to protect cells against aging effects of free radicals. It may also shore up the skin&rsquo;s defense system, strengthen skin barriers, boost the immune system, aid in iron absorption and help reduce the risk of chronic disease and inflammation.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "hyaluronicacid": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/hyaluronicacid.jpg" alt="Limes" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Hyaluronic Acid</span>
                                </h2>
                                <p>Hyaluronic Acid is a powerful anti-aging and beauty component for hair and skin. It helps lock in moisture, may create fuller volume for hair, moisturize flaky scalp issues and helps plump skin, reduce wrinkles and aid in elasticity.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "vitaminb6": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/vitaminb6.jpg" alt="Melons" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Vitamin B6</span>
                                </h2>
                                <p>B6 aids and supports  healthy hair growth and revitalization by increasing the flow of oxygenated blood to the follicles and scalp.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "zinc": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/zinc.jpg" alt="Spinach" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Zinc</span>
                                </h2>
                                <p>Zinc is essential to the cell health and supporting immunity while also helping hair growth and thickness by strengthening follicles. It also may assist with the protection of skin from hyper pigmentation, clarification of pores and protection from free radicals that cause premature aging.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "copper": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/copper.jpg" alt="Bowls of grains" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Copper</span>
                                </h2>
                                <p>Copper peptides penetrate the epidermis and may help build collagen and elastin, giving skin a more youthful, plump appearance. Copper also promotes improved circulation and reduced inflammation.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "niacin": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/niacin.jpg" alt="Almonds" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Niacin</span>
                                </h2>
                                <p>Niacin helps promote visibly thicker hair and may help increase the moisture of your skin, promote hair growth through better oxygenation and circulation,  reduce inflammation and help regulate oil production.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "aroniaberry": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/aroniaberry.jpg" alt="Aronia Berries" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Aronia Berry</span>
                                </h2>
                                <p>Aronia Berries are antioxidant powerhouses, containing more polyphenols than even aça&iacute; or blueberries. They can help reduce inflammation, minimize wrinkles, increase circulation and minimize acne. The high levels of vitamin A and C may also help protect from harmful UV rays.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "organicmatchatealeaf": %>
                        <div class="content__group ingredient__group">
                            <div class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/organicmatchatealeaf.jpg" alt="Tea plants" width="270" height="390">
                                <img src="/images/Site1/ingredients/organic-badge.png" alt="Organic Premium Product" class="ingredient__badge">
                            </div>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Organic Japanese</span>
                                    <span>Ceremonial</span>
                                    <span>Grade Matcha</span>
                                </h2>
                                <p>We use only the highest quality first-cut Organic Japanese Ceremonial Grade Matcha leaves. The benefits of matcha may include boosting energy, fat burning, helping to protect against inflammation, brain degeneration, heart health, blood sugar levels, and may support detoxification in the body.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "coconutoil": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/coconutoil.jpg" alt="Coconut Oil" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>MCT - Coconut Oil</span>
                                </h2>
                                <p>MCT Coconut Oil is an anti-aging powerhouse full of nutrients and essential fatty acids that may help improve cognitive function and brain health, increase metabolism, promote weight loss, balance cholesterol and aid with better hair and skin health. </p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "organicmatcha": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/organicmatcha.jpg" alt="Matcha Powder" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Organic Matcha</span>
                                </h2>
                            </div>
                        </div>
                    <% break; %>

                    <% case "almond": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/almond.jpg" alt="Almonds" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Almond</span>
                                </h2>
                                <p>We add Almond as part of our spice mix to add depth of flavor as well as reap the benefits of the fiber, healthy fat content, magnesium and Vitamin E as well as their ability to potentially lower hunger levels, reduce blood pressure and assist in lowering blood sugar levels and promote weight loss.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "cardamom": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/cardamom.jpg" alt="Cardamom" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Cardamom</span>
                                </h2>
                                <p>We use Cardamom to add flavor and reap the anti inflammatory benefits.  In addition, Cardamom may protect and aid in immune function,  help with digestive issues, may protect cells from damage and slow down or prevent inflammation in your body.</p>
                            </div>
                        </div>
                    <% break; %>
                    
                    <% case "nutmeg": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/nutmeg.jpg" alt="Nutmeg" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Nutmeg</span>
                                </h2>
                                <p>We use Nutmeg as part of our spice mix and for its high antioxidant and anti-aging properties. Nutmeg has  been found to have potential health benefits relating to soothing digestion, supporting cognitive function,  boosting skin health, reducing insomnia, boosting immunity, improving circulation and aiding in oral health.</p>
                            </div>
                        </div>
                    <% break; %>
                   
                    <% case "pistachio": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/pistachio.jpg" alt="Pistachios" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Pistachio</span>
                                </h2>
                                <p>Pistachio adds a burst of flavor to our Matcha and provides fiber, minerals and vital unsaturated fats that may help to keep blood sugar, blood pressure and cholesterol balanced.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "ashwagandha": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/ashwagandha.jpg" alt="Ashwagandha" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Ashwagandha</span>
                                </h2>
                                <p>Ashwagandha is an adaptogen that may improve cognitive function, help calm the brain, reduce brain fog and enhance mood. It promotes better immunity and increased quality of sleep and may assist with greater resiliency against anxiety and physical and mental stress.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "cacao": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/cacao.jpg" alt="Cacao" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Cacao</span>
                                </h2>
                               
                            </div>
                        </div>
                    <% break; %>

                    <% case "chaga": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/chaga.jpg" alt="Chaga" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Chaga</span>
                                </h2>
                                <p>The powerful antioxidants and compounds in Chaga may help prevent inflammation and potentially slow tumor growth, lower cholesterol, help reduce blood sugar and help fight heart disease. Chaga may regulate the production of cytokines, boosting the immune system and the cell&rsquo;s ability to communicate with one another. </p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "cordyceps": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/cordyceps.jpg" alt="Cordyceps" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Cordyceps</span>
                                </h2>
                                <p>Cordyceps has powerful antioxidants that help fight cell damage and neutralize free radicals, important to anti-aging. It may reduce fatigue, boost strength, libido, improve the way your body uses oxygen, and increase the production of ATP, essential for delivering energy to muscles for increased sports performance. </p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "ginger": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/ginger.jpg" alt="Ginger" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Ginger</span>
                                </h2>
                                <p>Ginger is loaded with antioxidants, anti-inflammatories and over 400 compounds that may help prevent stress and damage to DNA, increase serotonin and dopamine, aid in digestion, nausea relief, assist with boating and intestinal gas and reduce inflammation.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "lionsmane": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/lionsmane.jpg" alt="Lion's Mane" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Lion's Mane</span>
                                </h2>
                                <p>Called the &ldquo;smart mushroom,&rdquo; Lion&rsquo;s Mane can potentially improve memory, focus, clarity and help protect against both physical and mental stress. Research suggests the plant compounds in Lion&rsquo;s Mane mushrooms may help stimulate the growth of new brain cells, improve cognition, may relieve depression and anxiety, support gut health, heart health, and immunity.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "turkeytail": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/turkeytail.jpg" alt="Turkey Tail" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Turkey Tail</span>
                                </h2>
                                <p>Turkey Tail contains compounds that may help boost the immune system and improve gut health. It has high levels of antioxidants that promote cellular health and may help slow down the aging process as well as potentially reduce the risk of certain cancers.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "turmeric": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/turmeric.jpg" alt="Turmeric" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Turmeric</span>
                                </h2>
                                <p>Turmeric contains high levels of the active ingredient Curcumin and may have strong anti-inflammatory and antioxidant effects for gut health, brain health and heart health. We add Piperine to our blend to assist with the absorption and bioavailability of Curcumin which may enhance its ability to support metabolism, heart health, cognition and various degenerative diseases.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "l-theanine": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/ltheanine.jpg" alt="L-theanine" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>L-theanine</span>
                                </h2>
                                <p>L-theanine has a range of potential benefits for mind, body, overall health, and well-being.  It may help with stress reduction, have a calming effect on the mind and reduce feelings of anxiety, reduce inflammation, and promote relaxation, assisting with better sleep quality.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "melatonin": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/melatonin.jpg" alt="Melatonin" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Melatonin</span>
                                </h2>
                                <p>Melatonin may help regulate sleep patterns, reset circadian rhythms, assist with insomnia and overall longer and better quality of sleep. It may also help reduce anxiety and stress, have a positive effect on mood and symptoms of depression. The antioxidant properties may protect against free radicals, reduce inflammation, and enhance immune function.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "matcha": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/matcha.jpg" alt="Matcha" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Matcha</span>
                                </h2>
                                <p>Matcha contains beneficial L-Theanine, chlorophyl, essential amino acids and EGCG, a type of catechin that promotes fat oxidation and thermogenesis.  Matcha may increase cognitive function, focus, promote relaxation and increase alpha waves in the brain, reducing mental stress.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "passionflower": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/passionflower.jpg" alt="Passionflower" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Passionflower</span>
                                </h2>
                                <p>Passionflower has been used in traditional medicine to treat and reduce anxiety and insomnia. It is considered a natural mild sedative that may help promote a calmer state of mind and greater quality of sleep.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "holybasil": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/holybasil.jpg" alt="Holy Basil" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Holy Basil</span>
                                </h2>
                                <p>Holy Basil is an herb that has been revered in parts of the world as a sacred plant with antioxidant and anti-inflammatory properties. It may promote relaxation and is considered an adaptogen that may help the body cope with stress and anxiety.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "magnesium": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/magnesium.jpg" alt="Magnesium" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Magnesium</span>
                                </h2>
                                <p>Magnesium is an essential mineral that plays a role in over 300 biochemical reactions within the body and may improve sleep quality and duration by promoting relaxation, helping reduce stress and anxiety, and supporting the parasympathetic nervous system which is responsible for rest and relaxation. Magnesium may also help regulate melatonin supporting healthier sleep/wake cycles.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "ginkgobiloba": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/ginkgobiloba.jpg" alt="Ginkgo Biloba" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Ginkgo Biloba</span>
                                </h2>
                                <p>Ginkgo Biloba has antioxidant and anti-aging properties that may also enhance memory, improve learning and thinking, increase dopamine levels, adapt to stress, help ease depression and anxiety, improve vision and blood circulation to the brain.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "rhodiolarosea": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/rhodiolarosea.jpg" alt="Rhodiola Rosea" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Rhodiola Rosea</span>
                                </h2>
                                <p>Rhodiola Rosea is an adaptogen used to support the reduction of stress, fight fatigue, and may increase mood, mental performance, memory, plus physical and mental fitness, and resilience.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "chicoryroot": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/chicoryroot.jpg" alt="Chicory Root" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Chicory Root</span>
                                </h2>
                                <p>Chicory Root is rich in essential minerals and antioxidant properties that may protect against cognitive decline. It has fiber and prebiotics that may also boost digestive health, help regulate blood sugar, fight inflammation and aid in weight loss.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "alphagpc": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/alphagpc.jpg" alt="Alpha GPC" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Alpha GPC</span>
                                </h2>
                                <p>Used by athletes to muscle and athletic performance, Alpha GPC also may increase mental performance, memory, and cognitive function, increase blood flow to the brain, improve thinking skills and learning abilities.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "brahmibacopa": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/brahmibacopa.jpg" alt="Brahmi Bacopa" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Brahmi Bacopa</span>
                                </h2>
                                <p>Bacopa is a plant that has been used for centuries in Ayurvedic medicine that may increase certain brain chemicals involved in thinking, learning, memory and elevating attention cognition and impulse controls well as reduce anxiety. It is rich with antioxidant and anti-inflammatory properties.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "greencoffeebeanextract": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/greencoffeebeanextract.jpg" alt="Green Coffee Bean Extract" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Green Coffee Bean Extract</span>
                                </h2>
                                <p>Green coffee bean extract may assist with boosting metabolism, easing stress, increasing energy and weight loss. It may also promote blood sugar regulation and improve health markers, such as blood pressure and cholesterol.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "vitamind": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/vitamind.jpg" alt="Vitamin D" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Vitamin D</span>
                                </h2>
                                <p>Called the &ldquo;sunshine vitamin&rdquo; Vitamin D is essential for the immune system, and critical to the ability to absorb calcium and phosphorus for bone strength. Its anti-inflammatory, antioxidant and neuro-protective properties support immune health plus muscle function and brain cell activity. In appropriate doses, may also support kidney function, healthy blood vessels, may help accelerate wound healing and potentially help fight depression.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "vitaminb12": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/vitaminb12.jpg" alt="Vitamin B12" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Vitamin B12</span>
                                </h2>
                                <p>B12 helps make DNA in your body, helps keep blood and nerve cells healthy and is helps prevent anemia which affects energy levels and mood. It may support bone health and help prevent osteoporosis and may reduce risk of macular degeneration as well as decrease homocysteine levels.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "echinacea": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/echinacea.jpg" alt="Echinacea" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Echinacea</span>
                                </h2>
                                <p>Echinacea is an herb with anti-inflammatory and immune boosting properties and may help prevent and fight off infections such as the common cold and flu. It contains antibacterial and antiviral properties that may protect the body from harmful pathogens and promote overall well-being.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "elderberry": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/elderberry.jpg" alt="Elderberry" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Elderberry</span>
                                </h2>
                                <p>Elderberry extract is rich in antioxidants and may be important to reducing oxidative stress and inflammation on the body. It&rsquo;s immune boosting properties may help fight off viral and bacterial infections and support shortening the symptoms and duration of the flu.</p>
                            </div>
                        </div>
                    <% break; %>

                    <% case "applecidervinegar": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/applecidervinegar.jpg" alt="Apple Cider Vinegar" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Apple Cider Vinegar</span>
                                </h2>
                            </div>
                        </div>
                    <% break; %>

                    <% case "boswellaserrata": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/boswellaserrata.jpg" alt="Boswella Serrata" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Boswella Serrata</span>
                                </h2>
                            </div>
                        </div>
                    <% break; %>

                    <% case "hydrolizedbovinecollagen": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/hydrolizedbovinecollagen.jpg" alt="Hydrolized Bovine Collagen I & III" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Hydrolized Bovine Collagen I & III</span>
                                </h2>
                            </div>
                        </div>
                    <% break; %>

                    <% case "turmericroot": %>
                        <div class="content__group ingredient__group">
                            <picture class="content__image ingredient__image">
                                <img src="/images/Site1/ingredients/turmericroot.jpg" alt="Turmeric Root" width="270" height="390">
                            </picture>
                            <div class="content__copy ingredient__copy">
                                <h2 class="ingredient__title" id="<%= titleId %>">
                                    <span>Turmeric Root</span>
                                </h2>
                            </div>
                        </div>
                    <% break; %>
                <% } %>
            </div>
        </section>
        <%
    }
%>