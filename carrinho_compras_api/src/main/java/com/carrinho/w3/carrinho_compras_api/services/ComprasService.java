package com.carrinho.w3.carrinho_compras_api.services;

import com.carrinho.w3.carrinho_compras_api.model.comprasModel;
import com.carrinho.w3.carrinho_compras_api.repository.ComprasRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ComprasService {

    private final ComprasRepository comprasRepository;


    @Autowired
    public ComprasService(ComprasRepository comprasRepository) {
        this.comprasRepository = comprasRepository;
    }

    public List<comprasModel> getAllItens() {
        return comprasRepository.findAll();
    }

    public void adicionarItem(comprasModel item) {
        // Lógica para adicionar o item ao banco de dados
        comprasRepository.save(item);
    }

    public void removerItem(comprasModel item) {
        // Obter o ID do item

        comprasRepository.delete(item);
    }

    public void removerItemPorDados(String nome, Double valor, String imageUrl) {
        comprasRepository.deleteByNomeAndValorAndImageUrl(nome, valor, imageUrl);
    }



}
