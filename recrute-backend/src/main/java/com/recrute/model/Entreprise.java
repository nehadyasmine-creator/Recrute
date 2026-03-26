package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

import com.recrute.enums.TailleType;

@Entity
@Table(name = "entreprise")
@Data
public class Entreprise {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_entreprise")
    private Long id;

    private String nom;
    private String secteur;

    @Column(name = "siegesocial")
    private String siegeSocial;

    @Column(unique = true, length = 9)
    private String siren;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "taille_type")
    @org.hibernate.annotations.JdbcTypeCode(org.hibernate.type.SqlTypes.NAMED_ENUM)
    private TailleType taille;

    @Column(name = "siteweb")
    private String siteWeb;
}