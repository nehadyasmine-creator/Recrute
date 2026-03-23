package com.recrute.service;

import com.recrute.model.Lien;
import com.recrute.repository.LienRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class LienService {

    private final LienRepository lienRepository;

    public List<Lien> getAll() {
        return lienRepository.findAll();
    }

    public List<Lien> getByCandidat(Long idCandidat) {
        return lienRepository.findByCandidatId(idCandidat);
    }

    public Optional<Lien> getById(Long id) {
        return lienRepository.findById(id);
    }

    public Lien create(Lien lien) {
        return lienRepository.save(lien);
    }

    public Lien update(Long id, Lien updated) {
        updated.setId(id);
        return lienRepository.save(updated);
    }

    public void delete(Long id) {
        lienRepository.deleteById(id);
    }
}