package com.rafiqul.crmspring.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.List;

@Entity
@Data
@Table(name = "user")
@AllArgsConstructor
@NoArgsConstructor
public class User implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(nullable = false)
    private String name;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String password;

    private String phone;

    private String address;

    @Enumerated(EnumType.STRING)
    private Role role;

    @Column(nullable = false)
    private boolean active;

    @Column()
    private boolean isLock;

//    @OneToMany(mappedBy = "user")
//    private List<Token> tokens;

    @JsonIgnore
    @OneToMany(mappedBy = "agent", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Activity> activities;

    @JsonIgnore
    @OneToMany(mappedBy = "soldBy", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Order> orders;

    @JsonIgnore
    @OneToMany(mappedBy = "salesExecutive", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private List<Lead> leads;

    @JsonIgnore
    @OneToOne(mappedBy = "salesExecutive", cascade = CascadeType.REMOVE, orphanRemoval = true)
    private Task task;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return List.of(new SimpleGrantedAuthority(role.name()));
    }

    @Override
    public String getUsername() {
        return email;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return isLock;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return active;
    }



//    public enum Role {
//        ADMIN,
//        SALES,
//        AGENT
//    }

//    private String status;
}
