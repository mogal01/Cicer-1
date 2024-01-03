let currentEventId;
let iconHeaderEvent;

setup();

function setup()  {
  popolaEventiTable();

  iconHeaderEvent = document.getElementById('icon-event');
}


function popolaEventiTable()  {
  let events = [
    {
      "Id": 1,
      "Nome evento": "Conferenza A",
      "Data inizio": "2023-01-01",
      "Data fine": "2023-01-03",
      "Ora inizio": "09:00",
      "Ora fine": "17:00",
      "Tipo": "Conferenza",
      "Responsabile": "utente 1"
    },
    {
      "Id": 2,
      "Nome evento": "Mostra B",
      "Data inizio": "2023-02-05",
      "Data fine": "2023-02-10",
      "Ora inizio": "10:00",
      "Ora fine": "18:00",
      "Tipo": "Mostra",
      "Responsabile": "utente 2"
    },
    {
      "Id": 3,
      "Nome evento": "Concerto C",
      "Data inizio": "2023-03-15",
      "Data fine": "2023-03-15",
      "Ora inizio": "20:00",
      "Ora fine": "23:00",
      "Tipo": "Concerto",
      "Responsabile": "utente 3"
    },
    {
      "Id": 4,
      "Nome evento": "Workshop D",
      "Data inizio": "2023-04-20",
      "Data fine": "2023-04-22",
      "Ora inizio": "13:00",
      "Ora fine": "16:00",
      "Tipo": "Workshop",
      "Responsabile": "utente 4"
    },
    {
      "Id": 5,
      "Nome evento": "Presentazione E",
      "Data inizio": "2023-05-10",
      "Data fine": "2023-05-10",
      "Ora inizio": "14:30",
      "Ora fine": "16:30",
      "Tipo": "Presentazione",
      "Responsabile": "utente 5"
    },
    {
      "Id": 6,
      "Nome evento": "Festival F",
      "Data inizio": "2023-06-18",
      "Data fine": "2023-06-25",
      "Ora inizio": "16:00",
      "Ora fine": "22:00",
      "Tipo": "Festival",
      "Responsabile": "utente 5"
    },
    {
      "Id": 7,
      "Nome evento": "Seminario G",
      "Data inizio": "2023-07-08",
      "Data fine": "2023-07-10",
      "Ora inizio": "09:30",
      "Ora fine": "16:00",
      "Tipo": "Seminario",
      "Responsabile": "utente 2"
    },
    {
      "Id": 8,
      "Nome evento": "Spettacolo H",
      "Data inizio": "2023-08-12",
      "Data fine": "2023-08-12",
      "Ora inizio": "19:00",
      "Ora fine": "22:30",
      "Tipo": "Spettacolo",
      "Responsabile": "utente 4"
    },
    {
      "Id": 9,
      "Nome evento": "Conferenza I",
      "Data inizio": "2023-09-05",
      "Data fine": "2023-09-07",
      "Ora inizio": "10:00",
      "Ora fine": "18:00",
      "Tipo": "Conferenza",
      "Responsabile": "utente 1"
    },
    {
      "Id": 10,
      "Nome evento": "Esibizione J",
      "Data inizio": "2023-10-20",
      "Data fine": "2023-10-20",
      "Ora inizio": "15:00",
      "Ora fine": "17:30",
      "Tipo": "Esibizione",
      "Responsabile": "utente 7"
    }
  ]
  
  let tableEventi = new DataTable('#eventiTable', {
    columns:  [
      {"data": 'Id'},
      {"data": 'Nome evento'},
      {"data": 'Data inizio'},
      {"data": 'Data fine'},
      {"data": 'Ora inizio'},
      {"data": 'Ora fine'},
      {"data": 'Tipo'},
      {"data": "Responsabile"},
      {"data": "",
        "render": function ( data, type, row, meta ) {
          return '<button class="btn btn-primary2" type="button" data-bs-toggle="modal" data-bs-target="#eventModal" onclick="setModifyEvent('+ row.Id +')"> Modifica </button>'
          + '';
        }
    }
    ],
    data: events,
    responsive: false
    });
}

function setModifyEvent(AId)  {
  currentEventId = AId;
  iconHeaderEvent.classList.remove('fa-plus');
  iconHeaderEvent.classList.add('fa-pencil');
}

function setAddEventModal()  {
  iconHeaderEvent.classList.remove('fa-pencil');
  iconHeaderEvent.classList.add('fa-plus');
}
