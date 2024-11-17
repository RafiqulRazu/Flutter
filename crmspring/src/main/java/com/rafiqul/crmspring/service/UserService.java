package com.rafiqul.crmspring.service;

import com.rafiqul.crmspring.entity.Role;
import com.rafiqul.crmspring.entity.User;
import com.rafiqul.crmspring.repository.UserRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class UserService implements UserDetailsService {


    @Autowired
    private UserRepository userRepository;

    @Transactional
    public User createUser(User user) {
        return userRepository.save(user);
    }

    public Optional<User> getUserById(Long id) {
        return userRepository.findById(id);
    }

    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    @Transactional
    public User updateUser(Long id, User userDetails) {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + id));

        existingUser.setName(userDetails.getName());
        existingUser.setEmail(userDetails.getEmail());
        existingUser.setPassword(userDetails.getPassword());
        existingUser.setPhone(userDetails.getPhone());
        existingUser.setAddress(userDetails.getAddress());
        existingUser.setRole(userDetails.getRole());

        return userRepository.save(existingUser);
    }

    @Transactional
    public void deleteUser(Long id) {
        User existingUser = userRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("User not found with id: " + id));

        userRepository.delete(existingUser);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return userRepository.findByEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with Email address: " + username));
    }

}
