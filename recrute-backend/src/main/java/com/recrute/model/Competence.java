package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "competence")
@Data
public class Competence {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_competence")
    private Long id;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "categorie_competence")
    private CategorieType category;

    private String nom;

    public enum CategorieType {
        technique, soft_skill, langue, autre
    }
}