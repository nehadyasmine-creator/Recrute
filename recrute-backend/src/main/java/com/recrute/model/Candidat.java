package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

import com.recrute.enums.ContratType;

@Entity
@Table(name = "candidat")
@Data
public class Candidat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_candidat")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_utilisateur")
    private Utilisateur utilisateur;

    @Enumerated(EnumType.STRING)
    @Column(name = "typecontrat", columnDefinition = "contrat_type")
    @org.hibernate.annotations.JdbcTypeCode(org.hibernate.type.SqlTypes.NAMED_ENUM)
    private ContratType typeContrat;

    private String ville;
    private LocalDate disponibilite;
    private String cv;
}