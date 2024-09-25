<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<meta charset="ISO-8859-1">
<title>Gerar Rodadas</title>
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
		<h3 class=tarefa>Crie as Rodadas</h3>
		<br/>
	</div>
	<div align="center">
		<form action="rodada" method="post">
			<input type="submit" id=gerar_rodada name=gerar_rodada value="Gerar Rodadas">
		</form>
	</div>
	<div align="center">
		<c:if test="${not empty erro}">
			<h4><c:out value="${erro}"></c:out></h4>
		</c:if>
	</div>
	<br />
	<div align="center">
		<c:if test="${not empty saida}">
			<h4><c:out value="${saida}"></c:out></h4>
		</c:if>
	</div>
</header>
</body>
</html>