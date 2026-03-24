package com.recrute.controller;

import com.recrute.model.Candidat;
import com.recrute.service.CandidatService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import com.recrute.service.FileStorageService;
import org.springframework.http.MediaType;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;

@RestController
@RequestMapping("/candidats")
@RequiredArgsConstructor
public class CandidatController {

    private final CandidatService candidatService;
    private final FileStorageService fileStorageService;


    @GetMapping
    public List<Candidat> getAll() {
        return candidatService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Candidat> getById(@PathVariable Long id) {
        return candidatService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Candidat create(@RequestBody Candidat candidat) {
        return candidatService.create(candidat);
    }

    @PutMapping("/{id}")
    public Candidat update(@PathVariable Long id, @RequestBody Candidat candidat) {
        return candidatService.update(id, candidat);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        candidatService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @PostMapping("/{id}/cv")
    public ResponseEntity<String> uploadCv(
            @PathVariable Long id,
            @RequestParam("file") MultipartFile file) {
        try {
            Candidat candidat = candidatService.getById(id)
                    .orElseThrow(() -> new RuntimeException("Candidat non trouvé"));

            String fileName = fileStorageService.saveFile(file);
            candidat.setCv(fileName);
            candidatService.create(candidat);

            return ResponseEntity.ok("CV uploadé avec succès : " + fileName);
        } catch (IOException e) {
            return ResponseEntity.internalServerError().body("Erreur lors de l'upload : " + e.getMessage());
        }
    }

    @GetMapping("/{id}/cv")
    public ResponseEntity<byte[]> downloadCv(@PathVariable Long id) {
        try {
            Candidat candidat = candidatService.getById(id)
                    .orElseThrow(() -> new RuntimeException("Candidat non trouvé"));

            byte[] fileContent = fileStorageService.loadFile(candidat.getCv());

            return ResponseEntity.ok()
                    .contentType(MediaType.APPLICATION_PDF)
                    .body(fileContent);
        } catch (IOException e) {
            return ResponseEntity.notFound().build();
        }
    }
}