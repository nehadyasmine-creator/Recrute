package com.recrute.controller;

import com.recrute.model.Recruteur;
import com.recrute.service.RecruteurService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/recruteurs")
@RequiredArgsConstructor
public class RecruteurController {

    private final RecruteurService recruteurService;

    @GetMapping
    public List<Recruteur> getAll() {
        return recruteurService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Recruteur> getById(@PathVariable Long id) {
        return recruteurService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/utilisateur/{idUtilisateur}")
    public ResponseEntity<Recruteur> getByUtilisateur(@PathVariable Long idUtilisateur) {
        return recruteurService.getByUtilisateur(idUtilisateur)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }
    
    @PostMapping
    public Recruteur create(@RequestBody Recruteur recruteur) {
        return recruteurService.create(recruteur);
    }

    @PutMapping("/{id}")
    public Recruteur update(@PathVariable Long id, @RequestBody Recruteur recruteur) {
        return recruteurService.update(id, recruteur);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        recruteurService.delete(id);
        return ResponseEntity.noContent().build();
    }
}