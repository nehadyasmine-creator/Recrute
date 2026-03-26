package com.recrute.repository;

import com.recrute.model.CompetenceOffre;
import com.recrute.model.CompetenceOffreId;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface CompetenceOffreRepository extends JpaRepository<CompetenceOffre, CompetenceOffreId> {
    List<CompetenceOffre> findByIdIdOffre(Long idOffre);
}