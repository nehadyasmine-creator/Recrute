package com.recrute.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@Service
public class FileStorageService {

    @Value("${file.upload-dir:uploads/cv}")
    private String cvUploadDir;

    @Value("${file.upload-pdp-dir:uploads/pdp}")
    private String pdpUploadDir;

    public String saveFile(MultipartFile file) throws IOException {
        return saveFileInDirectory(file, cvUploadDir);
    }

    public String savePdpFile(MultipartFile file) throws IOException {
        return saveFileInDirectory(file, pdpUploadDir);
    }

    public byte[] loadFile(String fileName) throws IOException {
        Path filePath = Paths.get(cvUploadDir).resolve(fileName);
        return Files.readAllBytes(filePath);
    }

    public byte[] loadPdpFile(String fileName) throws IOException {
        Path filePath = Paths.get(pdpUploadDir).resolve(fileName);
        return Files.readAllBytes(filePath);
    }

    public void deleteFile(String fileName) throws IOException {
        Path filePath = Paths.get(cvUploadDir).resolve(fileName);
        Files.deleteIfExists(filePath);
    }

    public void deletePdpFile(String fileName) throws IOException {
        Path filePath = Paths.get(pdpUploadDir).resolve(fileName);
        Files.deleteIfExists(filePath);
    }

    private String saveFileInDirectory(MultipartFile file, String targetDirectory) throws IOException {
        Path uploadPath = Paths.get(targetDirectory);

        if (!Files.exists(uploadPath)) {
            Files.createDirectories(uploadPath);
        }

        String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
        Path filePath = uploadPath.resolve(fileName);
        Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

        return fileName;
    }
}