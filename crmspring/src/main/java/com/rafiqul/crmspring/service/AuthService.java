package com.rafiqul.crmspring.service;

import com.rafiqul.crmspring.entity.AuthenticationResponse;
import com.rafiqul.crmspring.entity.Role;
import com.rafiqul.crmspring.entity.Token;
import com.rafiqul.crmspring.entity.User;
import com.rafiqul.crmspring.jwt.JwtService;
import com.rafiqul.crmspring.repository.TokenRepository;
import com.rafiqul.crmspring.repository.UserRepository;
import jakarta.mail.MessagingException;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final TokenRepository tokenRepository;
    private final AuthenticationManager authenticationManager;
    private final EmailService emailService;


    private void saveUserToken(String jwt, User user) {
        Token token = new Token();
        token.setToken(jwt);
        token.setLoggedOut(false);
        token.setUser(user);

        tokenRepository.save(token);
    }

    private void removeAllTokenByUser(User user) {
        List<Token> validTokens = tokenRepository.findAllTokensByUser(user.getId());
        if(validTokens.isEmpty()) {
            return;
        }

        validTokens.forEach(token -> {
            token.setLoggedOut(true);
        });

        tokenRepository.saveAll(validTokens);
    }


    public AuthenticationResponse register(User user) {

        if (userRepository.findByEmail(user.getUsername()).isPresent()) {
            return new AuthenticationResponse(null, "User already exists", null);
        }


        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.valueOf("AGENT"));
        user.setLock(true);
        user.setActive(true);

        userRepository.save(user);


        String jwt = jwtService.generateToken(user);


        saveUserToken(jwt, user);
        sendActivationEmail(user);

        return new AuthenticationResponse(jwt, "User registration was successful", null);
    }


    public AuthenticationResponse registerAdmin(User user) {

        if (userRepository.findByEmail(user.getUsername()).isPresent()) {
            return new AuthenticationResponse(null, "User already exists", null);
        }


        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setRole(Role.valueOf("ADMIN"));
        user.setLock(true);
        user.setActive(true);

        userRepository.save(user);


        String jwt = jwtService.generateToken(user);


        saveUserToken(jwt, user);
        sendActivationEmail(user);

        return new AuthenticationResponse(jwt, "User registration was successful", null);
    }


//    public AuthenticationResponse registerSales(User user) {
//
//        if (userRepository.findByEmail(user.getUsername()).isPresent()) {
//            return new AuthenticationResponse(null, "User already exists", null);
//        }
//
//
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        user.setRole(Role.valueOf("SALES_EXECUTIVE"));
//        user.setLock(true);
//        user.setActive(true);
//
//        userRepository.save(user);
//
//
//        String jwt = jwtService.generateToken(user);
//
//
//        saveUserToken(jwt, user);
//        sendActivationEmail(user);
//
//        return new AuthenticationResponse(jwt, "User registration was successful", null);
//    }


    public AuthenticationResponse authenticate(User request) {


        authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getUsername(),
                        request.getPassword()
                )
        );


        User user = userRepository.findByEmail(request.getUsername()).orElseThrow();


        String jwt = jwtService.generateToken(user);


        removeAllTokenByUser(user);


        saveUserToken(jwt, user);


        AuthenticationResponse authenticationResponse = new AuthenticationResponse();
        authenticationResponse.setUser(user);
        authenticationResponse.setToken(jwt);
        authenticationResponse.setMessage("User login was successful");
        return authenticationResponse;
    }


    private void sendActivationEmail(User user) {
        String activationLink = "http://localhost:8089/activate/" + user.getId();

        String mailText = "<h3>Dear " + user.getName()
                + ",</h3>"
                + "<p>Please click on the following link to confirm your account:</p>"
                + "<a href=\"" + activationLink + "\">Activate Account</a>"
                + "<br><br>Regards,<br>Hotel Booking";

        String subject = "Confirm User Account";

        try {

            emailService.sendSimpleMail(user.getEmail(), subject, mailText);

        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }

    }


    public String activateUser(long id) {

        User user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not Found with this ID"));

        if (user != null) {

            user.setActive(true);
            userRepository.save(user);
            return "User activated successfully!";
        } else {
            return "Invalid activation token!";
        }
    }
}
