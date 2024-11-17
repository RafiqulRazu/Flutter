package com.rafiqul.crmspring.restcontroller;

import com.rafiqul.crmspring.entity.Product;
import com.rafiqul.crmspring.service.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/product")
@CrossOrigin("*")
public class ProductController {

    @Autowired
    private ProductService productService;


    @PostMapping("/save")
    public ResponseEntity<Product> createProduct(@RequestBody Product product) {
        Product createdProduct = productService.createProduct(product);
        return ResponseEntity.ok(createdProduct);
    }


    @GetMapping("/{id}")
    public ResponseEntity<Product> getProductById(@PathVariable Long id) {
        Product product = productService.getProductById(id);
        return ResponseEntity.ok(product);
    }


    @GetMapping("/")
    public ResponseEntity<List<Product>> getAllProducts() {
        List<Product> products = productService.getAllProducts();
        return ResponseEntity.ok(products);
    }


    @PutMapping("/update/{id}")
    public ResponseEntity<Product> updateProduct(
            @PathVariable Long id,
            @RequestBody Product updatedProduct) {
        Product product = productService.updateProduct(id, updatedProduct);
        return ResponseEntity.ok(product);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteProduct(@PathVariable Long id) {
        productService.deleteProduct(id);
        return ResponseEntity.noContent().build();
    }


    @PutMapping("/stock/{id}")
    public ResponseEntity<Void> updateStock(
            @PathVariable Long id,
            @RequestParam double quantity) {
        Product product = productService.getProductById(id);
        productService.updateStock(product, quantity);
        return ResponseEntity.ok().build();
    }
}
