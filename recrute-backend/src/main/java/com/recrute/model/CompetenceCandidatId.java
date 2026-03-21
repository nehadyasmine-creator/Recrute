package com.recrute.model;

import jakarta.persistence.Embeddable;
import lombok.Data;
import java.io.Serializable;

@Embeddable
@Data
public class CompetenceCandidatId implements Serializable {
    private Long idCandidat;
    private Long idCompetence;
}