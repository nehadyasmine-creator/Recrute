package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "competencecandidat")
@Data
public class CompetenceCandidat {

    @EmbeddedId
    private CompetenceCandidatId id;

    @ManyToOne
    @MapsId("idCandidat")
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    @ManyToOne
    @MapsId("idCompetence")
    @JoinColumn(name = "id_competence")
    private Competence competence;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "niveau_type")
    private NiveauType niveau;

    public enum NiveauType {
        debutant, intermediaire, avance, expert
    }
}