package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

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
    private TailleType taille;

    private String siteWeb;

    public enum TailleType {
        startup, pme, eti, grand_groupe
    }
}