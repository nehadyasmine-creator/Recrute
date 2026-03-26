package com.recrute.service;

import com.recrute.model.Entreprise;
import com.recrute.repository.EntrepriseRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class EntrepriseService {

    private final EntrepriseRepository entrepriseRepository;

    public List<Entreprise> getAll() {
        return entrepriseRepository.findAll();
    }

    public Optional<Entreprise> getById(Long id) {
        return entrepriseRepository.findById(id);
    }

    public Entreprise create(Entreprise entreprise) {
        return entrepriseRepository.save(entreprise);
    }

    public Entreprise update(Long id, Entreprise updated) {
        updated.setId(id);
        return entrepriseRepository.save(updated);
    }

    public void delete(Long id) {
        entrepriseRepository.deleteById(id);
    }
}