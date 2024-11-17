package com.rafiqul.crmspring.service;


import com.rafiqul.crmspring.entity.Activity;
import com.rafiqul.crmspring.entity.Lead;
import com.rafiqul.crmspring.entity.User;
import com.rafiqul.crmspring.repository.ActivityRepository;
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
    private UserRepository userRepository;

    @Autowired
    private ActivityRepository activityRepository;


    @Transactional
    public Lead createLead(Lead lead) {
        // Set default values for new lead
        lead.setCreatedAt(LocalDate.now());
        lead.setUpdatedAt(LocalDate.now());
        lead.setStatus("New"); // Default status for new leads

        // Validate and set sales executive if provided
        if (lead.getSalesExecutive() != null) {
            User existingSalesExecutive = userRepository.findById(lead.getSalesExecutive().getId())
                    .orElseThrow(() -> new RuntimeException("Sales Executive not found"));
            lead.setSalesExecutive(existingSalesExecutive);
        }

        // Validate and set activity if provided
        if (lead.getActivity() != null) {
            Activity existingActivity = activityRepository.findById(lead.getActivity().getId())
                    .orElseThrow(() -> new RuntimeException("Activity not found"));
            lead.setActivity(existingActivity);
        }

        return leadRepository.save(lead);
    }


    // Retrieve a lead by ID
    public Optional<Lead> getLeadById(Long id) {
        return leadRepository.findById(id);
    }

    // Retrieve all leads
    public List<Lead> getAllLeads() {
        return leadRepository.findAll();
    }


    @Transactional
    public Lead updateLead(Long id, Lead leadDetails) {
        Lead existingLead = leadRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Lead not found with id: " + id));

        // Update fields
        if (leadDetails.getSalesExecutive() != null) {
            User existingSalesExecutive = userRepository.findById(leadDetails.getSalesExecutive().getId())
                    .orElseThrow(() -> new RuntimeException("Sales Executive not found"));
            existingLead.setSalesExecutive(existingSalesExecutive);
        }

        if (leadDetails.getActivity() != null) {
            Activity existingActivity = activityRepository.findById(leadDetails.getActivity().getId())
                    .orElseThrow(() -> new RuntimeException("Activity not found"));
            existingLead.setActivity(existingActivity);
        }

        existingLead.setStatus(leadDetails.getStatus());
        existingLead.setUpdatedAt(LocalDate.now());

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
