package com.recrute.model;

import jakarta.persistence.Embeddable;
import lombok.Data;
import java.io.Serializable;

@Embeddable
@Data
public class CompetenceOffreId implements Serializable {
    private Long idOffre;
    private Long idCompetence;
}