<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css"> 
<title>Produto</title>
</head>
<body>

	<div align="center" class="container">
		<form action="produto" method="post">
			<p class="title">
				<b>Menu</b>
			</p>
			<table>
				<tr>
					<td colspan="3">
						<input class="input_data_id" type="number" min="0"
						step="1" id="codigo" name="codigo" placeholder="Codigo"
						value='<c:out value= "${produto.codigo }" />'>
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Buscar">
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="text" id="nome" name="nome" placeholder="Nome"
						value='<c:out value= "${produto.nome }" />'>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="number" min="0" step="0.01" id="valor_unitario" name="valor_unitario" 
						placeholder="Valor Unitário" value='<c:out value= "${produto.valor_unitario }" />'>
					</td>
				</tr>
				<tr>
					<td colspan="4">
						<input class="input_data" type="number" min="0" step="0.01" id="qnt_estoque" name="qnt_estoque" 
						placeholder="Qnt Estoque" value='<c:out value= "${produto.qnt_estoque }" />'>
					</td>
				<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Inserir">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Atualizar">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Excluir">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Listar">
					</td>
				</tr>
			</table>
		</form>
	</div>

</body>
</html>