package com.carrinho.w3.carrinho_compras_api.repository;

import com.carrinho.w3.carrinho_compras_api.model.comprasModel;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ComprasRepository extends JpaRepository<comprasModel, Integer> {
}
