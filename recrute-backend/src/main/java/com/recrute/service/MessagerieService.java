package com.recrute.service;

import com.recrute.model.Messagerie;
import com.recrute.repository.MessagerieRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class MessagerieService {

    private final MessagerieRepository messagerieRepository;

    public List<Messagerie> getAll() {
        return messagerieRepository.findAll();
    }

    public List<Messagerie> getByCandidature(Long idCandidature) {
        return messagerieRepository.findByCandidatureId(idCandidature);
    }

    public List<Messagerie> getByCandidat(Long idCandidat) {
        return messagerieRepository.findByCandidatId(idCandidat);
    }

    public List<Messagerie> getByRecruteur(Long idRecruteur) {
        return messagerieRepository.findByRecruteurId(idRecruteur);
    }

    public Optional<Messagerie> getById(Long id) {
        return messagerieRepository.findById(id);
    }

    public Messagerie create(Messagerie messagerie) {
        return messagerieRepository.save(messagerie);
    }

    public void delete(Long id) {
        messagerieRepository.deleteById(id);
    }
}