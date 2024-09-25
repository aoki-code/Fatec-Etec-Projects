<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css"/>'>
<title>Funcionarios</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty funcionarios }">
			<table class="table_round">
				<thead>
					<tr>
						<th>Nome Funcionario</th>
						<th>Nome Dependente</th>
						<th>Salario Funcionario</th>
						<th>Salario Dependente</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${funcionarios }" var="f">
						<tr>
							<td><c:out value="${f.nome }"/></td>
							<td><c:out value="${f.dependente.nome_d }"/></td>
							<td><c:out value="${f.salario }"/></td>
							<td><c:out value="${f.dependente.salario_d }"/></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<form action="funcionarios" method="post">
			<table>
				<tr>
					<td>
						<input class="id_input_data" type="number" min="1"
						step="1" id="codigo" name="codigo" placeholder="#Codigo">
					</td>
					<td>
						<input type="submit" id="botao" name="botao" placeholder="Total">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty salarioTotal }">
			<table class="table_round">
				<thead>
					<tr>
						<th>Salario Total</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><c:out value="${salarioTotal }"/></td>
					</tr>
				</tbody>
			</table>
		</c:if>
	</div>
	<br />
	<br />
	<div align="center">
		<c:if test="${not empty erro}">
			<h4><c:out value="${erro}"></c:out></h4>
		</c:if>
	</div>
</body>
</html>