let currentUserId = 0;
let iconHeader;
let tok = sessionStorage.getItem('token');
var tableUtenti;

setup();

function setup()  {
  //popolaTableUtenti();
  iconHeader = document.getElementById('icon_utente');
  sendRequestGetUtentiList();
}


function popolaTableUtenti(AdataUtenti)  {
  /*let AdataUtenti = [
    {"id": "1", "nome": "Abdul", "cognome": "Asmari", "email": "abdul@unisa.it", "permessi": "Amministratore", "": ""},
    {"id": "2", "nome": "MArio", "cognome": "Rossi", "email": "m.rossi12@unisa.it", "permessi": "Nessun permesso", "": ""},
    {"id": "3", "nome": "Luigi", "cognome": "Gagliardi", "email": "l.gagliardi3@unisa.it", "permessi": "Nessun permesso", "": ""},
    {"id": "4", "nome": "GIGI", "cognome": "BUFFON", "email": "g.buffone@unisa.it", "permessi": "Amministratore", "": ""},
    {"id": "5", "nome": "Gesu'", "cognome": "Bambino", "email": "g.bambino@unisa.it", "permessi": "Amministratore", "": ""}
  ];*/
  

  
  if(tableUtenti != undefined) {
    tableUtenti.destroy;
  }
  tableUtenti = new DataTable('#utentiTable', {
  columns:  [
    {"data": 'id'},
    {"data": 'nome'},
    {"data": 'cognome'},
    {"data": 'email'},
    {"data": 'permessi'},
    {"data": '',
      "render": function ( data, type, row, meta ) {
        return '<button class="btn btn-primary2 modify" type="button" data-bs-toggle="modal" data-bs-target="#utenteModal" onclick="modifyUserData('+ row.id +')"> Modifica </button>'
        + '';
      }},
      {"data": '', 
      "render": function ( data, type, row, meta ) {
          return '<button class="fa fa-trash-o" type="button" onclick="deleteUser('+ row.id +')"></button>'
          + '';
        }}
  ],
  data: AdataUtenti,
  responsive: false,
  "scrollY":"50vh"
  });
}

function popolaDataModale(id)  {
  console.log(id);

  const apiUrl = 'http://192.168.94.109:8080/Utente/GetUtente/' + tok + '/' + id;
  const requestOptions = {
    method: 'GET',  
  };

  let nomeU = document.getElementById('nomeUtenteTI');
  let cognomeU = document.getElementById('cognomeUtenteTI');
  let emailU = document.getElementById('emailUtenteTI');
  let passwordU = document.getElementById('InputUserPasswordTI');
  let permessiU = document.getElementById('permessiUtenteSelect');

  fetch(apiUrl, requestOptions)
      .then(response => response.json()) // Trasforma la risposta in JSON
      .then(data => {
          console.log('Risposta dal server:', data);
          // Puoi gestire la risposta qui
          nomeU.value = data.nome;
          cognomeU.value = data.cognome;
          emailU.value = data.email;
          passwordU.value = data.password;
          permessiU.value = data.permessi;
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });


}

//setta i campi della modale per la modifica dell'utente

//setta i campi per l'aggiunta dell'utente
function setAddDataUserModal()  {
  iconHeader.classList.remove('fa-pencil');
  iconHeader.classList.add('fa-plus');

  document.getElementById('nomeUtenteTI').value = '';
  document.getElementById('cognomeUtenteTI').value = '';
  document.getElementById('emailUtenteTI').value = '';
  document.getElementById('InputUserPasswordTI').value = '';
  document.getElementById('permessiUtenteSelect').value = '';
  currentUserId = 0;
  console.log(currentUserId);
}

function verifyInputs(Anome, Acognome, Aemail, Apassword, Apermessi) {
  let errori = '';
  let numeroErrori = 0;
  var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  var regexSoloLettere = /^[A-Za-z ]+$/;

  if(Anome == '' || !regexSoloLettere.test(Anome)) {
    numeroErrori++;
    errori += 'Il campo "Nome" è vuoto o errato ';
  }
  if(Acognome == '' || !regexSoloLettere.test(Acognome))  {
    if(errori != '')
      errori += ','
    numeroErrori++;
    errori += 'Il campo "Cognome" è vuoto o errato '; 
  }
  if(Aemail == '' || !emailRegex.test(Aemail))  {
    if(errori != '')
      errori += ','
    numeroErrori++;
    errori += 'Il campo "Email" è vuoto oppure non valido ';
  }
  if(Apassword == '' || Apassword.length < 6 || Apassword.length > 20) {
    if(errori != '')
      errori += ','
    numeroErrori++;
    errori += 'Il campo "Password" è vuoto oppure errato ';
  }
  if(Apermessi == ''){
    if(errori != '')
      errori += ','
    numeroErrori++;
    errori += 'Il campo "Permessi" è vuoto.';
  }

  if(numeroErrori > 0)
    return errori;

  else return '';
}

function modifyUserData(AIdUtente) {
    popolaDataModale(AIdUtente);
    iconHeader.classList.remove('fa-plus');
    
    iconHeader.classList.add('fa-pencil');
    currentUserId = AIdUtente;
}

function sendRequestAggiungi()  {
  
  let nome = document.getElementById('nomeUtenteTI').value;
  let cognome = document.getElementById('cognomeUtenteTI').value;
  let email = document.getElementById('emailUtenteTI').value;
  let password = document.getElementById('InputUserPasswordTI').value;
  let permessi = document.getElementById('permessiUtenteSelect').value;

  let error = verifyInputs(nome, cognome, email, password, permessi); 
  var api = 'http://192.168.94.109:8080/Utente/';
  if(error != '')    {
    Swal.fire({
        icon: "warning",
        title: "Oops...",
        text: "Hai lasciato dei campi vuoti!" + error
    });
    return;
  }

  //aggiunta utente
  let apiUrl = '';
  console.log(currentUserId);
  if(currentUserId == 0) { 
    apiUrl = api + 'Aggiungi/' + tok + '/' + nome + '/' + cognome + '/' + email + '/' + password + '/' + permessi;
  } else {
    apiUrl = api + 'Update/' + tok + '/' + nome + '/' + cognome + '/' + email + '/' + password + '/' + permessi + '/' + currentUserId;
  }


    // Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
    const requestOptions = {
        method: 'POST',  
    };

    // Esegui la richiesta fetch
    fetch(apiUrl, requestOptions)
        .then(response => {
            if (response.status === 403) {
                if(currentUserId == 0){
                Swal.fire({
                  title: "Aggiunta utente",
                  text: "Ops! Sembra che non hai i permessi.",
                  icon: "error"
                });
              } else  {
                Swal.fire({
                  title: "Modifica utente",
                  text: "Ops! Sembra che non hai i permessi.",
                  icon: "error"
                });
              }
            throw new Error('Accesso negato. Status code: ' + response.status);
          }

          if (response.status === 400) 
          {
            if(currentUserId == 0){
              Swal.fire({
                title: "Aggiunta utente",
                text: "Ops! Alcuni campi sono errati...",
                icon: "error"
              });
            } else  {
              Swal.fire({
                title: "Modifica utente",
                text: "Alcuni campi sono errati..",
                icon: "error"
              });
            }
            throw new Error('Campi errati. Status code: ' + response.status);
          }

          if (response.status === 500) 
          {
            if(currentUserId == 0){
              Swal.fire({
                title: "Aggiunta utente",
                text: "Utente già esistente. Inserire un'altra email.",
                icon: "error"
              });
            } else  {
              Swal.fire({
                title: "Modifica utente",
                text: "Utente già esistente. Inserire un'altra email.",
                icon: "error"
              });
            }
            throw new Error('Campi errati. Status code: ' + response.status);
          }


          return response.json();
        }) // Trasforma la risposta in JSON
        .then(data => {
            console.log('Risposta dal server:', data);
            // Puoi gestire la risposta qui
            
            if(currentUserId == 0){
              Swal.fire({
                title: "Aggiunta utente",
                text: "Salvataggio effettuato con successo!",
                icon: "success"
              });
              
              $('#utenteModal').modal('hide');
              setTimeout(function() {
                location.reload();
            }, 3000);
              }
              else  {
                Swal.fire({
                  title: "Modifica utente",
                  text: "Salvataggio effettuato con successo!",
                  icon: "success"
                });
                
                $('#utenteModal').modal('hide');
                setTimeout(function() {
                  location.reload();
              }, 3000);
              }
              
        })
        .catch(error => {
            console.error('Errore nella richiesta:', error);
            // Puoi gestire gli errori qui
        });

      }

  function deleteUser(idUser)  {
    const apiUrl = 'http://192.168.94.109:8080/Utente/Remove/' + tok + '/' + idUser;
        const requestOptions = {
          method: 'POST',  
      };
  
      // Esegui la richiesta fetch
      fetch(apiUrl, requestOptions)
          .then(response => {
              if (response.status === 403) {
                  Swal.fire({
                    title: "Elimina utente",
                    text: "Ops! Sembra che non hai i permessi.",
                    icon: "error"
                  });
                
              throw new Error('Accesso negato. Status code: ' + response.status);
            }
            if (response.status === 500) {
              Swal.fire({
                title: "Elimina utente",
                text: "Eliminazione non avvenuta con successo.",
                icon: "error"
              });
            
             throw new Error('Accesso negato. Status code: ' + response.status);
            }
            return response.json();
          }) // Trasforma la risposta in JSON
          .then(data => {
              console.log('Risposta dal server:', data);
              // Puoi gestire la risposta qui
              
              Swal.fire({
                title: "Sei sicuro?",
                text: "Una volta eliminato non si può tornare indietro",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Elimina!"
              }).then((result) => {
                if (result.isConfirmed) {
                  Swal.fire({
                    title: "Eliminato!",
                    text: "L'evento è stato eliminato.",
                    icon: "success"
                  });
            
                  setTimeout(function() {
                    location.reload();
                }, 3000);
                }
              });

          })
          .catch(error => {
              console.error('Errore nella richiesta:', error);
              // Puoi gestire gli errori qui
          });


        }
      




function sendRequestGetUtentiList()  {
  const apiUrl = 'http://192.168.94.109:8080/Utente/GetList/';
  

// Opzioni della richiesta, tra cui il metodo (GET), l'intestazione e il corpo dati
const requestOptions = {
    method: 'GET',  
};

// Esegui la richiesta fetch
fetch(apiUrl, requestOptions)
    .then(response => response.json()) // Trasforma la risposta in JSON
    .then(data => {
        console.log('Risposta dal server:', data);
        // Puoi gestire la risposta qui
        popolaTableUtenti(data);

    })
    .catch(error => {
        console.error('Errore nella richiesta:', error);
        // Puoi gestire gli errori qui
    });
}
