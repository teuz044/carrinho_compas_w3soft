package com.carrinho.w3.carrinho_compras_api.controller;

import com.carrinho.w3.carrinho_compras_api.model.comprasModel;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class comprasController {
    @PostMapping("/adicionaritem")
    public ResponseEntity<String> adicionarItem(@RequestBody comprasModel item) {
        // Lógica para adicionar o item ao banco de dados
        // Aqui você pode usar um serviço ou repositório para lidar com a persistência

        // Exemplo de resposta simples
        String mensagem = "Item adicionado com sucesso";
        return new ResponseEntity<>(mensagem, HttpStatus.OK);
    }

    @PostMapping("/removeritem")
    public ResponseEntity<String> removerItem(@RequestBody comprasModel item) {
        // Lógica para remover o item do banco de dados
        // Aqui você pode usar um serviço ou repositório para lidar com a remoção

        // Exemplo de resposta simples
        String mensagem = "Item removido com sucesso";
        return new ResponseEntity<>(mensagem, HttpStatus.OK);
    }
}
