let currentResponsabileId = 0;
var tableResponsabile;
let token = sessionStorage.getItem('token');

setup();

function setup()  {
  //popolaTable();
  iconHeader = document.getElementById('icon_utente');
  sendRequestGetResponsabileList();
  populateNommiUfficiSelect();
}


function popolaTableResponsabile(AdataResponsabile)  {
  console.log('mannagg');
  /*let AdataResponsabile = [
    {
      "id": 1,
      "nome": "Mario",
      "cognome": "Rossi",
      "Inizio ricevimento": "09:00",
      "Fine ricevimento": "10:00",
      "Destinazione": "Ufficio 101",
      "" : ""
    },
    {
      "id": 2,
      "nome": "Laura",
      "cognome": "Bianchi",
      "Inizio ricevimento": "10:30",
      "Fine ricevimento": "11:30",
      "Destinazione": "Ufficio 202",
      "" : ""
    },
    {
      "id": 3,
      "nome": "Luca",
      "cognome": "Verdi",
      "Inizio ricevimento": "12:00",
      "Fine ricevimento": "13:00",
      "Destinazione": "Ufficio 303",
      "" : ""
    },
    {
      "id": 4,
      "nome": "Giulia",
      "cognome": "Gialli",
      "Inizio ricevimento": "14:00",
      "Fine ricevimento": "15:00",
      "Destinazione": "Ufficio 404",
      "" : ""
    },
    {
      "id": 5,
      "nome": "Andrea",
      "cognome": "Azzurri",
      "Inizio ricevimento": "15:30",
      "Fine ricevimento": "16:30",
      "Destinazione": "Ufficio 505",
      "" : ""
    },
    {
      "id": 6,
      "nome": "Elena",
      "cognome": "Neri",
      "Inizio ricevimento": "17:00",
      "Fine ricevimento": "18:00",
      "Destinazione": "Ufficio 606",
      "" : ""
    },
    {
      "id": 7,
      "nome": "Roberto",
      "cognome": "Rosa",
      "Inizio ricevimento": "09:00",
      "Fine ricevimento": "10:00",
      "Destinazione": "Ufficio 707",
      "" : ""
    },
    {
      "id": 8,
      "nome": "Francesca",
      "cognome": "Gialli",
      "Inizio ricevimento": "10:30",
      "Fine ricevimento": "11:30",
      "Destinazione": "Ufficio 808",
      "" : ""
    },
    {
      "id": 9,
      "nome": "Marco",
      "cognome": "Verdi",
      "Inizio ricevimento": "12:00",
      "Fine ricevimento": "13:00",
      "Destinazione": "Ufficio 909",
      "" : ""
    },
    {
      "id": 10,
      "nome": "Simona",
      "cognome": "Bianchi",
      "Inizio ricevimento": "14:00",
      "Fine ricevimento": "15:00",
      "Destinazione": "Ufficio 1010",
      "" : ""
    }
  ]*/
  
  
  if(tableResponsabile != undefined)  {
    tableResponsabile.destroy;  
  }

  console.log(tableResponsabile);
  tableResponsabile = new DataTable('#responsabiliTable', {
  columns:  [
    {"data": 'id'},
    {"data": 'nome'},
    {"data": 'cognome'},
    {"data": 'orario_inizio_ricevimento'},
    {"data": 'orario_fine_ricevimento'},
    {"data": 'destinazione'},
    {"data": '',
      "render": function ( data, type, row, meta ) {
        return '<button class="btn btn-primary2 modify" type="button" data-bs-toggle="modal" data-bs-target="#responsabileModal" onclick=" modifyResponsabileData('+ row.id +')"> Modifica </button>'
        + '';
      }},
      {"data": '', 
      "render": function ( data, type, row, meta ) {
          return '<button class="fa fa-trash-o" onclick="deleteResponsabile('+ row.id +')"></button>'
          + '';
        }}
  ],
  data: AdataResponsabile,
  responsive: false,
  "scrollY":"50vh"
  });
}


//setta i campi della modale per la modifica dell'utente
function popolaDataModal(AIdResponsabile) {
  let nomeResponsabile1 = document.getElementById('nomeResponsabileTI');
  let cognomeResponsabile1 = document.getElementById('cognomeResponsabileTI');
  let oraInizioRicevimento1 = document.getElementById('fieldTimestampTime-oraInizioRicevimento');
  let oraFineRicevimento1 = document.getElementById('fieldTimestampTime-oraFineRicevimento');
  const apiUrlResponsabiliRequest = 'http://192.168.94.109:8080/Responsabile/GetResponsabile/' + AIdResponsabile;

  const requestOptionResp = {
    method: 'GET',
  };

    // Esegui la richiesta fetch
    fetch(apiUrlResponsabiliRequest, requestOptionResp)
    .then(response => response.json()) // Trasforma la risposta in JSON
    .then(data => {
        console.log('Risposta dal server:', data);
        // Puoi gestire la risposta qui
        nomeResponsabile1.value = data.nome;
        cognomeResponsabile1.value = data.cognome;
        oraInizioRicevimento1.value = data.orario_inizio_ricevimento;
        oraFineRicevimento1.value = data.orario_fine_ricevimento;
    })
    .catch(error => {
        console.error('Errore nella richiesta:', error);
        // Puoi gestire gli errori qui
    });
}

function modifyResponsabileData(AIdEvent)  {
  popolaDataModal(AIdEvent);
  iconHeader.classList.remove('fa-plus');
  iconHeader.classList.add('fa-pencil');
  currentEventId = AIdEvent;
}

//setta i campi per l'aggiunta dell'utente
function setAddDataResponsabileModal()  {
  iconHeader.classList.remove('fa-pencil');
  iconHeader.classList.add('fa-plus');

  iconHeader.classList.add('fa-pencil');
  document.getElementById('nomeResponsabileTI').value = '';
  document.getElementById('cognomeResponsabileTI').value = '';
  document.getElementById('fieldTimestampTime-oraInizioRicevimento').value = '';
  document.getElementById('fieldTimestampTime-oraFineRicevimento').value = '';
  currentResponsabileId = 0;
}

function isOraMaggiore(ora1, ora2) {
    const [ore1, minuti1] = ora1.split(':').map(Number);
    const [ore2, minuti2] = ora2.split(':').map(Number);
  
    // Confronta le ore e i minuti direttamente
    if (ore1 > ore2 || (ore1 === ore2 && minuti1 > minuti2)) {
      return true;
    } else {
      return false;
    }
}

function verifyInputs(Anome, Acognome, AoraInizio, AoraFine) {
  let errori = '';
  let numeroErrori = 0;
  if(Anome == '' || Anome.length > 50) {
    if(errori != '')
      errori += ','
    numeroErrori++;
    errori += 'Il campo "Nome" è vuoto o errato ';
  }
  if(Acognome == '')  {
    if(errori != '')
      errori += ','
    numeroErrori++;
    errori += 'Il campo "Cognome" è vuoto'; 
  }
  if(AoraInizio != '' && AoraFine != '')  {
    if(isOraMaggiore(AoraInizio, AoraFine))   {
      if(errori != '')
        errori += ','
      numeroErrori++;
      errori += 'L\'ora di inizio è maggiore dell\' ora di fine.';
    }
  }

  if(numeroErrori > 0)
    return errori;
  else return '';
}


function sendRequestAggiungi()  {
  let nomeResponsabile = document.getElementById('nomeResponsabileTI').value;
  let cognomeResponsabile = document.getElementById('cognomeResponsabileTI').value;
  let oraInizioRicevimento = document.getElementById('fieldTimestampTime-oraInizioRicevimento').value;
  let oraFineRicevimento = document.getElementById('fieldTimestampTime-oraFineRicevimento').value;
  let destinazioneUfficio = document.getElementById('nomiUffici').value;

  let api = 'http://192.168.94.109:8080/Responsabile/';
  console.log(destinazioneUfficio);
  let error = verifyInputs(nomeResponsabile, cognomeResponsabile, oraInizioRicevimento, oraFineRicevimento);
  if(error != '')    {
    Swal.fire({
        icon: "warning",
        title: "Oops...",
        text: "Ci sono dei campi vuoti o errati!\n" + error
    });  
    return;
  } 
  console.log(currentResponsabileId);

  if(currentResponsabileId == 0)  {
    apiUrl = api + 'Aggiungi/'+ nomeResponsabile + '/' + cognomeResponsabile + '/' + oraInizioRicevimento + '/' + oraFineRicevimento + '/' + token + '/' + destinazioneUfficio;
  } else  {
    apiUrl = api + 'Update/'+ nomeResponsabile + '/' + cognomeResponsabile + '/' + oraInizioRicevimento + '/' + oraFineRicevimento + '/'+ token + '/' + destinazioneUfficio + '/' + curren;
  }
    
  
    // Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
    const requestOptions = {
        method: 'POST',  
    };

    // Esegui la richiesta fetch
    fetch(apiUrl, requestOptions)
        .then(response => {

          console.log(response.status);
          if (response.status == 400) {
            if(currentResponsabileId == 0){
              Swal.fire({
                title: "Aggiunta evento",
                text: "Ops! Alcuni campi sono errati...",
                icon: "error"
              });
            } else  {
              Swal.fire({
                title: "Modifica evento",
                text: "Alcuni campi sono errati..",
                icon: "error"
              });
            }
            throw new Error('Campi errati. Status code:' + response.status);             
          } else if (response.status == 500) {
            
            if(currentResponsabileId == 0){
              Swal.fire({
                title: "Aggiunta evento",
                text: "Aggiunta non avvenuta.",
                icon: "error"
              });
            } else  {
              Swal.fire({
                title: "Modifica evento",
                text: "Aggiunta non avvenuta.",
                icon: "error"
              });
            }            
            throw new Error('Campi errati. Status code:' + response.status);
          }
      
        return response.json();
      })
        .then(data => {
            console.log('Risposta dal server:', data);
            // Puoi gestire la risposta qui
                  
            if(currentResponsabileId == 0){
              Swal.fire({
                title: "Aggiunta evento",
                text: "Aggiunta effettuata con successo!",
                icon: "success"
              });
            } else  {
              Swal.fire({
                title: "Modifica evento",
                text: "Modifica effettuata con successo!",
                icon: "success"
              });
            }
            setTimeout(function() {
              location.reload();
          }, 3000);

            $('#responsabileModal').modal('hide');
            
        })
        .catch(error => {
            console.error('Errore nella richiesta:', error);
            // Puoi gestire gli errori qui
        });
  }

  function deleteResponsabile(idResponsabile)  {
  
    const apiUrl = 'http://192.168.94.109:8080/Responsabile/Remove/' + token + '/' + idResponsabile;
        const requestOptions = {
          method: 'POST',  
      };
  
      // Esegui la richiesta fetch
      fetch(apiUrl, requestOptions)
          .then(response => response.json()) // Trasforma la risposta in JSON
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
                  text: "Il responsabile è stato eliminato.",
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


function sendRequestGetResponsabileList()  {
  const apiUrl = 'http://192.168.94.109:8080/Responsabile/GetList/';
  

// Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
const requestOptions = {
    method: 'GET',  
};

// Esegui la richiesta fetch
fetch(apiUrl, requestOptions)
    .then(response => response.json()) // Trasforma la risposta in JSON
    .then(data => {
        console.log('Risposta dal server:', data);
        // Puoi gestire la risposta qui
        popolaTableResponsabile(data);
    })
    .catch(error => {
        console.error('Errore nella richiesta:', error);
        // Puoi gestire gli errori qui
    });
}


//imposta i valori della select degli uffici
function populateNommiUfficiSelect()  {
  let selectTarga = document.getElementById('nomiUffici');


  const apiUrlee = 'http://192.168.94.109:8080/Destinazione/GetUffici/ufficio';

  
  // Opzioni della richiesta, tra cui il metodo (GET), l'intestazione e il corpo dati
  const requestOptions = {
      method: 'GET',  
  };
  
  // Esegui la richiesta fetch
  fetch(apiUrlee, requestOptions)
      .then(response => response.json()) // Trasforma la risposta in JSON
      .then(data => {
          console.log('Risposta dal server:', data);
          // Puoi gestire la risposta qui
          for (var i = 0; i < data.length; i++) {
            var option = document.createElement('option');
            option.value = data[i].id;
            option.text = data[i].nome;
            selectTarga.appendChild(option);
          }
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });

}
