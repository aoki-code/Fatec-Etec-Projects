<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" type="text/css" href='<c:url value="./resources/css/styles.css" />'>
<title>Relatórios</title>
</head>
<body>
	<div align="center">
		<form action="relatorio" method="post" target="_blank">
			<table border="1">
				<tr>
					<td colspan="4"><input class="id_med" type="number" min="1" step="1" id="mid" name="mid" placeholder="#Id Medico"
					value='<c:out value="${medico.id }"></c:out>'>
			    </tr>
			    <tr>
					<td colspan="4"><input class="id_pac" type="number" min="1" step="1" id="pid" name="pid" placeholder="#Id Paciente"
					value='<c:out value="${paciente.id }"></c:out>'>
				</tr>
				<tr>
				    <td colspan="4"><input class="id_cid" type="number" min="1" step="1" id="cid" name="cid" placeholder="#CID"
				    value='<c:out value="${medico_paciente.cid }"></c:out>'>
				</tr>
				<tr>
					<td colspan="4"><input class="id_trat" type="text" id="trat" name="tratamento" placeholder="#Tratamento"
					value='<c:out value="${medico_paciente.tratamento }"></c:out>'>
				</tr>
				<tr>
					<td><input type="submit" id="btins" name="btins" value="inserir"></td>
					<td><input type="submit" id="btger" name="btger" value="relatorio"></td>
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
</body>
</html>