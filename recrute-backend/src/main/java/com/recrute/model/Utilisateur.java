package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDate;

@Entity
@Table(name = "utilisateur")
@Data
public class Utilisateur {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_utilisateur")
    private Long id;

    private String nom;
    private String prenom;

    @Column(unique = true, nullable = false)
    private String email;

    private String telephone;

    @Column(name = "motdepasse", nullable = false)
    private String motDePasse;

    @Enumerated(EnumType.STRING)
    @Column(columnDefinition = "role_type")
    @org.hibernate.annotations.JdbcTypeCode(org.hibernate.type.SqlTypes.NAMED_ENUM)
    private RoleType role;

    @Column(name = "datecreation")
    private LocalDate dateCreation;

    public enum RoleType {
        candidat, recruteur, admin
    }
}