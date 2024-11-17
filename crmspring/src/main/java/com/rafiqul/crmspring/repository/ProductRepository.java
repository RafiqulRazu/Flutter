package com.rafiqul.crmspring.repository;

import com.rafiqul.crmspring.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
//    List<Product> findByOrderId(Long orderId);

}
