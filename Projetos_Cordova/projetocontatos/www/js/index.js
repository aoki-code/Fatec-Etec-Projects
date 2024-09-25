let app = {
	
	contatoSelecionado : null,
	
	inicializar: function(){
		console.log("Inicializar: function(){...");
		document.addEventListener('deviceready', app.onMyDeviceReady, false);
		document.addEventListener('onResume', app.retornoAoPrimeiroPlano, false);
		},
		
		onMyDeviceReady: function(){
			console.log('#####=> Running cordova-' + cordova.pltformId + '@' + cordova.version);
			document.getElementById("btnSelecionaContato").addEventListener('click', app.selecionarContato);
		},
		
		retornoAoPrimeiroPlano:function(){
			console.log("retornoAoPrimeiroPlano:function(){...");
		},
			
		selecionarContato: function(){
			console.log("selecionarContato : function(){...");
			navigator.contacts.pickContact(function(c){
				console.log("####=> Contato Selecionado");
				console.log(c);
				app.contatoSelecionado = c;
				console.log(c.displayName);
				let spanElement = document.getElementById("nomeDoContato").innerHTML = c.displayName;
				console.log(spanElement);
				
				console.log(c.photos);
				let imgElement = document.getElementById("imgDoContato");
				console.log("Tag Imagem...");
				console.log(imgElement);
				console.log("Value do Obj Imagem do array photos");
				console.log(c.photo[0].value);
				
				imgElement.src = c.photos[0].value;
				
			},function(err){
				console.log("####=> Contato nao selecionado");
				console.log(err);
			});
	}
		
		
}

app.inicializar();
    
	
	
	

	
	
	
	
	
	
	
	
	
	