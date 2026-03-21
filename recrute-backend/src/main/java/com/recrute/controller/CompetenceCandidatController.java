package com.recrute.controller;

import com.recrute.model.CompetenceCandidat;
import com.recrute.model.CompetenceCandidatId;
import com.recrute.service.CompetenceCandidatService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/competences-candidats")
@RequiredArgsConstructor
public class CompetenceCandidatController {

    private final CompetenceCandidatService competenceCandidatService;

    @GetMapping
    public List<CompetenceCandidat> getAll() {
        return competenceCandidatService.getAll();
    }

    @GetMapping("/candidat/{idCandidat}")
    public List<CompetenceCandidat> getByCandidat(@PathVariable Long idCandidat) {
        return competenceCandidatService.getByCandidat(idCandidat);
    }

    @PostMapping
    public CompetenceCandidat create(@RequestBody CompetenceCandidat competenceCandidat) {
        return competenceCandidatService.create(competenceCandidat);
    }

    @DeleteMapping
    public ResponseEntity<Void> delete(@RequestBody CompetenceCandidatId id) {
        competenceCandidatService.delete(id);
        return ResponseEntity.noContent().build();
    }
}