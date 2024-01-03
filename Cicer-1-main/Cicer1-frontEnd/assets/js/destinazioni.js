let currentDestinationId;
setup();

function setup()    {
    popolaDestinazioniTable();
}

function popolaDestinazioniTable()  {
    let AdataDestinazioni = [
        {"Id": "1", "Stato": "attivo", "Nome": "F8", "Id Edificio": "F2", "Tipo": "Aula", "" : ""},
        {"Id": "2", "Stato": "attivo", "Nome": "P21", "Id Edificio": "F3", "Tipo": "Aula", "" : ""},
        {"Id": "3", "Stato": "attivo", "Nome": "P3", "Id Edificio": "F3", "Tipo": "Aula", "" : ""},
        {"Id": "4", "Stato": "attivo", "Nome": "F1", "Id Edificio": "F2", "Tipo": "Aula", "" : ""},
        {"Id": "5", "Stato": "attivo", "Nome": "Ufficio di pippotto", "Id Edificio": "F", "Tipo": "Ufficio", "" : ""},
        {"Id": "6", "Stato": "attivo", "Nome": "Bar di scienze", "Id Edificio": "F", "Tipo": "Ristoro", "" : ""}
      ];
      
    
    let tableAule = new DataTable('#auleTable', {
      columns:  [
        {"data": 'Id'},
        {"data": 'Nome'},
        {"data": 'Stato'},
        {"data": 'Id Edificio'},
        {"data": 'Tipo'},
        {"data": '', 
            "render": function ( data, type, row, meta ) {
                return '<button class="btn btn-primary2" type="button" data-bs-toggle="modal" data-bs-target="#destinazioneModal" onclick="setModifyDestination('+ row.Id +')"> Modifica </button>'
                + '';
              }}
      ],
      data: AdataDestinazioni,
      responsive: false
    });
}

function setModifyDestination(AId)  {
  currentDestinationId = AId;
}