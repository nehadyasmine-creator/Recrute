package com.recrute.controller;

import com.recrute.model.CompetenceOffre;
import com.recrute.model.CompetenceOffreId;
import com.recrute.service.CompetenceOffreService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/competences-offres")
@RequiredArgsConstructor
public class CompetenceOffreController {

    private final CompetenceOffreService competenceOffreService;

    @GetMapping
    public List<CompetenceOffre> getAll() {
        return competenceOffreService.getAll();
    }

    @GetMapping("/offre/{idOffre}")
    public List<CompetenceOffre> getByOffre(@PathVariable Long idOffre) {
        return competenceOffreService.getByOffre(idOffre);
    }

    @PostMapping
    public CompetenceOffre create(@RequestBody CompetenceOffre competenceOffre) {
        return competenceOffreService.create(competenceOffre);
    }

    @DeleteMapping
    public ResponseEntity<Void> delete(@RequestBody CompetenceOffreId id) {
        competenceOffreService.delete(id);
        return ResponseEntity.noContent().build();
    }
}