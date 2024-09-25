<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css"
	rel="stylesheet">
	
<link href="https://getbootstrap.com/docs/5.2/assets/css/docs.css"
	rel="stylesheet">
<title>Insert title here</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
		
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
   
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarText" aria-controls="navbarText" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarText">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
      
        <li class="nav-item">
          <a class="nav-link" id=grupo href="http://localhost:8080/SpringSiga/insereNota.jsp">Inserir Notas</a>
        </li>
        
        <li class="nav-item">
          <a class="nav-link" href="http://localhost:8080/SpringSiga/insereFalta.jsp">Inserir Faltas</a>
        </li>
        
   		<li class="nav-item">
        	<a class="nav-link" href="http://localhost:8080/SpringSiga/relatorioFalta.jsp">Gerar Relatório de Faltas</a>
        </li>
        
        <li class="nav-item">
        	<a class="nav-link" href="http://localhost:8080/SpringSiga/relatorioNota.jsp">Gerar Relatório de Notas</a>
        </li>

        
      </ul>
    </div>
  </div>
</nav>

	<br><br><br><br><br>
</body>
</html>