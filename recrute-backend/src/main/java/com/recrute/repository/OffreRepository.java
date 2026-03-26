package com.recrute.repository;

import com.recrute.model.Offre;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.recrute.enums.StatutOffre;

@Repository
public interface OffreRepository extends JpaRepository<Offre, Long> {
    List<Offre> findByRecruteurId(Long idRecruteur);
    List<Offre> findByStatut(StatutOffre statut);
}