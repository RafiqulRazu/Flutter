package com.rafiqul.crmspring.entity;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Token {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String token;

    @Column(name = "is_logged_0ut")
    private boolean loggedOut;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
}
