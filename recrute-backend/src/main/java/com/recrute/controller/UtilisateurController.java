package com.recrute.controller;

import com.recrute.model.Utilisateur;
import com.recrute.service.FileStorageService;
import com.recrute.service.UtilisateurService;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@RestController
@RequestMapping("/utilisateurs")
@RequiredArgsConstructor
public class UtilisateurController {

    private final UtilisateurService utilisateurService;
    private final FileStorageService fileStorageService;

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
}