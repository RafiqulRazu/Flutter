//package com.rafiqul.crmspring.entity;
//
//import com.fasterxml.jackson.annotation.JsonIgnore;
//import jakarta.persistence.*;
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//
//@Entity
//@Data
//@Table(name = "orderitem")
//@AllArgsConstructor
//@NoArgsConstructor
//public class OrderItem {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    @ManyToOne
//    @JoinColumn(name = "order_id", nullable = false)
//    private Order order;  // The order this item belongs to
//
//    @JsonIgnore
//    @ManyToOne
//    @JoinColumn(name = "product_id", nullable = false)
//    private Product product;  // The product being sold
//
//    private int quantity;  // Quantity of the product ordered
//
//    private double unitPrice;  // Price per unit of the product
//
//    private double vat;
//
//    private double totalPrice;
//}
