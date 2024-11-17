package com.rafiqul.crmspring.service;


import com.rafiqul.crmspring.entity.Activity;
import com.rafiqul.crmspring.entity.Customer;
import com.rafiqul.crmspring.entity.Lead;
import com.rafiqul.crmspring.entity.User;
import com.rafiqul.crmspring.repository.ActivityRepository;
import com.rafiqul.crmspring.repository.CustomerRepository;
import com.rafiqul.crmspring.repository.LeadRepository;
import com.rafiqul.crmspring.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class LeadService {

    @Autowired
    private LeadRepository leadRepository;

    @Autowired
    private CustomerRepository customerRepository;


    @Transactional
    public Lead createLead(Lead lead) {
        // Set default values for new lead
        lead.setCreatedAt(LocalDate.now());
        lead.setUpdatedAt(LocalDate.now());

        // Validate and associate Customer if provided
        if (lead.getCustomer() != null) {
            Customer existingCustomer = customerRepository.findById(lead.getCustomer().getId())
                    .orElseThrow(() -> new RuntimeException("Customer not found"));
            lead.setCustomer(existingCustomer);
        }

        // Save the lead
        return leadRepository.save(lead);
    }

    public Optional<Lead> getLeadById(Long id) {
        return leadRepository.findById(id);
    }

    public List<Lead> getAllLeads() {
        return leadRepository.findAll();
    }


    @Transactional
    public Lead updateLead(Long id, Lead leadDetails) {
        Lead existingLead = leadRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Lead not found with id: " + id));

        // Update customer association if provided
        if (leadDetails.getCustomer() != null) {
            Customer existingCustomer = customerRepository.findById(leadDetails.getCustomer().getId())
                    .orElseThrow(() -> new RuntimeException("Customer not found"));
            existingLead.setCustomer(existingCustomer);
        }

        // Update audit information
        existingLead.setUpdatedAt(LocalDate.now());

        // Save the updated lead
        return leadRepository.save(existingLead);
    }

    // Delete a lead
    @Transactional
    public void deleteLead(Long id) {
        Lead existingLead = leadRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Lead not found with id: " + id));

        leadRepository.delete(existingLead);
    }

}
