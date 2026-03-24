package com.recrute.controller;

import com.recrute.model.Messagerie;
import com.recrute.service.MessagerieService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/messagerie")
@RequiredArgsConstructor
public class MessagerieController {

    private final MessagerieService messagerieService;

    @GetMapping
    public List<Messagerie> getAll() {
        return messagerieService.getAll();
    }

    @GetMapping("/candidature/{idCandidature}")
    public List<Messagerie> getByCandidature(@PathVariable Long idCandidature) {
        return messagerieService.getByCandidature(idCandidature);
    }

    @GetMapping("/candidat/{idCandidat}")
    public List<Messagerie> getByCandidat(@PathVariable Long idCandidat) {
        return messagerieService.getByCandidat(idCandidat);
    }

    @GetMapping("/recruteur/{idRecruteur}")
    public List<Messagerie> getByRecruteur(@PathVariable Long idRecruteur) {
        return messagerieService.getByRecruteur(idRecruteur);
    }

    @GetMapping("/{id}")
    public ResponseEntity<Messagerie> getById(@PathVariable Long id) {
        return messagerieService.getById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Messagerie create(@RequestBody Messagerie messagerie) {
        return messagerieService.create(messagerie);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        messagerieService.delete(id);
        return ResponseEntity.noContent().build();
    }
}