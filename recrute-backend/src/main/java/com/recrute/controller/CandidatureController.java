package com.recrute.controller;

import com.recrute.model.Candidature;
import com.recrute.service.CandidatureService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/candidatures")
@RequiredArgsConstructor
public class CandidatureController {

    private final CandidatureService candidatureService;

    @GetMapping
    public List<Candidature> getAll() {
        return candidatureService.getAll();
    }

    @GetMapping("/candidat/{idCandidat}")
    public List<Candidature> getByCandidat(@PathVariable Long idCandidat) {
        return candidatureService.getByCandidat(idCandidat);
    }

    @GetMapping("/offre/{idOffre}")
    public List<Candidature> getByOffre(@PathVariable Long idOffre) {
        return candidatureService.getByOffre(idOffre);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Candidature> getById(@PathVariable Long id) {
        return candidatureService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Candidature create(@RequestBody Candidature candidature) {
        return candidatureService.create(candidature);
    }

    @PutMapping("/{id}")
    public Candidature update(@PathVariable Long id, @RequestBody Candidature candidature) {
        return candidatureService.update(id, candidature);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        candidatureService.delete(id);
        return ResponseEntity.noContent().build();
    }
}