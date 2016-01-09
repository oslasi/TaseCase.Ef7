using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TaseCase.Ef7.Models
{
    public class ProductCategory
    {
        public Guid ProductId { get; set; }
        public Guid CategoryId { get; set; }
        public Category Category { get; set; }
        public Product Product { get; set; }
    }
}
