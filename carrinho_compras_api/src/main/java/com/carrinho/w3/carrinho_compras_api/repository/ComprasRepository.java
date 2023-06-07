package com.carrinho.w3.carrinho_compras_api.repository;

import com.carrinho.w3.carrinho_compras_api.model.comprasModel;
import org.springframework.data.jpa.repository.JpaRepository;

import javax.transaction.Transactional;

public interface ComprasRepository extends JpaRepository<comprasModel, Integer> {

    @Transactional
    void deleteByNomeAndValorAndImageUrl(String nome, double valor, String imageUrl);

}
