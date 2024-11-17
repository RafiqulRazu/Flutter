package com.rafiqul.crmspring.service;

import com.rafiqul.crmspring.entity.Lead;
import com.rafiqul.crmspring.entity.Order;
import com.rafiqul.crmspring.entity.Product;
import com.rafiqul.crmspring.repository.LeadRepository;
import com.rafiqul.crmspring.repository.OrderRepository;
import com.rafiqul.crmspring.repository.ProductRepository;
import com.rafiqul.crmspring.service.ProductService;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private LeadRepository leadRepository;

    @Autowired
    private ProductService productService;


    @Transactional
    public Order createOrder(Order order) {

        Product product = productRepository.findById(order.getProduct().getId())
                .orElseThrow(() -> new RuntimeException("Order with this id not found."));
        order.setProduct(product);

//        Lead lead = LeadRepository.findById(order.getLead().getId())
//                .orElseThrow(() -> new RuntimeException("Lead with this id not found."));
//        order.setLead(lead);

        double totalAmount = calculateTotalAmount(product, order.getQuantity());
        order.setTotalAmount(totalAmount);

        productService.updateStock(product, order.getQuantity());

        return orderRepository.save(order);
    }



    public Order getOrderById(Long orderId) {
        return orderRepository.findById(orderId)
                .orElseThrow(() -> new RuntimeException("Order not found"));
    }



    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }


    public Order updateOrder(Long orderId, Order updatedOrder) {
        Order existingOrder = getOrderById(orderId);
        Product product = productService.getProductById(updatedOrder.getProduct().getId());

        existingOrder.setLead(updatedOrder.getLead());
        existingOrder.setProduct(product);
        existingOrder.setQuantity(updatedOrder.getQuantity());
        existingOrder.setOrderDate(updatedOrder.getOrderDate());
        existingOrder.setStatus(updatedOrder.getStatus());

        // Recalculate total amount and update stock
        double totalAmount = calculateTotalAmount(product, updatedOrder.getQuantity());
        existingOrder.setTotalAmount(totalAmount);

        // Update product stock (handle changes in quantity)
        double stockDifference = updatedOrder.getQuantity() - existingOrder.getQuantity();
        productService.updateStock(product, stockDifference);

        return orderRepository.save(existingOrder);
    }


    public void deleteOrder(Long orderId) {
        Order order = getOrderById(orderId);
        productService.updateStock(order.getProduct(), -order.getQuantity());

        orderRepository.deleteById(orderId);
    }


    private double calculateTotalAmount(Product product, double quantity) {
        double unitPrice = product.getUnitPrice();
        double vatAmount = unitPrice * (product.getVat() / 100);
        return (unitPrice + vatAmount) * quantity;
    }
}
