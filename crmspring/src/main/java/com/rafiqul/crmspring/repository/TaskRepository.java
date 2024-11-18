package com.rafiqul.crmspring.repository;

import com.rafiqul.crmspring.entity.Task;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TaskRepository extends JpaRepository<Task, Integer> {


    Optional<Task> findBySalesExecutive_Id(long salesExecutiveId);

}
