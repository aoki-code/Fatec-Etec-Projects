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
		<form action="relatorioFalta" method="post">
			<select name="disciplina" id="disciplina">
				<option value="4203-010">Arquitetura e Organiza��o de Computadores - tarde</option>
				<option value="4203-020">Arquitetura e Organiza��o de Computadores - noite</option>
				<option value="4208-010">Laborat�rio de Hardware</option>
				<option value="4226-004">Banco de Dados</option>
				<option value="4213-003">Sistemas Operacionais I - tarde</option>
				<option value="4213-013">Sistemas Operacionais I - noite</option>
				<option value="4233-005">Laborat�rio de Banco de Dados</option>
				<option value="4203-011">M�todos Para a Produ��o do Conhecimento</option>
			</select> <input type="submit" name="enviar" id="enviar" value="Mostrar">
		</form>
	</center>


</body>
</html>