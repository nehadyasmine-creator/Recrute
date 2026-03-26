package com.recrute.service;

import com.recrute.model.Offre;
import com.recrute.repository.OffreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import com.recrute.enums.StatutOffre;


@Service
@RequiredArgsConstructor
public class OffreService {

    private final OffreRepository offreRepository;

    public List<Offre> getAll() {
        return offreRepository.findAll();
    }

    public Optional<Offre> getById(Long id) {
        return offreRepository.findById(id);
    }

    public Offre create(Offre offre) {
        return offreRepository.save(offre);
    }

    public Offre update(Long id, Offre updated) {
        updated.setId(id);
        return offreRepository.save(updated);
    }

    public void delete(Long id) {
        offreRepository.deleteById(id);
    }

    public List<Offre> getByRecruteur(Long idRecruteur) {
        return offreRepository.findByRecruteurId(idRecruteur);
    }

    public List<Offre> getOffresOuvertes() {
        return offreRepository.findByStatut(StatutOffre.ouverte);
    }
}