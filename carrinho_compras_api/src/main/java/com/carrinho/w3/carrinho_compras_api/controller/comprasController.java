package com.carrinho.w3.carrinho_compras_api.controller;

import com.carrinho.w3.carrinho_compras_api.model.comprasModel;
import com.carrinho.w3.carrinho_compras_api.services.ComprasService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api")
@CrossOrigin("*")
public class comprasController {

    private final ComprasService comprasService;

    public comprasController(ComprasService comprasService) {
        this.comprasService = comprasService;
    }

    @GetMapping("/itens")
    public ResponseEntity<List<comprasModel>> getAllItens() {
        List<comprasModel> comprasModel = comprasService.getAllItens();
        return new ResponseEntity<>(comprasModel, HttpStatus.OK);
    }

    @PostMapping("/adicionaritem")
    public ResponseEntity<String> adicionarItem(@RequestBody comprasModel comprasModel) {
        comprasService.adicionarItem(comprasModel);
        String mensagem = "Item adicionado com sucesso";
        return new ResponseEntity<>(mensagem, HttpStatus.OK);
    }

    @DeleteMapping("/removeritem")
    public ResponseEntity<String> removerItem(@RequestBody comprasModel comprasModel) {
        comprasService.removerItemPorDados(comprasModel.getNome(), comprasModel.getValor(), comprasModel.getImageUrl());
        String mensagem = "Item removido com sucesso";
        return new ResponseEntity<>(mensagem, HttpStatus.OK);
    }
}
