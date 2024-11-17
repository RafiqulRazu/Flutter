package com.rafiqul.crmspring.restcontroller;

import com.rafiqul.crmspring.entity.Lead;

import com.rafiqul.crmspring.service.LeadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@CrossOrigin("*")
@RestController
@RequestMapping("/api/lead")
public class LeadController {

    @Autowired
    private LeadService leadService;

    // Create a new Lead
    @PostMapping("/save")
    public ResponseEntity<Lead> createLead(@RequestBody Lead lead) {
        Lead createdLead = leadService.createLead(lead);
        return new ResponseEntity<>(createdLead, HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Lead> getLeadById(@PathVariable Long id) {
        Optional<Lead> lead = leadService.getLeadById(id);
        if (lead.isPresent()) {
            return new ResponseEntity<>(lead.get(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @GetMapping("/")
    public ResponseEntity<List<Lead>> getAllLeads() {
        List<Lead> leads = leadService.getAllLeads();
        return new ResponseEntity<>(leads, HttpStatus.OK);
    }


    @PutMapping("/update/{id}")
    public ResponseEntity<Lead> updateLead(@PathVariable Long id, @RequestBody Lead leadDetails) {
        try {
            Lead updatedLead = leadService.updateLead(id, leadDetails);
            return new ResponseEntity<>(updatedLead, HttpStatus.OK);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteLead(@PathVariable Long id) {
        try {
            leadService.deleteLead(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT);
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
