package com.rafiqul.crmspring.service;

import com.rafiqul.crmspring.entity.Product;
import com.rafiqul.crmspring.repository.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ProductService {

    @Autowired
    private ProductRepository productRepository;


    public Product createProduct(Product product) {
        return productRepository.save(product);
    }


    public Product getProductById(Long productId) {
        return productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Product not found"));
    }

    public List<Product> getAllProducts() {
        return productRepository.findAll();
    }


    public Product updateProduct(Long productId, Product updatedProduct) {
        Product existingProduct = getProductById(productId);
        existingProduct.setName(updatedProduct.getName());
        existingProduct.setUnitPrice(updatedProduct.getUnitPrice());
        existingProduct.setStock(updatedProduct.getStock());
        existingProduct.setVat(updatedProduct.getVat());
        existingProduct.setStatus(updatedProduct.getStatus());
        return productRepository.save(existingProduct);
    }

    public void deleteProduct(Long productId) {
        productRepository.deleteById(productId);
    }

    // Update product stock (deduct stock when an order is created)
    public void updateStock(Product product, double quantity) {
        double newStock = product.getStock() - quantity;
        if (newStock < 0) {
            throw new RuntimeException("Insufficient stock for product: " + product.getName());
        }
        product.setStock(newStock);
        productRepository.save(product);
    }

}
