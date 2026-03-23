package com.recrute.service;

import com.recrute.model.Candidature;
import com.recrute.repository.CandidatureRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CandidatureService {

    private final CandidatureRepository candidatureRepository;

    public List<Candidature> getAll() {
        return candidatureRepository.findAll();
    }

    public List<Candidature> getByCandidat(Long idCandidat) {
        return candidatureRepository.findByCandidatId(idCandidat);
    }

    public List<Candidature> getByOffre(Long idOffre) {
        return candidatureRepository.findByOffreId(idOffre);
    }

    public Optional<Candidature> getById(Long id) {
        return candidatureRepository.findById(id);
    }

    public Candidature create(Candidature candidature) {
        return candidatureRepository.save(candidature);
    }

    public Candidature update(Long id, Candidature updated) {
        updated.setId(id);
        return candidatureRepository.save(updated);
    }

    public void delete(Long id) {
        candidatureRepository.deleteById(id);
    }
}