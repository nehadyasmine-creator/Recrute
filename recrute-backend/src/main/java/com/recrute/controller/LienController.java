package com.recrute.controller;

import com.recrute.model.Lien;
import com.recrute.service.LienService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/liens")
@RequiredArgsConstructor
public class LienController {

    private final LienService lienService;

    @GetMapping
    public List<Lien> getAll() {
        return lienService.getAll();
    }

    @GetMapping("/candidat/{idCandidat}")
    public List<Lien> getByCandidat(@PathVariable Long idCandidat) {
        return lienService.getByCandidat(idCandidat);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Lien> getById(@PathVariable Long id) {
        return lienService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Lien create(@RequestBody Lien lien) {
        return lienService.create(lien);
    }

    @PutMapping("/{id}")
    public Lien update(@PathVariable Long id, @RequestBody Lien lien) {
        return lienService.update(id, lien);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        lienService.delete(id);
        return ResponseEntity.noContent().build();
    }
}