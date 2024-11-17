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
    @JoinColumn(name = "activity_id", referencedColumnName = "id")
    private Activity activity;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "executive_id", referencedColumnName = "id")
    private User salesExecutive;

    private String status;

    private LocalDate createdAt;

    private LocalDate updatedAt;


}
