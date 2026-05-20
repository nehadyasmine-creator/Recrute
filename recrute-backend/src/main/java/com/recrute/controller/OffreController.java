package com.recrute.controller;

import com.recrute.dto.OffreDTO;
import com.recrute.model.Offre;
import com.recrute.service.OffreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/offres")
@RequiredArgsConstructor
public class OffreController {

    private final OffreService offreService;

    @GetMapping
    public List<Offre> getAll() {
        return offreService.getAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Offre> getById(@PathVariable Long id) {
        return offreService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/recruteur/{idRecruteur}")
    public List<Offre> getByRecruteur(@PathVariable Long idRecruteur) {
        return offreService.getByRecruteur(idRecruteur);
    }

    @GetMapping("/ouvertes")
    public List<Offre> getOffresOuvertes() {
        return offreService.getOffresOuvertes();
    }

    @PostMapping
    public Offre create(@RequestBody OffreDTO offreDTO) {
        return offreService.createFromDTO(offreDTO);
    }

    @PutMapping("/{id}")
    public Offre update(@PathVariable Long id, @RequestBody OffreDTO offreDTO) {
        return offreService.updateFromDTO(id, offreDTO);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        offreService.delete(id);
        return ResponseEntity.noContent().build();
    }
}