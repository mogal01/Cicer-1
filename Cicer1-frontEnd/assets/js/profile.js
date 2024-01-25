
setUserData();

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