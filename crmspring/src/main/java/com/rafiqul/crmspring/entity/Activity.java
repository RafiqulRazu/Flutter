package com.rafiqul.crmspring.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Date;
import java.time.LocalDate;

@Entity
@Data
@Table(name = "activity")
@AllArgsConstructor
@NoArgsConstructor
public class Activity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String activityType; // 'Call', 'Email', 'Meeting'

    private String description;

    private Date activityDate;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "customer_id")
    private Customer customer;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "agent_id")
    private User agent;

    public Activity(long id) {
        this.id = id;
    }
}
