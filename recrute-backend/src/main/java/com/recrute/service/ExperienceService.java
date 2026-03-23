package com.recrute.service;

import com.recrute.model.Experience;
import com.recrute.repository.ExperienceRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class ExperienceService {

    private final ExperienceRepository experienceRepository;

    public List<Experience> getAll() {
        return experienceRepository.findAll();
    }

    public List<Experience> getByCandidat(Long idCandidat) {
        return experienceRepository.findByCandidatId(idCandidat);
    }

    public Optional<Experience> getById(Long id) {
        return experienceRepository.findById(id);
    }

    public Experience create(Experience experience) {
        return experienceRepository.save(experience);
    }

    public Experience update(Long id, Experience updated) {
        updated.setId(id);
        return experienceRepository.save(updated);
    }

    public void delete(Long id) {
        experienceRepository.deleteById(id);
    }
    
}