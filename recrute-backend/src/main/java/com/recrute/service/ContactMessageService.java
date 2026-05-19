package com.recrute.service;

import com.recrute.model.ContactMessage;
import com.recrute.repository.ContactMessageRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import org.springframework.http.HttpStatus;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ContactMessageService {

    private final ContactMessageRepository contactMessageRepository;

    public List<ContactMessage> getAll() {
        return contactMessageRepository.findAll();
    }

    public ContactMessage create(ContactMessage contactMessage) {
        if (contactMessage.getDateCreation() == null) {
            contactMessage.setDateCreation(LocalDateTime.now());
        }
        if (contactMessage.getStatut() == null || contactMessage.getStatut().isBlank()) {
            contactMessage.setStatut("ouvert");
        }
        return contactMessageRepository.save(contactMessage);
    }

    public ContactMessage markAsTraite(Long id) {
        ContactMessage contactMessage = contactMessageRepository.findById(id)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND, "Message introuvable"));
        contactMessage.setStatut("traite");
        return contactMessageRepository.save(contactMessage);
    }

    public void delete(Long id) {
        if (!contactMessageRepository.existsById(id)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Message introuvable");
        }
        contactMessageRepository.deleteById(id);
    }
}
