using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace TaseCase.Ef7.Models
{
    public class DataSeeder
    {
        private readonly ApplicationDbContext _context  = new ApplicationDbContext();
        public void InsureSeed()
        {
            if (!_context.Categories.Any())
            {
                var pc = new ProductCategory();
                pc.Product = new Product {Name = "p1", Price = 121};
                pc.Category = new Category {Name = "c1"};



                var category = new Category {Name = "category1"};
                _context.Categories.Add(category);

                var product = new Product{Name = "product1",Price = 123};
                _context.Products.Add(product);

                var productCategory = (new ProductCategory { Category = category , Product  = product });
                _context.ProductCategories.Add(productCategory);

             // _context.SaveChanges();

                //--
                var product1 = new Product();
                product.Name = "product2";
                product.Price = 111;
                _context.Products.Add(product1);
                _context.SaveChanges();
                var c1 = _context.Categories.Single(c => c.Id == category.Id);

                var productCategory1 = (new ProductCategory { Category = c1, Product = product1 });
                _context.ProductCategories.Add(productCategory1);
                _context.SaveChanges();
             
            }
        }
    }
}
