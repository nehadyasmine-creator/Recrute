package com.recrute.dto;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;

@Data
public class OffreDTO {
    private Long idRecruteur;
    private String titre;
    private String description;
    private String lieu;
    private String typeContrat;
    private BigDecimal salaire;
    private String duree;
    private Integer experienceRequise;
    private LocalDate dateDebut;
    private LocalDate datePublication;
    private Boolean teletravail;
    private String statut;
}
