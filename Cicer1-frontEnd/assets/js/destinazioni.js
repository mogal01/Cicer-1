let currentDestinationId = 0;
var tableDestinazioni;
setup();
let token = sessionStorage.getItem('token');

function setup()    {
  sendRequestGetDestinazioneList();
}

function popolaDestinazioniTable(AdataDestinazioni)  {
    
    if(tableDestinazioni != undefined)  {
      tableDestinazioni.destroy;  
    }

    tableDestinazioni = new DataTable('#destinazioniTable', {
      "scrollY":"50vh",
      columns:  [
        {"data": 'id'},
        {"data": 'nome'},
        {"data": 'stato'},
        {"data": 'tipo'},
        {"data": 'nomeEd'},
        {"data": '', 
            "render": function ( data, type, row, meta ) {
                return '<button class="btn btn-primary2 modify" type="button" data-bs-toggle="modal" data-bs-target="#destinazioneModal" onclick="popolaModale('+ row.id +')"> Modifica </button>'
                + '';
              }}
      ],
      data: AdataDestinazioni,
      responsive: false
    });
}

function sendRequestGetDestinazioneList() {
  const apiUrl = 'http://192.168.94.109:8080/Destinazione/GetList//';
  
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
          popolaDestinazioniTable(data);
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });
}

function popolaModale(AIdDestination)  {
  currentDestinationId = AIdDestination;
  let nomeDestinazioneTI = document.getElementById('nomeDestinazioneTI');
  let statoDestinazioneSelect = document.getElementById('statoDestinazioneSelect');
  let tipoDestinazioneSelect = document.getElementById('tipoDestinazioneSelect');
  let idEdificioDestinazioneTI = document.getElementById('idEdificioDestinazioneTI');

  const apiUrl = 'http://192.168.94.109:8080/Destinazione/GetDestinazione/' + AIdDestination;
  

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
          nomeDestinazioneTI.value = data.nome;
          statoDestinazioneSelect.value = data.stato;
          tipoDestinazioneSelect.value = data.tipo;
          idEdificioDestinazioneTI.value = data.edificio;
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });
}

function saveChanges()  {
  let statoDestinazione = document.getElementById('statoDestinazioneSelect').value;
  console.log(statoDestinazione);

  const apiUrl = 'http://192.168.94.109:8080/Destinazione/Update/' + token + '/' +  statoDestinazione + '/' + currentDestinationId;
    // Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
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
            title: "Modifica destinazione",
            text: "Modifica effettuata con successo!",
            icon: "success"
          });
          $('#destinazioneModal').modal('hide');
          setTimeout(function() {
            location.reload();
        }, 3000);
      })
      .catch(error => {
          console.error('Errore nella richiesta:', error);
          // Puoi gestire gli errori qui
      });
      currentDestinationId = 0;
}