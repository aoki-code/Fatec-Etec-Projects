<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="./css/styles.css">
<title>Viagem</title>
</head>
<body>
	<div align="center" class="container">
		<form action="marca" method="post">
			<p class="title">
				<b>Viagens</b>
			</p>
			
			<table>
				<tr>
					<td colspan="3">
						<input class="id_input_data" type="number" min="0"
							step="1" id="id" name="id" placeholder="#ID"
							value='<c:out value="${viagem.id }"'>
					</td>
					
					<td>
						<input type="submit" id="botao" name="botao" value="Buscar">
					</td>
					
				</tr>
				
				<tr>
					<td colspan="4">
						<input class="input_data" type="text" id="nome" name="nome" placeholder="Nome">
					</td>
				</tr>
			</table>
		</form>
	
	</div>
	
	<br />
	<br />
	
	<div align="center">
		<c:if test="${not empty erro }">
			<h2><c:out value="${erro }" /></h2>
		</c:if>
	</div>
	
	<div align="center">
		<c:if test="${not empty saida }">
			<h3><c:out value="${saida }" /></h3>
		</c:if>
	</div>
</body>
</html>