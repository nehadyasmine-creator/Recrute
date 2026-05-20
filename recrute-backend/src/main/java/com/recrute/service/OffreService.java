package com.recrute.service;

import com.recrute.dto.OffreDTO;
import com.recrute.model.Offre;
import com.recrute.model.Recruteur;
import com.recrute.repository.OffreRepository;
import com.recrute.repository.RecruteurRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import com.recrute.enums.StatutOffre;
import com.recrute.enums.ContratType;


@Service
@RequiredArgsConstructor
public class OffreService {

    private final OffreRepository offreRepository;
    private final RecruteurRepository recruteurRepository;

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

    public Offre createFromDTO(OffreDTO dto) {
        Offre offre = new Offre();
        if (dto.getIdRecruteur() != null) {
            Recruteur recruteur = recruteurRepository.findById(dto.getIdRecruteur())
                    .orElseThrow(() -> new IllegalArgumentException("Recruteur not found"));
            offre.setRecruteur(recruteur);
        }
        return updateOffreFromDTO(offre, dto);
    }

    public Offre updateFromDTO(Long id, OffreDTO dto) {
        Offre offre = offreRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Offre not found"));
        
        if (dto.getIdRecruteur() != null) {
            Recruteur recruteur = recruteurRepository.findById(dto.getIdRecruteur())
                    .orElseThrow(() -> new IllegalArgumentException("Recruteur not found"));
            offre.setRecruteur(recruteur);
        }
        
        return updateOffreFromDTO(offre, dto);
    }

    private Offre updateOffreFromDTO(Offre offre, OffreDTO dto) {
        offre.setTitre(dto.getTitre());
        offre.setDescription(dto.getDescription());
        offre.setLieu(dto.getLieu());
        if (dto.getTypeContrat() != null) {
            offre.setTypeContrat(ContratType.valueOf(dto.getTypeContrat()));
        }
        offre.setSalaire(dto.getSalaire());
        offre.setDuree(dto.getDuree());
        offre.setExperienceRequise(dto.getExperienceRequise());
        offre.setDateDebut(dto.getDateDebut());
        offre.setDatePublication(dto.getDatePublication());
        offre.setTeletravail(dto.getTeletravail() != null && dto.getTeletravail());
        if (dto.getStatut() != null) {
            offre.setStatut(StatutOffre.valueOf(dto.getStatut()));
        }
        return offreRepository.save(offre);
    }
}