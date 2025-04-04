package com.example.backendproj.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "headings")
@Data
public class ContentBlock {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", updatable = false, nullable = false)
    private Long id;
    
    @Column(
        name = "heading_text",
        nullable = false,
        length = 500,
        unique = true  
    )
    private String headingText;
    
}