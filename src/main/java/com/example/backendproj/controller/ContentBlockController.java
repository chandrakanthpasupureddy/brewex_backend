package com.example.backendproj.controller;

import com.example.backendproj.model.ContentBlock;
import com.example.backendproj.service.ContentBlockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/content-blocks")
@CrossOrigin(origins = "http://localhost:3000")
public class ContentBlockController {

    @Autowired
    private ContentBlockService contentBlockService;

    @GetMapping
    public ResponseEntity<ContentBlock> getContentBlock() {
        ContentBlock contentBlock = contentBlockService.getFirstContentBlock();
        if (contentBlock == null) {
            contentBlock = new ContentBlock();
            contentBlock.setHeadingText("Welcome to Our Platform");
            contentBlock = contentBlockService.saveContentBlock(contentBlock);
        }
        return ResponseEntity.ok(contentBlock);
    }

    @PostMapping
    public ResponseEntity<ContentBlock> updateContentBlock(@RequestBody ContentBlock contentBlock) {
        if (contentBlock == null || contentBlock.getHeadingText() == null || contentBlock.getHeadingText().trim().isEmpty()) {
            return ResponseEntity.badRequest().build();
        }
        
        ContentBlock savedContentBlock = contentBlockService.saveContentBlock(contentBlock);
        return ResponseEntity.ok(savedContentBlock);
    }
}