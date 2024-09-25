
document.addEventListener('deviceready', onDeviceReady, false);

function onDeviceReady() {


    console.log('Running cordova-' + cordova.platformId + '@' + cordova.version);
    navigator.geolocation.getCurrentPosition(
	    sucessoGeolocalizacao,
		erroGeolocalizacao
	);
}
function sucessoGeolocalizacao(position){
	let inputlat = document.getElementById("lat");
	let inputlgn = document.getElementById("lgn");
	
	inputlat.value = position.coords.latitude;
	inputlgn.value = position.coords.longitude;
};
function erroGeolocalizacao(err){
	console.log(err)

};