package com.rafiqul.crmspring.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Entity
@Data
@Table(name = "sales")
@AllArgsConstructor
@NoArgsConstructor
public class Sales {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "customerId")
    private Customer customer;

    @JsonIgnore
    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "productId")
    private Product product;

    private Date orderDate;

    private double quantity;

    private double totalAmount;  // Total amount for the order

    private String status;
}
