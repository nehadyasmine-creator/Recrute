package com.recrute.repository;

import com.recrute.model.Lien;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface LienRepository extends JpaRepository<Lien, Long> {
    List<Lien> findByCandidatId(Long idCandidat);
}