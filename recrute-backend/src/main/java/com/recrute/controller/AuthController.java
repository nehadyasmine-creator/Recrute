package com.recrute.controller;

import com.recrute.enums.RoleType;
import com.recrute.model.Candidat;
import com.recrute.model.Recruteur;
import com.recrute.model.Utilisateur;
import com.recrute.repository.CandidatRepository;
import com.recrute.repository.RecruteurRepository;
import com.recrute.repository.UtilisateurRepository;
import com.recrute.service.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDate;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class AuthController {

    private final UtilisateurRepository utilisateurRepository;
    private final CandidatRepository candidatRepository;
    private final RecruteurRepository recruteurRepository;
    private final JwtService jwtService;
    private final PasswordEncoder passwordEncoder;

    @PostMapping("/register")
    @Transactional
    public ResponseEntity<?> register(@RequestBody Utilisateur utilisateur) {
        if (utilisateurRepository.findByEmail(utilisateur.getEmail()).isPresent()) {
            return ResponseEntity.badRequest().body("Email déjà utilisé");
        }
        utilisateur.setMotDePasse(passwordEncoder.encode(utilisateur.getMotDePasse()));
        utilisateur.setDateCreation(LocalDate.now());
        Utilisateur savedUtilisateur = utilisateurRepository.save(utilisateur);

        if (savedUtilisateur.getRole() == RoleType.candidat) {
            Candidat candidat = new Candidat();
            candidat.setUtilisateur(savedUtilisateur);
            candidatRepository.save(candidat);
        }else{
            Recruteur recruteur = new Recruteur();
            recruteur.setUtilisateur(savedUtilisateur);
            recruteurRepository.save(recruteur);
        }

        return ResponseEntity.ok(Map.of("message", "Inscription réussie"));
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody Map<String, String> body) {
        String email = body.get("email");
        String motDePasse = body.get("motDePasse");

        Optional<Utilisateur> utilisateur = utilisateurRepository.findByEmail(email);

        if (utilisateur.isEmpty() || !passwordEncoder.matches(motDePasse, utilisateur.get().getMotDePasse())) {
            return ResponseEntity.status(401).body("Email ou mot de passe incorrect");
        }

        String token = jwtService.generateToken(email, utilisateur.get().getRole().name());
        return ResponseEntity.ok(Map.of("token", token,"id", utilisateur.get().getId()));
    }
}