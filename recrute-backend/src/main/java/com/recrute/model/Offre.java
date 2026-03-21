package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;
import java.math.BigDecimal;

@Entity
@Table(name = "offre")
@Data
public class Offre {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_offre")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_recruteur")
    private Recruteur recruteur;

    private String titre;
    private String description;
    private String lieu;

    @Enumerated(EnumType.STRING)
    @Column(name = "type_contrat", columnDefinition = "contrat_type")
    private Candidat.ContratType typeContrat;

    private BigDecimal salaire;
    private String duree;

    @Column(name = "experience_requise")
    private Integer experienceRequise;

    @Column(name = "date_debut")
    private LocalDate dateDebut;

    @Column(name = "date_publication")
    private LocalDate datePublication;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "statut_offre")
    private StatutOffre statut;

    private Boolean teletravail;

    public enum StatutOffre {
        ouverte, fermee
    }
}