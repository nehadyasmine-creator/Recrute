package com.recrute.repository;

import com.recrute.model.CompetenceCandidat;
import com.recrute.model.CompetenceCandidatId;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CompetenceCandidatRepository extends JpaRepository<CompetenceCandidat, CompetenceCandidatId> {
    List<CompetenceCandidat> findByIdIdCandidat(Long idCandidat);
}