let currentUserId;
let iconHeader;

setup();

function setup()  {
  popolaTable();
  iconHeader = document.getElementById('icon_utente');
}


function popolaTable()  {
  let AdataUtenti = [
    {"Id": "1", "Nome": "Abdul", "Cognome": "Asmari", "Email": "abdul@unisa.it", "Permessi": "true", "": ""},
    {"Id": "2", "Nome": "MArio", "Cognome": "Rossi", "Email": "m.rossi12@unisa.it", "Permessi": "false", "": ""},
    {"Id": "3", "Nome": "Luigi", "Cognome": "Gagliardi", "Email": "l.gagliardi3@unisa.it", "Permessi": "true", "": ""},
    {"Id": "4", "Nome": "GIGI", "Cognome": "BUFFON", "Email": "g.buffone@unisa.it", "Permessi": "false", "": ""},
    {"Id": "5", "Nome": "Gesu'", "Cognome": "Bambino", "Email": "g.bambino@unisa.it", "Permessi": "true", "": ""}
  ];
  
  
  let tableUtenti = new DataTable('#utentiTable', {
  columns:  [
    {"data": 'Id'},
    {"data": 'Nome'},
    {"data": 'Cognome'},
    {"data": 'Email'},
    {"data": 'Permessi'},
    {"data": '',
      "render": function ( data, type, row, meta ) {
        return '<button class="btn btn-primary2" type="button" data-bs-toggle="modal" data-bs-target="#utenteModal" onclick="setDataUserModal('+ row.Id +')"> Modifica </button>'
        + '';
      }}
  ],
  data: AdataUtenti,
  responsive: false
  });
}


//setta i campi del form per la modale modificaUtente
function setDataUserModal(AId) {
  currentUserId = AId;
  iconHeader.classList.remove('fa-plus');
  
  iconHeader.classList.add('fa-pencil');
}

function setAddDataUserModal()  {
  iconHeader.classList.remove('fa-pencil');
  iconHeader.classList.add('fa-plus');
}


function sendRequestAggiungi()  {
  let nome = document.getElementById('nomeUtenteTI');
  let cognome = document.getElementById('cognomeUtenteTi');
  let email = document.getElementById('emailUtenteTI');
  let password = document.getElementById('passwordUtenteTI');
  let permessi = document.getElementById('permessiUtenteTI');


  //const apiUrl = 'http://192.168.134.109:8080/Utente/Aggiungi/'+ nome + '/' + cognome + '/' + email + '/' + password + '/' + permessi ;
  const apiUrl = 'http://192.168.134.109:8080/Utente/GetList/';


// Opzioni della richiesta, tra cui il metodo (POST), l'intestazione e il corpo dati
const requestOptions = {
    method: 'GET',
    headers: {
        'Content-Type': 'application/json', // Imposta l'intestazione Content-Type a "application/json" se stai inviando dati JSON
        'Access-Control-Allow-Origin': '*',
    },
    
};

// Esegui la richiesta fetch
fetch(apiUrl, requestOptions)
    .then(response => response.json()) // Trasforma la risposta in JSON
    .then(data => {
        console.log('Risposta dal server:', data);
        // Puoi gestire la risposta qui
    })
    .catch(error => {
        console.error('Errore nella richiesta:', error);
        // Puoi gestire gli errori qui
    });
}
