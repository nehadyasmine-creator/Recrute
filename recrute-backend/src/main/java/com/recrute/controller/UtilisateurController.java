package com.recrute.controller;

import com.recrute.enums.RoleType;
import com.recrute.model.Utilisateur;
import com.recrute.service.CandidatService;
import com.recrute.service.FileStorageService;
import com.recrute.service.RecruteurService;
import com.recrute.service.UtilisateurService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.Normalizer;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;

@RestController
@RequestMapping("/utilisateurs")
@RequiredArgsConstructor
public class UtilisateurController {

    private final UtilisateurService utilisateurService;
    private final CandidatService candidatService;
    private final RecruteurService recruteurService;
    private final FileStorageService fileStorageService;
    private final PasswordEncoder passwordEncoder;

    @Value("${file.upload-pdp-dir:uploads/pdp}")
    private String pdpUploadDir;

    @GetMapping
    public List<Utilisateur> getAll() {
        return utilisateurService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Utilisateur> getById(@PathVariable Long id) {
        return utilisateurService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Utilisateur create(@RequestBody Utilisateur utilisateur) {
        return utilisateurService.create(utilisateur);
    }

    @PutMapping("/{id}")
    public Utilisateur update(@PathVariable Long id, @RequestBody Utilisateur utilisateur) {
        return utilisateurService.update(id, utilisateur);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        utilisateurService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/pdp")
    public ResponseEntity<String> uploadPdp(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file) {
        try {
            Utilisateur utilisateur = utilisateurService.getById(id)
                    .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
            String fileName = fileStorageService.savePdpFile(file);
            utilisateur.setPdp(fileName);
            utilisateurService.update(id, utilisateur);
            return ResponseEntity.ok("PDP uploadé avec succès : " + fileName);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("Erreur lors de l'upload : " + e.getMessage());
        }
    }

    @GetMapping("/{id}/pdp")
    public ResponseEntity<byte[]> downloadPdp(@PathVariable Long id) {
        try {
            Utilisateur utilisateur = utilisateurService.getById(id)
                    .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
            byte[] fileContent = fileStorageService.loadPdpFile(utilisateur.getPdp());
            String contentType = Files.probeContentType(
                    Paths.get(pdpUploadDir).resolve(utilisateur.getPdp()));
            MediaType mediaType = contentType != null
                    ? MediaType.parseMediaType(contentType)
                    : MediaType.IMAGE_JPEG;
            return ResponseEntity.ok()
                    .contentType(mediaType)
                    .body(fileContent);
        } catch (IOException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @PostMapping("/{id}/change-password")
    public ResponseEntity<String> changePassword(@PathVariable Long id, @RequestBody ChangePasswordRequest request) {
        if (request == null || request.ancienMotDePasse() == null || request.nouveauMotDePasse() == null
                || request.confirmationNouveauMotDePasse() == null) {
            return ResponseEntity.badRequest().body("Champs de mot de passe invalides.");
        }

        if (request.nouveauMotDePasse().isBlank()) {
            return ResponseEntity.badRequest().body("Le nouveau mot de passe est obligatoire.");
        }

        if (!request.nouveauMotDePasse().equals(request.confirmationNouveauMotDePasse())) {
            return ResponseEntity.badRequest().body("La confirmation du nouveau mot de passe ne correspond pas.");
        }

        Utilisateur utilisateur = utilisateurService.getById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));

        if (!passwordEncoder.matches(request.ancienMotDePasse(), utilisateur.getMotDePasse())) {
            return ResponseEntity.badRequest().body("Ancien mot de passe incorrect.");
        }

        utilisateur.setMotDePasse(passwordEncoder.encode(request.nouveauMotDePasse()));
        utilisateurService.update(id, utilisateur);

        return ResponseEntity.ok("Mot de passe modifié avec succès.");
    }

    @PostMapping(value = "/mot-de-passe-oublie/init", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> initForgotPassword(@RequestBody ForgotPasswordInitRequest request) {
        Optional<Utilisateur> utilisateurOptional = findUtilisateurByEmailAndRole(request.email(), request.role());
        if (utilisateurOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Mail ou type de compte incorrect."));
        }

        return ResponseEntity.ok(buildVerificationProfile(utilisateurOptional.get()));
    }

    @PostMapping(value = "/mot-de-passe-oublie/verifier", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> verifyForgotPassword(@RequestBody ForgotPasswordVerifyRequest request) {
        Optional<Utilisateur> utilisateurOptional = findUtilisateurByEmailAndRole(request.email(), request.role());
        if (utilisateurOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Mail ou type de compte incorrect."));
        }

        ForgotPasswordProfileResponse profile = buildVerificationProfile(utilisateurOptional.get());
        if (!profile.matches(request)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Informations incorrectes."));
        }

        return ResponseEntity.ok(Map.of("verified", true, "message", "Compte vérifié avec succès."));
    }

    @PostMapping(value = "/mot-de-passe-oublie/reinitialiser", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<?> resetForgotPassword(@RequestBody ForgotPasswordResetRequest request) {
        if (request == null || request.nouveauMotDePasse() == null || request.confirmationNouveauMotDePasse() == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Champs de mot de passe invalides."));
        }

        if (request.nouveauMotDePasse().isBlank()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Le nouveau mot de passe est obligatoire."));
        }

        if (!request.nouveauMotDePasse().equals(request.confirmationNouveauMotDePasse())) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "La confirmation du nouveau mot de passe ne correspond pas."));
        }

        Optional<Utilisateur> utilisateurOptional = findUtilisateurByEmailAndRole(request.email(), request.role());
        if (utilisateurOptional.isEmpty()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Mail ou type de compte incorrect."));
        }

        ForgotPasswordProfileResponse profile = buildVerificationProfile(utilisateurOptional.get());
        if (!profile.matches(request)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(Map.of("message", "Informations incorrectes."));
        }

        Utilisateur utilisateur = utilisateurOptional.get();
        utilisateur.setMotDePasse(passwordEncoder.encode(request.nouveauMotDePasse()));
        utilisateurService.update(utilisateur.getId(), utilisateur);

        return ResponseEntity.ok(Map.of("message", "Mot de passe réinitialisé avec succès."));
    }

    private Optional<Utilisateur> findUtilisateurByEmailAndRole(String email, String role) {
        if (email == null || role == null) {
            return Optional.empty();
        }

        Optional<Utilisateur> utilisateurOptional = utilisateurService.getByEmail(email.trim());
        if (utilisateurOptional.isEmpty()) {
            return Optional.empty();
        }

        Utilisateur utilisateur = utilisateurOptional.get();
        if (utilisateur.getRole() == null || !utilisateur.getRole().name().equalsIgnoreCase(role.trim())) {
            return Optional.empty();
        }

        return utilisateurOptional;
    }

        private ForgotPasswordProfileResponse buildVerificationProfile(Utilisateur utilisateur) {
        String poste = null;

        if (utilisateur.getRole() == RoleType.recruteur) {
            poste = recruteurService.getByUtilisateur(utilisateur.getId())
                .map(recruteur -> recruteur.getPoste())
                .orElse(null);
        }

        return new ForgotPasswordProfileResponse(
            utilisateur.getEmail(),
            utilisateur.getRole() == null ? null : utilisateur.getRole().name(),
            utilisateur.getNom(),
            utilisateur.getPrenom(),
            utilisateur.getTelephone(),
            null,
            poste,
            null
        );
    }

    private static String normalizeText(String value) {
        if (value == null) {
            return "";
        }

        String normalized = Normalizer.normalize(value, Normalizer.Form.NFD).replaceAll("\\p{M}", "");
        return normalized.toLowerCase(Locale.ROOT).trim().replaceAll("\\s+", " ");
    }

    private static String normalizePhone(String value) {
        if (value == null) {
            return "";
        }

        return value.replaceAll("[^0-9]", "");
    }

    public record ForgotPasswordInitRequest(String email, String role) {
    }

    public record ForgotPasswordVerifyRequest(
            String email,
            String role,
            String nom,
            String prenom,
            String telephone,
            String ville,
            String poste,
            String entreprise) {
    }

    public record ForgotPasswordResetRequest(
            String email,
            String role,
            String nom,
            String prenom,
            String telephone,
            String ville,
            String poste,
            String entreprise,
            String nouveauMotDePasse,
            String confirmationNouveauMotDePasse) {
    }

    private record ForgotPasswordProfileResponse(
            String email,
            String role,
            String nom,
            String prenom,
            String telephone,
            String ville,
            String poste,
            String entreprise) {

        private boolean matches(ForgotPasswordVerifyRequest request) {
            return matches(request.nom(), nom)
                    && matches(request.prenom(), prenom)
                    && matchesPhone(request.telephone(), telephone)
                    && matchesRoleSpecificField(request);
        }

        private boolean matches(ForgotPasswordResetRequest request) {
            return matches(request.nom(), nom)
                    && matches(request.prenom(), prenom)
                    && matchesPhone(request.telephone(), telephone)
                    && matchesRoleSpecificField(request);
        }

        private boolean matchesRoleSpecificField(ForgotPasswordVerifyRequest request) {
            if ("recruteur".equalsIgnoreCase(role)) {
                return matches(request.poste(), poste);
            }

            return true;
        }

        private boolean matchesRoleSpecificField(ForgotPasswordResetRequest request) {
            if ("recruteur".equalsIgnoreCase(role)) {
                return matches(request.poste(), poste);
            }

            return true;
        }

        private boolean matches(String actual, String expected) {
            if (expected == null || expected.isBlank()) {
                return true;
            }

            return normalizeText(actual).equals(normalizeText(expected));
        }

        private boolean matchesPhone(String actual, String expected) {
            if (expected == null || expected.isBlank()) {
                return true;
            }

            return normalizePhone(actual).equals(normalizePhone(expected));
        }
    }

    public record ChangePasswordRequest(
            String ancienMotDePasse,
            String nouveauMotDePasse,
            String confirmationNouveauMotDePasse) {
    }
}