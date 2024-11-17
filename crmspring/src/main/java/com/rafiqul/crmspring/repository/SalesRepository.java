package com.rafiqul.crmspring.repository;

import com.rafiqul.crmspring.entity.Sales;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SalesRepository extends JpaRepository<Sales,Integer> {
}
