package com.recrute.controller;

import com.recrute.model.Competence;
import com.recrute.service.CompetenceService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/competences")
@RequiredArgsConstructor
public class CompetenceController {

    private final CompetenceService competenceService;

    @GetMapping
    public List<Competence> getAll() {
        return competenceService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Competence> getById(@PathVariable Long id) {
        return competenceService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Competence create(@RequestBody Competence competence) {
        return competenceService.create(competence);
    }

    @PutMapping("/{id}")
    public Competence update(@PathVariable Long id, @RequestBody Competence competence) {
        return competenceService.update(id, competence);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        competenceService.delete(id);
        return ResponseEntity.noContent().build();
    }
}