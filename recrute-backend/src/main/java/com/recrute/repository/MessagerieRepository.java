package com.recrute.repository;

import com.recrute.model.Messagerie;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface MessagerieRepository extends JpaRepository<Messagerie, Long> {
    List<Messagerie> findByCandidatureId(Long idCandidature);
    List<Messagerie> findByCandidatId(Long idCandidat);
    List<Messagerie> findByRecruteurId(Long idRecruteur);
}