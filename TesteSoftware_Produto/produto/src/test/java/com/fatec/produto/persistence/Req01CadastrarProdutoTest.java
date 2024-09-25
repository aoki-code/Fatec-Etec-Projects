
package com.fatec.produto.persistence;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.fail;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.fatec.produto.model.Produto;
import com.fatec.produto.model.ProdutoRepository;

@SpringBootTest
class Req01CadastrarProdutoTest {
	
	@Autowired
	ProdutoRepository repository;

	@Test
	void ct01_cadastrar_produto_com_sucesso() {
		//dado que não existe nenhum registro cadastrado
		repository.deleteAll();
		
		//quando o usuario cadastra um produto
		Produto produto = new Produto();
		produto.setDescricao("Eletrobomba 110v para maquina de lavar");
		produto.setCategoria("Maquina de Lavar");
		produto.setCusto(51.66);
		produto.setQuantidadeNoEstoque(10);
		Produto p = repository.save(produto);
		
		//então o produto fica disponivel para consulta
		assertEquals(1, repository.count());
		assertNotNull (p);	
	}
	
	@Test
	void ct02_cadastrar_produto_com_descricao_invalida() {
		try {
			Produto produto = new Produto();
			produto.setDescricao("");
			fail("Deveria disparar uma Exception");
		} catch (IllegalArgumentException e){
			assertEquals("A descrição não pode ficar branco", e.getMessage());
			
		}
		
		
	}

}
