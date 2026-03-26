package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;

import com.recrute.enums.CategorieType;

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
    @org.hibernate.annotations.JdbcTypeCode(org.hibernate.type.SqlTypes.NAMED_ENUM)
    private CategorieType category;

    private String nom;
}