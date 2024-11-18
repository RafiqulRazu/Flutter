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

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class ActivityService {

    @Autowired
    private ActivityRepository activityRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private LeadRepository leadRepository;


    @Transactional
    public Activity createActivity(Activity activity) {
        if (activity.getAgent() != null) {
            User existingAgent = userRepository.findById(activity.getAgent().getId())
                    .orElseThrow(() -> new RuntimeException("User not found"));
            activity.setAgent(existingAgent);
        }
        if (activity.getCustomer() != null) {
            Customer existingCustomer = customerRepository.findById(activity.getCustomer().getId())
                    .orElseThrow(() -> new RuntimeException("Customer not found"));
            activity.setCustomer(existingCustomer);
        }
        return activityRepository.save(activity);
    }

    public Activity forwardToLeads(Activity activity) {
        Lead lead = new Lead();
        lead.setActivity(activity);
        lead.setCreatedAt(new Date());
        leadRepository.save(lead);
        return activity;
    }


    public List<Activity> getAllActivities() {
        return activityRepository.findAll();
    }


    public Optional<Activity> getActivityById(long id) {
        return activityRepository.findById(id);
    }


    public Activity updateActivity(long id, Activity updatedActivity) {
        Activity existingActivity = activityRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Activity not found with id: " + id));
        existingActivity.setActivityType(updatedActivity.getActivityType());
        existingActivity.setDescription(updatedActivity.getDescription());
        existingActivity.setActivityDate(updatedActivity.getActivityDate());
        existingActivity.setCustomer(updatedActivity.getCustomer());
        existingActivity.setAgent(updatedActivity.getAgent());
        return activityRepository.save(existingActivity);
    }


    public void deleteActivity(long id) {
        activityRepository.deleteById(id);
    }
}
