package com.recrute.controller;

import com.recrute.model.ContactMessage;
import com.recrute.service.ContactMessageService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;

import java.util.List;

@RestController
@RequestMapping("/contacts")
@RequiredArgsConstructor
public class ContactMessageController {

    private final ContactMessageService contactMessageService;

    @GetMapping
    public List<ContactMessage> getAll() {
        return contactMessageService.getAll();
    }

    @PostMapping
    public ContactMessage create(@RequestBody ContactMessage contactMessage) {
        return contactMessageService.create(contactMessage);
    }

    @PutMapping("/{id}/statut")
    public ContactMessage markAsTraite(@PathVariable Long id) {
        return contactMessageService.markAsTraite(id);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        contactMessageService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
