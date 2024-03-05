namespace FMLSHOP.Models
{
    public class Review
    {
        /// <summary>
        /// Represents the body of the review
        /// </summary>
        public string Blockquote { get; set; }
        /// <summary>
        /// Represents the author name for the review
        /// </summary>
        public string Name { get; set; }
        /// <summary>
        /// Represents the author's location
        /// </summary>
        public string Location { get; set; }
        /// <summary>
        /// Represents the product name that the review is based off of
        /// </summary>
        public string Product { get; set; }

        public Review()
        {
            Blockquote = string.Empty;
            Name = string.Empty;
            Location = string.Empty;
            Product = string.Empty;
        }
    }
}