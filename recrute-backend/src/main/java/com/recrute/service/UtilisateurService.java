package com.recrute.service;

import com.recrute.model.Utilisateur;
import com.recrute.repository.UtilisateurRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UtilisateurService {

    private final UtilisateurRepository utilisateurRepository;

    public List<Utilisateur> getAll() {
        return utilisateurRepository.findAll();
    }

    public Optional<Utilisateur> getById(Long id) {
        return utilisateurRepository.findById(id);
    }

    public Optional<Utilisateur> getByEmail(String email) {
        return utilisateurRepository.findByEmail(email);
    }

    public Utilisateur create(Utilisateur utilisateur) {
        return utilisateurRepository.save(utilisateur);
    }

    public Utilisateur update(Long id, Utilisateur updated) {
        Utilisateur existing = utilisateurRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur introuvable"));

        updated.setId(id);

        if (updated.getMotDePasse() == null || updated.getMotDePasse().isBlank()) {
            updated.setMotDePasse(existing.getMotDePasse());
        }
        if (updated.getDateCreation() == null) {
            updated.setDateCreation(existing.getDateCreation());
        }
        if (updated.getRole() == null) {
            updated.setRole(existing.getRole());
        }
        if (updated.getPdp() == null) {
            updated.setPdp(existing.getPdp());
        }

        return utilisateurRepository.save(updated);
    }

    public void delete(Long id) {
        utilisateurRepository.deleteById(id);
    }
}