package com.rafiqul.crmspring.restcontroller;

import com.rafiqul.crmspring.entity.Activity;
import com.rafiqul.crmspring.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/act")
@CrossOrigin("*")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @PostMapping("/save")
    public ResponseEntity<Activity> createActivity(@RequestBody Activity activity) {
        Activity newActivity = activityService.createActivity(activity);
        return ResponseEntity.ok(newActivity);
    }

    @GetMapping("/")
    public ResponseEntity<List<Activity>> getAllActivities() {
        List<Activity> activities = activityService.getAllActivities();
        return ResponseEntity.ok(activities);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Activity> getActivityById(@PathVariable int id) {
        Optional<Activity> activity = activityService.getActivityById(id);
        return activity.map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.notFound().build());
    }

    @PutMapping("/update/{id}")
    public ResponseEntity<Activity> updateActivity(@PathVariable int id, @RequestBody Activity updatedActivity) {
        Activity updated = activityService.updateActivity(id, updatedActivity);
        return ResponseEntity.ok(updated);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<Void> deleteActivity(@PathVariable int id) {
        activityService.deleteActivity(id);
        return ResponseEntity.noContent().build();
    }
}
