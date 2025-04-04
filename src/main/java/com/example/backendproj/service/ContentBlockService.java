package com.example.backendproj.service;

import com.example.backendproj.model.ContentBlock;
import com.example.backendproj.repository.ContentBlockRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContentBlockService {

    @Autowired
    private ContentBlockRepository contentBlockRepository;

    // Get all content blocks
    public List<ContentBlock> getAllContentBlocks() {
        return contentBlockRepository.findAll();
    }

    // Get first content block (or null if empty)
    public ContentBlock getFirstContentBlock() {
        List<ContentBlock> blocks = contentBlockRepository.findAll();
        return blocks.isEmpty() ? null : blocks.get(0);
    }

    // Save or update content block
    public ContentBlock saveContentBlock(ContentBlock contentBlock) {
        // If a content block exists, update it instead of creating new
        List<ContentBlock> existingBlocks = contentBlockRepository.findAll();
        if (!existingBlocks.isEmpty()) {
            contentBlock.setId(existingBlocks.get(0).getId());
        }
        return contentBlockRepository.save(contentBlock);
    }

    // Get content block by ID
    public ContentBlock getContentBlockById(Long id) {
        return contentBlockRepository.findById(id).orElse(null);
    }

    // Delete content block
    public void deleteContentBlock(Long id) {
        contentBlockRepository.deleteById(id);
    }
}