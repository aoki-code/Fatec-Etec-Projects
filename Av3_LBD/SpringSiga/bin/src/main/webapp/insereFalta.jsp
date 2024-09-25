<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<div>
		<jsp:include page="menu.jsp" />
	</div>
	<br />
	<br />

	<center>
		<form action="mostraFalta" method="post">
			<select name="materias" id="materias">
				<option value="4203-010">Arquitetura e Organização de Computadores - tarde</option>
				<option value="4203-020">Arquitetura e Organização de Computadores - noite</option>
				<option value="4208-010">Laboratório de Hardware</option>
				<option value="4226-004">Banco de Dados</option>
				<option value="4213-003">Sistemas Operacionais I - tarde</option>
				<option value="4213-013">Sistemas Operacionais I - noite</option>
				<option value="4233-005">Laboratório de Banco de Dados</option>
				<option value="4203-011">Métodos Para a Produção do Conhecimento</option>
			</select> 
			
			<input type="date" name="data" id="data"> 
			<input type="submit" name="enviar" id="enviar" value="Mostrar">
		</form>
	</center>


	<!-- retorno do botão -->
	<c:set var="contt" value="1" scope="page">
	</c:set>

	<br>
	<br>
	<div class="container-fluid">
		<form action="insereFalta" method="post">

			<center>Data Escolhida: ${data}</center>

			<table class="table table-striped" border=2>
				<c:set var="cont" value="1" scope="page"></c:set>

				<c:forEach var="aluno" items="${aluno}">

					<tr>
						<c:if test="${contt == 1}">
							<td>Nome</td>
							<td>RA</td>
							<td>Faltas</td>
						</c:if>
					</tr>

					<input type="hidden" name="${cont}" value="${aluno.getRa()}">

					<tr>
						<td>${aluno.getNome()}</td>
						<td>${aluno.getRa()}</td>
						<td><select name="${aluno.getRa()}" id="materias">
								<c:forEach begin="0" end="${aulas}" varStatus="loop">
									<option value="${loop.index}">${loop.index}</option>
								</c:forEach>
						</select></td>
					</tr>
					<c:set var="contt" value="${contt+1}" scope="page" />
					<c:set var="cont" value="${cont+1}" scope="page" />
				</c:forEach>
			</table>
			<input type="hidden" name="tamanho" value="${cont}"> <input
				type="hidden" name="dt" value="${data}"> <input
				type="hidden" name="aula" value="${materia}">
			<center>
				<input type="submit" name="enviar" id="enviar" value="Registrar">
				<center>
		</form>
	</div>

</body>
</html>