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
		<form action="insereNota" method="post">
			<select name="materias" id="materias">
				<option value="4203-010">Arquitetura e Organização de
					Computadores - tarde</option>
				<option value="4203-020">Arquitetura e Organização de
					Computadores - noite</option>
				<option value="4208-010">Laboratório de Hardware</option>
				<option value="4226-004">Banco de Dados</option>
				<option value="4213-003">Sistemas Operacionais I - tarde</option>
				<option value="4213-013">Sistemas Operacionais I - noite</option>
				<option value="4233-005">Laboratório de Banco de Dados</option>
				<option value="4203-011">Métodos Para a Produção do
					Conhecimento</option>
			</select> <input type="submit" name="enviar" id="enviar" value="Mostrar">
		</form>
	</center>

	<br>
	<br>

	<div class="container-fluid">
		<form action="registraNota" method="post">
			<table class="table table-striped" border=2>

				<c:set var="contt" value="1" scope="page">
				</c:set>

				<tr align="center">

					<c:forEach var="materia" items="${materia}">
						<c:if test="${contt == 1}">
							<td>nome</td>
						</c:if>

						<td>${materia.getTipo()}</td>

						<c:set var="contt" value="${contt+1}" scope="page" />
					</c:forEach>

					<c:if test="${contt > 1}">
						<td>exame</td>
					</c:if>

				</tr>


				<c:set var="contA" value="1" scope="page">
				</c:set>
				<c:set var="contM" value="2000" scope="page">
				</c:set>
				<c:set var="contN" value="4000" scope="page">
				</c:set>
				<c:set var="contJ" value="1" scope="page">
				</c:set>



				<c:forEach var="aluno" items="${aluno}">
					<input type="hidden" id="ra" name="${contA}"
						value="${aluno.getRa()}">

					<tr align="center">
						<td>${aluno.getNome()}</td>

						<c:set var="contJ" value="1" scope="page">
						</c:set>

						<c:forEach var="materia" items="${materia}">
							<input type="hidden" id="codigoAv" name="${contM}"
								value="${materia.getCodigo()}">
							<td><input type="number" id="materia" name="${contN}"></td>

							<c:set var="contM" value="${contM+1}" scope="page" />
							<c:set var="contN" value="${contN+1}" scope="page" />
							<c:set var="contJ" value="${contJ+1}" scope="page" />
						</c:forEach>

						<input type="hidden" id="codigoAv" name="${contM}" value="125">
						<td><input type="number" id="materia" name="${contN}"></td>

					</tr>
					<c:set var="contM" value="${contM+1}" scope="page" />
					<c:set var="contN" value="${contN+1}" scope="page" />


					<c:set var="contA" value="${contA+1}" scope="page" />
				</c:forEach>

				<input type="hidden" id="ra" name="tamanho" value="${contA}">
				<input type="hidden" id="ra" name="jTamanho" value="${contJ}">

			</table>
			<br>
			<center>
				<input type="submit" name="enviar" id="inviar" value="registrar">
			</center>
		</form>
	</div>

</body>
</html>