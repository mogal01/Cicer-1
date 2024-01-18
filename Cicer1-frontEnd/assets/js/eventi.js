let currentEventId = 0;
let iconHeaderEvent;
var tableEventi;
let tokeen = sessionStorage.getItem('token');

setup();

function setup()  {
  //popolaEventiTable();
  populateDestinationSelect();
  iconHeaderEvent = document.getElementById('icon-event');
  sendRequestGetEventiList();
  populateResponsabiliSelect();
}


function popolaEventiTable(events)  {
  
  if(tableEventi != undefined)  {
    tableEventi.destroy;  
  }
    tableEventi = new DataTable('#eventiTable', {
    "scrollY":"50vh",
    columns:  [
      {"data": 'id'},
      {"data": 'nome'},
      {"data": 'data_ora_inizio'},
      {"data": 'data_ora_fine'},
      {"data": 'destinazione'},
      {"data": 'utente'},
      {"data": 'tipo'},
      {"data": "responsabile"},
      {"data": "",
        "render": function ( data, type, row, meta ) {
          return '<button class="btn btn-primary2 modify" type="button" data-bs-toggle="modal" data-bs-target="#eventModal" onclick="modifyEventData('+ row.id +')"> Modifica </button>'
          + '';
        }
      },
    {"data": '', 
    "render": function ( data, type, row, meta ) {
        return '<button class="fa fa-trash-o" type="button" onclick="deleteEvent('+ row.id +')"></button>'
        + '';
      }}
    ],
    data: events,
    responsive: false
    });
}


//verifica se i campi non sono vuoti e se la data di inizio è maggiore della data di fine
function verifyInputs(ANome, ADataInizio, AdataFine, AoraInizio, AoraFine, AtipoEvento, Adestinazione, Aresponsabile) {
  let numberErrors = 0;
  let errors = '';
  if(ANome == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "nome" è vuoto'; 
    numberErrors ++;
  }
  if(ADataInizio == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Data inizio" nome è vuoto' ; 
    numberErrors++;
  }
  if(AdataFine == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Data fine" nome è vuoto'; 
    numberErrors++;
  }
  if(AoraInizio == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Ora inizio" nome è vuoto'; 
    numberErrors++;
  }
  if(AoraFine == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Ora fine" nome è vuoto'; 
    numberErrors++;
  }
  if(Aresponsabile == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Responsabile" nome è vuoto';
    numberErrors++;
  }

  if (isDataMaggiore(ADataInizio, AdataFine)) {
    if(errors != '')
      errors += ','
    errors += 'La data di inizio è più grande della data di fine';
    numberErrors++;
  }

  if(isOraMaggiore(AoraInizio, AoraFine)) {
    if(errors != '')
      errors += ','
    errors += 'L\' ora di inizio è maggiore dell\' ora di fine.';
    numberErrors++;
  }
  if(AtipoEvento == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "tipo" è vuoto';
    numberErrors++;
  }
  if(Adestinazione == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Responsabile" nome è vuoto';
    numberErrors++;
  }
  if(Aresponsabile == '') {
    if(errors != '')
      errors += ','
    errors += 'Il campo "Responsabile" nome è vuoto';
    numberErrors++;
  }

  if(numberErrors > 0)  {
    return errors;
  }

  return '';

}

function isDataMaggiore(data1, data2) {
  // Converti le date in timestamp
  const timestampData1 = new Date(data1).getTime();
  const timestampData2 = new Date(data2).getTime();

  // Verifica quale timestamp è più grande
  return timestampData1 > timestampData2;
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


//richesta al server per aggiungere o modificare un evento
function sendRequestAggiungiEvent()  {
  let nomeEvento = document.getElementById('nomeEventoTI').value;
  let dataInizio = document.getElementById('fieldTimestampData-inizio').value;
  let dataFine = document.getElementById('fieldTimestampData-fine').value;
  let oraInizio = document.getElementById('fieldTimestampTime-oraInizio').value;
  let oraFine = document.getElementById('fieldTimestampTime-oraFine').value;
  let tipoEvento = document.getElementById('tipoEvento').value;
  let destinazione = document.getElementById('detinazioneEventoSelect').value;
  let responsabile = document.getElementById('responsabileEventoSelect').value;
  const api = 'http://192.168.94.109:8080/Evento/';

  var data_ora_inizio = new Date(dataInizio + ' ' + oraInizio); // or your date from the server
  // Format the date using moment.js
  var dataInizioFormatted = moment(data_ora_inizio).format('DD-MM-YYYY HH:mm');

  var data_ora_fine = new Date(dataFine + ' ' + oraFine); // or your date from the server
  // Format the date using moment.js
  var dataFineFormatted = moment(data_ora_fine).format('DD-MM-YYYY HH:mm');

  let err = verifyInputs(nomeEvento, dataInizio, dataFine, oraInizio, oraFine, tipoEvento, destinazione, responsabile);
  if(err != '')    {
    Swal.fire({
        icon: "warning",
        title: "Attenzione",
        text: "Qualcosa è andato storto!" + err
      });
      return;

  }  

  let apiUrlEvent = '';
  if(currentEventId == 0) {
    apiUrlEvent = api + 'Aggiungi/' + nomeEvento + '/' + dataInizioFormatted + '/' + dataFineFormatted + '/' + tipoEvento + '/' + tokeen + '/' + destinazione + '/' + responsabile ;
  } else  {
    apiUrlEvent = api + 'Update/' + nomeEvento + '/' + dataInizioFormatted + '/' + dataFineFormatted + '/' + tipoEvento + '/'+ tokeen + '/' + destinazione + '/' + responsabile + '/' + currentEventId;
  }
  
    // Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
    const requestOptions = {
        method: 'POST',  
    };

    // Esegui la richiesta fetch
    fetch(apiUrlEvent, requestOptions)
        .then(response => {
          if (response.status === 500) {
          if(currentEventId == 0){
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
        }
      
        return response.json();
      }) // Trasforma la risposta in JSON
        .then(data => {
            console.log('Risposta dal server:', data);                

            if(currentEventId == 0){
              Swal.fire({
                title: "Aggiunta evento",
                text: "Salvataggio effettuato con successo!",
                icon: "success"
              });
              }
              else  {
                Swal.fire({
                  title: "Modifica evento",
                  text: "Salvataggio effettuato con successo!",
                  icon: "success"
                });
              }
              

            $('#eventModal').modal('hide');
            setTimeout(function() {
              location.reload();
          }, 3000);
        })
        .catch(error => {
            console.error('Errore nella richiesta:', error);
            // Puoi gestire gli errori qui
        });
       
  }


//setta i valori della modale
function popolaDataEventiModal(IdEvento)  {
  let nomeEvento = document.getElementById('nomeEventoTI');
  let dataInizio = document.getElementById('fieldTimestampData-inizio');
  let dataFine = document.getElementById('fieldTimestampData-fine');
  let oraInizio = document.getElementById('fieldTimestampTime-oraInizio');
  let oraFine = document.getElementById('fieldTimestampTime-oraFine');
  let tipo = document.getElementById('tipoEvento');
  let destinazione = document.getElementById('detinazioneEventoSelect');
  let responsabileEvento = document.getElementById('responsabileEventoSelect');
  const apiUrl = 'http://192.168.94.109:8080/Evento/GetEvento/' + IdEvento;

  // Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
  const requestOptions = {
      method: 'GET',  
  };
  
  var dataOraInizio = 0;
  var dataOraFine = 0;
  // Esegui la richiesta fetch
  fetch(apiUrl, requestOptions)
      .then(response => response.json()) // Trasforma la risposta in JSON
      .then(data => {
          console.log('Risposta dal server:', data);

          //estrae data e ora inizio 
          dataOraInizio = data.data_ora_inizio;
          console.log('inizio: ' + data.data_ora_inizio);

          var dataInizio1 = dataOraInizio.toString().split(' ')[0];    
          var dataInizioFormat = moment(dataInizio1, 'DD/MM/YYYY').toDate();
          //orario inizio
          var oraInizio1 = dataOraInizio.toString().split(' ')[1].split('.')[0];

          //estrae data e ora fine
          dataOraFine = data.data_ora_fine;
          var dataFine1 = dataOraFine.toString().split(' ')[0];  
          var dataFineFormat = moment(dataFine1, 'DD/MM/YYYY').toDate();
          //orario fine
          var oraFine1 = dataOraFine.toString().split(' ')[1].split('.')[0];

          
          nomeEvento.value = data.nome;
          dataInizio.valueAsDate  = dataInizioFormat;     
          dataFine.valueAsDate = dataFineFormat;
          oraInizio.value = oraInizio1;
          oraFine.value = oraFine1;
          tipo.value = data.tipo;
          destinazione.value = data.destinazione;         
          responsabileEvento.value = data.responsabile;
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });
}


function modifyEventData(AIdEvent)  {
  popolaDataEventiModal(AIdEvent);
  iconHeaderEvent.classList.remove('fa-plus');
  iconHeaderEvent.classList.add('fa-pencil');
  currentEventId = AIdEvent;
}

function setAddEventModal()  {
  iconHeaderEvent.classList.remove('fa-pencil');
  iconHeaderEvent.classList.add('fa-plus');

  document.getElementById('nomeEventoTI').value = '';
  document.getElementById('fieldTimestampData-inizio').value = '';
  document.getElementById('fieldTimestampData-fine').value = '';
  document.getElementById('fieldTimestampTime-oraInizio').value = '';
  document.getElementById('fieldTimestampTime-oraFine').value = '';
  document.getElementById('tipoEvento').value = '';
  document.getElementById('detinazioneEventoSelect').value = '';
  document.getElementById('responsabileEventoSelect').value = '';
  currentEventId = 0;
}

function deleteEvent(idEvent)  {
  console.log(idEvent)
  const apiUrl = 'http://192.168.94.109:8080/Evento/Remove/' + tokeen + '/' + idEvent;
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
                text: "Eliminazione effettuata con successo!",
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


function sendRequestGetEventiList() {
  const apiUrl = 'http://192.168.94.109:8080/Evento/GetList/';
  

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
          popolaEventiTable(data);
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });
}

function populateDestinationSelect()  {
  let select = document.getElementById('detinazioneEventoSelect');

  const apiUrle = 'http://192.168.94.109:8080/Destinazione/GetList//ACCESSIBILE';

  // Opzioni della richiesta, tra cui il metodo (GET), l'intestazione e il corpo dati
  const requestOptions = {
      method: 'GET',  
  };
  
  // Esegui la richiesta fetch
  fetch(apiUrle, requestOptions)
      .then(response => response.json()) // Trasforma la risposta in JSON
      .then(data => {
          console.log('Risposta dal server:', data);
          // Puoi gestire la risposta qui
          for (var i = 0; i < data.length; i++) {
            var option = document.createElement('option');
            option.value = data[i].id;
            option.text = data[i].nome;
            select.appendChild(option);
          }
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });

}

function populateResponsabiliSelect()  {
  let selectResponsabile = document.getElementById('responsabileEventoSelect');


  const apiUrlee = 'http://192.168.94.109:8080/Responsabile/GetList/';

  
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
            option.text = data[i].nome + " " + data[i].cognome;
            selectResponsabile.appendChild(option);
          }
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });

}