package com.recrute.service;

import com.recrute.model.CompetenceOffre;
import com.recrute.model.CompetenceOffreId;
import com.recrute.repository.CompetenceOffreRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CompetenceOffreService {

    private final CompetenceOffreRepository competenceOffreRepository;

    public List<CompetenceOffre> getAll() {
        return competenceOffreRepository.findAll();
    }

    public Optional<CompetenceOffre> getById(CompetenceOffreId id) {
        return competenceOffreRepository.findById(id);
    }

    public List<CompetenceOffre> getByOffre(Long idOffre) {
        return competenceOffreRepository.findByIdIdOffre(idOffre);
    }

    public CompetenceOffre create(CompetenceOffre competenceOffre) {
        return competenceOffreRepository.save(competenceOffre);
    }

    public void delete(CompetenceOffreId id) {
        competenceOffreRepository.deleteById(id);
    }
}