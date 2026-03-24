package com.recrute.repository;

import com.recrute.model.Candidature;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CandidatureRepository extends JpaRepository<Candidature, Long> {
    List<Candidature> findByCandidatId(Long idCandidat);
    List<Candidature> findByOffreId(Long idOffre);
}