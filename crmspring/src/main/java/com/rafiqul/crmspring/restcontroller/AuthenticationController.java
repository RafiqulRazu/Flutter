package com.rafiqul.crmspring.restcontroller;

import com.rafiqul.crmspring.entity.AuthenticationResponse;
import com.rafiqul.crmspring.entity.User;
import com.rafiqul.crmspring.service.AuthService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
public class AuthenticationController {

    private final AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<AuthenticationResponse> register(
            @RequestBody User request
    ) {
        return ResponseEntity.ok(authService.register(request));
    }

    @PostMapping("/register/admin")
    public ResponseEntity<AuthenticationResponse> registerAdmin(
            @RequestBody User request
    ) {
        return ResponseEntity.ok(authService.registerAdmin(request));
    }

//    @PostMapping("/register/sales")
//    public ResponseEntity<AuthenticationResponse> registerSales(
//            @RequestBody User request
//    ) {
//        return ResponseEntity.ok(authService.registerSales(request));
//    }


    @PostMapping("/login")
    public ResponseEntity<AuthenticationResponse> login(
            @RequestBody User request
    ) {
        return ResponseEntity.ok(authService.authenticate(request));
    }



    @GetMapping("/activate/{id}")
    public ResponseEntity<String> activateUser(@PathVariable("id") long id) {
        String response = authService.activateUser(id);
        return ResponseEntity.ok(response);
    }
}
