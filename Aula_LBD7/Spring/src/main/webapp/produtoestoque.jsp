<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Produto Estoque</title>
</head>
<body>

	<div align="center" class="container">
		<form action="estoque" method="post">
			<p class="title">
				<b>Menu</b>
			</p>
			<table>
				<tr>
					<td colspan="3">
						<input class="input_data_id" type="number" min="0"
						step="1" id="codigo" name="codigo" placeholder="Minimo">
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" id="botao" name="botao" value="Qnt">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" value="Listar">
					</td>
				</tr>
			</table>
		</form>
	</div>

	<div align="center">
		<c:if test= "${not empty erro} ">
			<h2><c:out value= "${erro}" /></h2>
		</c:if>
	</div>
	<div align="center">
		<c:if test= "${not empty saida} ">
			<h3><c:out value= "${saida}" /></h3>
		</c:if>
	</div>

	<div align="center">
		<c:if test="${not empty produtos }">
			<c:forEach items="${produtos } " var="p">
				<c:if test="${p.qnt_estoque < qntForaEstoque }">
					<table class="table_round">
						<thead>
							<tr>
								<th><b>Codigo</b></th>
								<th><b>Nome</b></th>
								<th><b>Qnt Estoque</b></th>
							</tr>				
						</thead>		
					</table>
					<tbody>
						<tr>
							<td><c:out value= "${p.codigo }" /></td>
							<td><c:out value= "${p.nome }" /></td>
							<td><c:out value= "${p.qnt_estoque }" /></td>
						</tr>
					</tbody>
				</c:if>
			</c:forEach>	
		</c:if>
	</div>

</body>
</html>