package com.recrute.service;

import com.recrute.model.Candidat;
import com.recrute.repository.CandidatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CandidatService {

    private final CandidatRepository candidatRepository;

    public List<Candidat> getAll() {
        return candidatRepository.findAll();
    }

    public Optional<Candidat> getById(Long id) {
        return candidatRepository.findById(id);
    }

    public Optional<Candidat> getByUtilisateurId(Long idUtilisateur) {
        return candidatRepository.findByUtilisateurId(idUtilisateur);
    }

    public Candidat create(Candidat candidat) {
        return candidatRepository.save(candidat);
    }

    public Candidat update(Long id, Candidat updated) {
        updated.setId(id);
        return candidatRepository.save(updated);
    }

    public void delete(Long id) {
        candidatRepository.deleteById(id);
    }
}