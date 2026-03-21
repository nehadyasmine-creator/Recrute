package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "competenceoffre")
@Data
public class CompetenceOffre {

    @EmbeddedId
    private CompetenceOffreId id;

    @ManyToOne
    @MapsId("idOffre")
    @JoinColumn(name = "id_offre")
    private Offre offre;

    @ManyToOne
    @MapsId("idCompetence")
    @JoinColumn(name = "id_competence")
    private Competence competence;

    private Boolean obligatoire;
}