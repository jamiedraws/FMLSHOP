using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FMLSHOP.StructuredData
{
    /// <summary>
    /// A review of an item - for example, of a restaurant, movie, or store.
    /// https://schema.org/Review
    /// </summary>
    public class Review
    {
        /// <summary>
        /// The name of the item.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// The actual body of the review.
        /// </summary>
        public string ReviewBody { get; set; }

        /// <summary>
        /// The rating given in this review. Note that reviews can themselves be rated. The reviewRating applies to rating given by the review. The aggregateRating property applies to the review itself, as a creative work.
        /// </summary>
        public Rating ReviewRating { get; set; }

        /// <summary>
        /// The author of this content or rating. Please note that author is special in that HTML 5 provides a special mechanism for indicating authorship via the rel tag. That is equivalent to this and may be used interchangeably.
        /// </summary>
        public Person Author { get; set; }

        public Review()
        {
            Name = string.Empty;
            ReviewBody = string.Empty;
            ReviewRating = new Rating();
            Author = new Person();
        }
    }

    /// <summary>
    /// A person (alive, dead, undead, or fictional).
    /// https://schema.org/Person
    /// </summary>
    public class Person
    {
        /// <summary>
        /// The name of the item.
        /// </summary>
        public string Name { get; set; }

        /// <summary>
        /// Physical address of the item.
        /// </summary>
        public string Address { get; set; } 

        public Person()
        {
            Name = string.Empty;
            Address = string.Empty;
        }
    }

    /// <summary>
    /// A rating is an evaluation on a numeric scale, such as 1 to 5 stars.
    /// https://schema.org/Rating
    /// </summary>
    public class Rating
    {
        /// <summary>
        /// The rating for the content.
        /// Usage guidelines:
        /// Use values from 0123456789 (Unicode 'DIGIT ZERO' (U+0030) to 'DIGIT NINE' (U+0039)) rather than superficially similar Unicode symbols.
        /// Use '.' (Unicode 'FULL STOP' (U+002E)) rather than ',' to indicate a decimal point.Avoid using these symbols as a readability separator.
        /// </summary>
        public string RatingValue { get; set; }

        public Rating()
        {
            RatingValue = string.Empty;
        }
    }
}