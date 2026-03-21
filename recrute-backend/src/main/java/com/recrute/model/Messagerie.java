package com.recrute.model;

import jakarta.persistence.*;
import lombok.Data;
import java.time.LocalDateTime;

@Entity
@Table(name = "messagerie")
@Data
public class Messagerie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_messagerie")
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_candidature")
    private Candidature candidature;

    @ManyToOne
    @JoinColumn(name = "id_recruteur")
    private Recruteur recruteur;

    @ManyToOne
    @JoinColumn(name = "id_candidat")
    private Candidat candidat;

    private String message;

    @Column(name = "sendat")
    private LocalDateTime sendAt;

    private Boolean lu;
}