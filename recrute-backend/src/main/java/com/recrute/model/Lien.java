package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "lien")
@Data
public class Lien {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_lien")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    private String nom;

    @Column(name = "url_lien")
    private String urlLien;
}