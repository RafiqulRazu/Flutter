package com.rafiqul.crmspring.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "leads")
@AllArgsConstructor
@NoArgsConstructor
public class Lead {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id")
    private Customer customer;

    private String status;

    private LocalDate createdAt;

    private LocalDate updatedAt;

}
