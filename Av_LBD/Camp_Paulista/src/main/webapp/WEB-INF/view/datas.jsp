<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<meta charset="ISO-8859-1">
<title>Datas da Rodada</title>
</head>
<body>
<header>
	<div align="center">
		<jsp:include page="menu.jsp"></jsp:include>
	</div>
	<br/><br/>
	<div align="center">
		<h1 class=texto>Campeonato Paulista</h1>
			<br/><br/>
			<br/><br/>
		<h3 class=tarefa>Insira uma data ou atualize a pontuação</h3>
		<br/>
	</div>
	<div align="center">
		<form action="datas" method="post">
			<input type="date" id=data_rodada name=data_rodada required="required">
			<input type="submit" id=botao name=botao value="Pesquisar">
			<input type="submit" id=botao name=botao value="Pontuar">
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
	<div align="center">
		<c:if test="${not empty rodada }">
			<table class=table_home>
				<thead>
					<tr>
						<th>Time A</th>
						<th>Time B</th>
						<th>Gols A </th>
						<th>Gols B </th>
						<th>Data</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${rodada}" var="r">
					<tr>
						<td align="center"><c:out value="${r.timeA.nomeTime } "></c:out></td>
						<td align="center"><c:out value="${r.timeB.nomeTime } "></c:out></td>
						<td align="center"><c:out value="${r.golsTimeA }  "></c:out></td>
						<td align="center"><c:out value="${r.golsTimeB }  "></c:out></td>
						<td align="center"><c:out value="${r.dataJogo }"></c:out></td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:if>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty pontuacao }">
		<form action="datas" method="post">
			<table class=table_home>
				<thead>
					<tr>
						<th>Time A</th>
						<th>Time B</th>
						<th>Gols A </th>
						<th>Gols B </th>
						<th>Data</th>
					</tr>
				</thead>
				<tbody>	
				<c:forEach items="${pontuacao}" var="r">
					<tr>
						<td align="center"><c:out value="${r.timeA.nomeTime } "></c:out></td>
						<td align="center"><c:out value="${r.timeB.nomeTime } "></c:out></td>
						<td><input type="number" id="${r.timeA.codTime }" name="${r.timeA.codTime }" /></td>
						<td><input type="number" id="${r.timeB.codTime }" name="${r.timeB.codTime }" /></td>
						<td align="center"><c:out value="${r.dataJogo }"></c:out></td>
					</tr>
				</c:forEach>
				<br/><br/>
				<td><input type="submit" id=botao name=botao value="Atualizar" /></td>
				</tbody>
			</table>
			</form>
		</c:if>
	</div>
</header>
</body>
</html>