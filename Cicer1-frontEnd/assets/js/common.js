document.addEventListener('DOMContentLoaded', function() {
    setTimeout(function () {
        document.getElementById("loading-screen").style.display = "none";
        document.getElementById("main-content").style.display = "block";
    }, 2000); // 2000 millisecondi (2 secondi) di ritardo simulato, cambialo secondo le tue esigenze
  });