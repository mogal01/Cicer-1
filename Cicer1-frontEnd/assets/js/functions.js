setup();
document.addEventListener('DOMContentLoaded', function() {
  setTimeout(function () {
      document.getElementById("loading-screen").style.display = "none";
      document.getElementById("main-content").style.display = "block";
  }, 2000); // 2000 millisecondi (2 secondi) di ritardo simulato, cambialo secondo le tue esigenze
});


function setup()  {
  setUserData();
}

function sendLoginRequestServer()    {
    let email = document.getElementById('InputUtenteEmailTI').value;
    let password = document.getElementById('InputUserPasswordTI').value;

    const apiUrlLog = 'http://192.168.216.109:8080/Login/' + email + '/' + password;
    fetch(apiUrlLog, {
    method: 'POST'    
    })
    .then(response => {

    if (response.status === 403) 
    {
      Swal.fire({
        title: "Login",
        text: "Ops! Sembra che le credenziali sono errate",
        icon: "error"
      });
      
      throw new Error('Campi errati. Status code: ' + response.status);
    }



    return response.json();
  })
    .then(data => {
        if(data.token != null)  {
          sessionStorage.setItem('token', data.token);
          window.location.href = './dashboard.html';
        }
      })
    .catch(error => console.error('Error:', error));

    return false;
}

function showModifyPasswordToggle() {
    let inputPassword = document.getElementById('InputUserPasswordTI');
    let icon = document.getElementById('toggleEyePass');
    
    if (inputPassword.type === "password") {
        // Cambia il tipo di input da "password" a "text"
        inputPassword.type = "text";
        icon.classList.remove('fa-eye');
        icon.classList.add('fa-eye-slash');
      } else {
        // Se il tipo di input non è "password", imposta il tipo di input a "password"
        inputPassword.type = "password";
        icon.classList.remove('fa-eye-slash');
        icon.classList.add('fa-eye');
      }
}

function logOut() {
  let tokk = sessionStorage.getItem('token');
  const apiUrlLogOut = 'http://192.168.216.109:8080/LogOut/' + tokk;
    fetch(apiUrlLogOut, {
    method: 'POST'    
    })
    .then(response => response.json())
    .then(data => {
          sessionStorage.removeItem('token');
          window.location.href = 'index.html';
      })
    .catch(error => console.error('Error:', error));
}

function setUserData()  {
  let tokk = sessionStorage.getItem('token');
  const apiUrl = 'http://192.168.216.109:8080/Utente/GetProfilo/' + tokk;
  const requestOptions = {
    method: 'GET',  
  };

  let span = document.getElementById('spanEmailUser');
  let email = document.getElementById('emailUtenteHeader');
  let nome = document.getElementById('nomeUtenteHeader');
  let cognome = document.getElementById('cognomeUtenteHeader');
  let permessi = document.getElementById('permessiUtenteHeader');

  fetch(apiUrl, requestOptions)
      .then(response => response.json()) // Trasforma la risposta in JSON
      .then(data => {
          console.log('Risposta dal server:', data);
          // Puoi gestire la risposta qui
          span.textContent = data.nome + " " + data.cognome;
          nome.textContent = data.nome;
          cognome.textContent = data.cognome;
          email.textContent = data.email;
          permessi.textContent = data.permessi;
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });

}