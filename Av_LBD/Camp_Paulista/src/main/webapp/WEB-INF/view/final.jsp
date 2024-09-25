<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<meta charset="ISO-8859-1">
<title>Tabelas de Oitavas de Final</title>
</head>
<body>
<header>
	<div align="center">
		<ul>
			<jsp:include page="menu.jsp"></jsp:include>
		</ul>
	</div>
	<br/><br/>
	<div align="center">
		<h1 class=texto>Campeonato Paulista</h1>
			<br/><br/>
			<br/><br/>
		<h3 class=tarefa>Vizualize as classificações.</h3>
	</div>
		<br/>
	<div align="center">
		<form action="finalistas" method="post">
			<input type="submit" id=botao name=botao value="Listar por grupos">
			<input type="submit" id=botao name=botao value="Listar todos">
		</form>
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h4><c:out value="${erro}"></c:out></h4>
		</c:if>
	</div>
	<br/>
	<div align="center">
		<c:if test="${not empty saida}">
			<h4><c:out value="${saida}"></c:out></h4>
		</c:if>
	</div>
	<br />
	<br />
	<div class = "container grid">
		<c:if test="${not empty grupoA }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo A</th>
						<th>Disp</th>
						<th>Vit </th>
						<th>Emp </th>
						<th>Der</th>
						<th>Mar</th>
						<th>Sof </th>
						<th>Sal </th>
						<th>Pont</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoA}" var="s">
					<tr>
						<td><c:out value="${s.nomeTime }"></c:out></td>
						<td align="center"><c:out value="${s.numJogosDisputados }"></c:out></td>
						<td align="center"><c:out value="${s.vitorias }"></c:out></td>
						<td align="center"><c:out value="${s.empates }"></c:out></td>
						<td align="center"><c:out value="${s.derrotas }"></c:out></td>
						<td align="center"><c:out value="${s.golsMarcados }"></c:out></td>
						<td align="center"><c:out value="${s.golsSofridos }"></c:out></td>
						<td align="center"><c:out value="${s.saldoGols }"></c:out></td>
						<td align="center"><c:out value="${s.pontos }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty grupoB }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo B</th>
						<th>Disp</th>
						<th>Vit </th>
						<th>Emp </th>
						<th>Der</th>
						<th>Mar</th>
						<th>Sof </th>
						<th>Sal </th>
						<th>Pont</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoB}" var="s">
					<tr>
						<td><c:out value="${s.nomeTime }"></c:out></td>
						<td align="center"><c:out value="${s.numJogosDisputados }"></c:out></td>
						<td align="center"><c:out value="${s.vitorias }"></c:out></td>
						<td align="center"><c:out value="${s.empates }"></c:out></td>
						<td align="center"><c:out value="${s.derrotas }"></c:out></td>
						<td align="center"><c:out value="${s.golsMarcados }"></c:out></td>
						<td align="center"><c:out value="${s.golsSofridos }"></c:out></td>
						<td align="center"><c:out value="${s.saldoGols }"></c:out></td>
						<td align="center"><c:out value="${s.pontos }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		</div>
		<div class="container grid">
		<c:if test="${not empty grupoC }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo C</th>
						<th>Disp</th>
						<th>Vit </th>
						<th>Emp </th>
						<th>Der</th>
						<th>Mar</th>
						<th>Sof </th>
						<th>Sal </th>
						<th>Pont</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoC}" var="s">
					<tr>
						<td><c:out value="${s.nomeTime }"></c:out></td>
						<td align="center"><c:out value="${s.numJogosDisputados }"></c:out></td>
						<td align="center"><c:out value="${s.vitorias }"></c:out></td>
						<td align="center"><c:out value="${s.empates }"></c:out></td>
						<td align="center"><c:out value="${s.derrotas }"></c:out></td>
						<td align="center"><c:out value="${s.golsMarcados }"></c:out></td>
						<td align="center"><c:out value="${s.golsSofridos }"></c:out></td>
						<td align="center"><c:out value="${s.saldoGols }"></c:out></td>
						<td align="center"><c:out value="${s.pontos }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
		<c:if test="${not empty grupoD }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Grupo D</th>
						<th>Disp</th>
						<th>Vit </th>
						<th>Emp </th>
						<th>Der</th>
						<th>Mar</th>
						<th>Sof </th>
						<th>Sal </th>
						<th>Pont</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${grupoD}" var="s">
					<tr>
						<td><c:out value="${s.nomeTime }"></c:out></td>
						<td align="center"><c:out value="${s.numJogosDisputados }"></c:out></td>
						<td align="center"><c:out value="${s.vitorias }"></c:out></td>
						<td align="center"><c:out value="${s.empates }"></c:out></td>
						<td align="center"><c:out value="${s.derrotas }"></c:out></td>
						<td align="center"><c:out value="${s.golsMarcados }"></c:out></td>
						<td align="center"><c:out value="${s.golsSofridos }"></c:out></td>
						<td align="center"><c:out value="${s.saldoGols }"></c:out></td>
						<td align="center"><c:out value="${s.pontos }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<div align="center">
	<c:if test="${not empty todos }">
			<table class=table_home>
				<thead>
					<tr>
						<th align="left">Campeonato</th>
						<th>Disputados</th>
						<th>Vitorias </th>
						<th>Empates </th>
						<th>Derrotas</th>
						<th>Marcados</th>
						<th>Sofridos</th>
						<th>Saldo </th>
						<th>Pontos</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${todos}" var="s">
					<c:if test="${s.rebaixado == 1}">
					<tr bgcolor="#708090">
							<td><c:out value="${s.nomeTime }"></c:out></td>
							<td align="center"><c:out value="${s.numJogosDisputados }"></c:out></td>
							<td align="center"><c:out value="${s.vitorias }"></c:out></td>
							<td align="center"><c:out value="${s.empates }"></c:out></td>
							<td align="center"><c:out value="${s.derrotas }"></c:out></td>
							<td align="center"><c:out value="${s.golsMarcados }"></c:out></td>
							<td align="center"><c:out value="${s.golsSofridos }"></c:out></td>
							<td align="center"><c:out value="${s.saldoGols }"></c:out></td>
							<td align="center"><c:out value="${s.pontos }"></c:out></td>
					</tr>
					</c:if>
					<c:if test="${s.rebaixado != 1}">
					<tr>
							<td><c:out value="${s.nomeTime }"></c:out></td>
							<td align="center"><c:out value="${s.numJogosDisputados }"></c:out></td>
							<td align="center"><c:out value="${s.vitorias }"></c:out></td>
							<td align="center"><c:out value="${s.empates }"></c:out></td>
							<td align="center"><c:out value="${s.derrotas }"></c:out></td>
							<td align="center"><c:out value="${s.golsMarcados }"></c:out></td>
							<td align="center"><c:out value="${s.golsSofridos }"></c:out></td>
							<td align="center"><c:out value="${s.saldoGols }"></c:out></td>
							<td align="center"><c:out value="${s.pontos }"></c:out></td>
					</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
</header>
</body>
</html>