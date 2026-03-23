package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.math.BigDecimal;

@Entity
@Table(name = "candidature")
@Data
public class Candidature {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_candidature")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    @ManyToOne
    @JoinColumn(name = "id_offre")
    private Offre offre;

    @Column(name = "score_matching")
    private BigDecimal scoreMatching;

    @Column(name = "date_candidature")
    private LocalDate dateCandidature;

    @Column(name = "lettre_motivation")
    private String lettreMotivation;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "statut_candidature")
    @org.hibernate.annotations.JdbcTypeCode(org.hibernate.type.SqlTypes.NAMED_ENUM)
    private StatutCandidature statut;

    public enum StatutCandidature {
        envoyee, en_attente, refusee, acceptee
    }
}