package com.carrinho.w3.carrinho_compras_api.model;

import javax.persistence.*;

@Entity

@Table(name = "itens")
public class comprasModel {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE)
    @Column(name = "id", nullable = false)
    private Long id;

    private String nome;
    private double valor;
    private String imageUrl;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public comprasModel() {
    }

    public comprasModel(String nome, double valor, String imageUrl) {
        this.nome = nome;
        this.valor = valor;
        this.imageUrl = imageUrl;
    }

    // Getters e Setters

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}