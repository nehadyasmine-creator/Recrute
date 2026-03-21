package com.recrute.service;

import com.recrute.model.CompetenceCandidat;
import com.recrute.model.CompetenceCandidatId;
import com.recrute.repository.CompetenceCandidatRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CompetenceCandidatService {

    private final CompetenceCandidatRepository competenceCandidatRepository;

    public List<CompetenceCandidat> getAll() {
        return competenceCandidatRepository.findAll();
    }

    public List<CompetenceCandidat> getByCandidat(Long idCandidat) {
        return competenceCandidatRepository.findByIdIdCandidat(idCandidat);
    }

    public Optional<CompetenceCandidat> getById(CompetenceCandidatId id) {
        return competenceCandidatRepository.findById(id);
    }

    public CompetenceCandidat create(CompetenceCandidat competenceCandidat) {
        return competenceCandidatRepository.save(competenceCandidat);
    }

    public void delete(CompetenceCandidatId id) {
        competenceCandidatRepository.deleteById(id);
    }
}