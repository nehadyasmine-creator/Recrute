package com.recrute.service;

import com.recrute.model.Competence;
import com.recrute.repository.CompetenceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CompetenceService {

    private final CompetenceRepository competenceRepository;

    public List<Competence> getAll() {
        return competenceRepository.findAll();
    }

    public Optional<Competence> getById(Long id) {
        return competenceRepository.findById(id);
    }

    public Competence create(Competence competence) {
        return competenceRepository.save(competence);
    }

    public Competence update(Long id, Competence updated) {
        updated.setId(id);
        return competenceRepository.save(updated);
    }

    public void delete(Long id) {
        competenceRepository.deleteById(id);
    }
}