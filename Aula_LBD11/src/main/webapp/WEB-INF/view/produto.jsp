<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Produtos</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp"/>
	</div>
	<br />
	<div align="center">
		<form action="produto" method="post">
			<table>
				<tr>
					<td>
						<input class="id_input_data" type="number" min="0"
							step="1" id="codigo" name="codigo" placeholder="Codigo">
					</td>
					<td>
						<input class="input_data" type="text" 
							 id="nome" name="nome" placeholder="Nome">
					</td>
					<td>
						<input class="input_data" type="text" 
							 id="valor_unitario" name="valor_unitario" placeholder="valor unitario">
					</td>
					<td>
						<input class="input_data" type="text" 
							 id="qtd_estoque" name="qtd_estoque" placeholder="qtd estoque">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Consultar">
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input type="submit" id="botao" name="botao" value="Listar">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro }">
			<H2><c:out value="${erro }" /></H2>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty produtos }">
			<table class="table_round">
				<thead>
					<tr>
						<th>Código</th>
						<th>Nome</th>
						<th>Valor unitário</th>
						<th>Quantidade Estoque</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="prod" items="${produtos }">
						<tr>
							<td><c:out value="${prod.codigo }"/></td>
							<td><c:out value="${prod.nome }"/></td>
							<td><c:out value="${prod.valor_unitario }"/></td>
							<td><c:out value="${prod.qtd_estoque }"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div align="center">
		<c:if test="${not empty produto }">
			<table class="table_round">
				<thead>
					<tr>
						<th>Código</th>
						<th>Nome</th>
						<th>Valor unitário</th>
						<th>Quantidade Estoque</th>
						<th>Situação</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><c:out value="${prod.codigo }"/></td>
						<td><c:out value="${prod.nome }"/></td>
						<td><c:out value="${prod.valor_unitario }"/></td>
						<td><c:out value="${prod.qtd_estoque }"/></td>
						<td><c:out value="${aluno.situacao }"/></td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</div>
</body>
</html>