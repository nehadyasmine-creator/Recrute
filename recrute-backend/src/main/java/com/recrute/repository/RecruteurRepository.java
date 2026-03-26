package com.recrute.repository;

import com.recrute.model.Recruteur;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface RecruteurRepository extends JpaRepository<Recruteur, Long> {
    Optional<Recruteur> findByUtilisateurId(Long idUtilisateur);
}