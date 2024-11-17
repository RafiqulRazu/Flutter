package com.rafiqul.crmspring.restcontroller;

import com.rafiqul.crmspring.entity.User;
import com.rafiqul.crmspring.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/user")
@CrossOrigin("*")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/save")
    public ResponseEntity<User> createUser(@RequestBody User user) {
        User createdUser = userService.createUser(user);
        return new ResponseEntity<>(createdUser, HttpStatus.CREATED); // Return 201 Created status
    }

    @GetMapping("/")
    public ResponseEntity<List<User>> getAllUsers() {
        List<User> user = userService.getAllUsers();
        return new ResponseEntity<>(user, HttpStatus.OK);
    }

    @GetMapping("/{id}")
    public ResponseEntity<User> getUserById(@PathVariable Long id) {
        Optional<User> user = userService.getUserById(id);
        return user.map(ResponseEntity::ok)
                .orElseGet(() -> new ResponseEntity<>(HttpStatus.NOT_FOUND)); // Return 404 if user not found
    }

    @PutMapping("update/{id}")
    public ResponseEntity<User> updateUser(@PathVariable Long id, @RequestBody User userDetails) {
        try {
            User updatedUser = userService.updateUser(id, userDetails);
            return new ResponseEntity<>(updatedUser, HttpStatus.OK); // Return 200 OK with the updated user
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND); // Return 404 if user not found
        }
    }

    // DELETE: Delete a user by ID
    @DeleteMapping("delete/{id}")
    public ResponseEntity<Void> deleteUser(@PathVariable Long id) {
        try {
            userService.deleteUser(id);
            return new ResponseEntity<>(HttpStatus.NO_CONTENT); // Return 204 No Content after deletion
        } catch (IllegalArgumentException e) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND); // Return 404 if user not found
        }
    }

}
