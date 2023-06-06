package com.carrinho.w3.carrinho_compras_api.services;

import com.carrinho.w3.carrinho_compras_api.model.comprasModel;
import com.carrinho.w3.carrinho_compras_api.repository.ComprasRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ComprasService {

    private final ComprasRepository comprasRepository;

    @Autowired
    public ComprasService(ComprasRepository comprasRepository) {
        this.comprasRepository = comprasRepository;
    }

    public void adicionarItem(comprasModel item) {
        // Lógica para adicionar o item ao banco de dados
        comprasRepository.save(item);
    }

    public void removerItem(comprasModel item) {
        // Lógica para remover o item do banco de dados
        comprasRepository.delete(item);
    }
}
