package com.recrute.controller;

import com.recrute.model.Entreprise;
import com.recrute.service.EntrepriseService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/entreprises")
@RequiredArgsConstructor
public class EntrepriseController {

    private final EntrepriseService entrepriseService;

    @GetMapping
    public List<Entreprise> getAll() {
        return entrepriseService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Entreprise> getById(@PathVariable Long id) {
        return entrepriseService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Entreprise create(@RequestBody Entreprise entreprise) {
        return entrepriseService.create(entreprise);
    }

    @PutMapping("/{id}")
    public Entreprise update(@PathVariable Long id, @RequestBody Entreprise entreprise) {
        return entrepriseService.update(id, entreprise);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        entrepriseService.delete(id);
        return ResponseEntity.noContent().build();
    }
}