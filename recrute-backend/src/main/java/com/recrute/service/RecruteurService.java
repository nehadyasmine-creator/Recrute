package com.recrute.service;

import com.recrute.model.Recruteur;
import com.recrute.repository.RecruteurRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class RecruteurService {

    private final RecruteurRepository recruteurRepository;

    public List<Recruteur> getAll() {
        return recruteurRepository.findAll();
    }

    public Optional<Recruteur> getById(Long id) {
        return recruteurRepository.findById(id);
    }

    public Recruteur create(Recruteur recruteur) {
        return recruteurRepository.save(recruteur);
    }

    public Recruteur update(Long id, Recruteur updated) {
        updated.setId(id);
        return recruteurRepository.save(updated);
    }

    public void delete(Long id) {
        recruteurRepository.deleteById(id);
    }

    public Optional<Recruteur> getByUtilisateur(Long idUtilisateur) {
        return recruteurRepository.findByUtilisateurId(idUtilisateur);
    }
}