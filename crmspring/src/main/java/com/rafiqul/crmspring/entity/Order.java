package com.rafiqul.crmspring.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

@Entity
@Data@Table(name = "orders")
@AllArgsConstructor
@NoArgsConstructor
public class Order {

    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private  long id;


    @ManyToOne
    @JoinColumn(name = "lead_id", nullable = false)
    private Lead lead;

    @JsonIgnore
    @ManyToOne
    @JoinColumn(name = "product_id", nullable = false)
    private Product product;

    private Date orderDate;

    private double quantity;

    private double totalAmount;  // Total amount for the order

    private String status;


}
