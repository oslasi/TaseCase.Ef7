using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TaseCase.Ef7.Models
{
    public class Category
    {
        public Category()
        {
            Id= new Guid();
            ProductCategories = new List<ProductCategory>();
        }

        public Guid Id { get; set; }
        public string Name { get; set; }
        public IList<ProductCategory> ProductCategories { get; set; }
    }
}
