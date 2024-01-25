document.addEventListener('DOMContentLoaded', function() {
    // Codice da eseguire quando il DOM è completamente caricato
    setAdminCard();
    setAuleCard();
    setEventiCard();
});


function setAuleCard()  {
    let auleAttiveP = document.getElementById('auleAttiveP');
    let auleInManutenzioneP = document.getElementById('auleInManutenzioneP');
    let totaleAuleP = document.getElementById('totaleAuleP');
    const apiUrl = 'http://192.168.216.109:8080/Destinazione/GetNumDest';
    const requestOptions = {
        method: 'GET',  
    };
    
    // Esegui la richiesta fetch
    fetch(apiUrl, requestOptions)
        .then(response => response.json()) // Trasforma la risposta in JSON
        .then(data => {
            console.log('Risposta dal server:', data);
            // Puoi gestire la risposta qui
            auleAttiveP.textContent = data.nAuleAcc;
            auleInManutenzioneP.textContent = data.nAuleNonAcc;
            totaleAuleP.textContent = data.nAuleTot;
        })
        .catch(error => {
            console.error('Errore nella richiesta:', error);
            // Puoi gestire gli errori qui
        });
}

function setEventiCard()  {
    let eventiMeseCorrenteP = document.getElementById('eventiMeseCorrenteP');
    let eventiGiornoCorrenteP = document.getElementById('eventiGiornoCorrenteP');
    let nEventiTotaleP = document.getElementById('nEventiTotaleP');
    const apiUrl = 'http://192.168.216.109:8080/Evento/GetNumEventi';
    const requestOptions = {
        method: 'GET',  
    };
    
    // Esegui la richiesta fetch
    fetch(apiUrl, requestOptions)
        .then(response => response.json()) // Trasforma la risposta in JSON
        .then(data => {
            console.log('Risposta dal server:', data);
            // Puoi gestire la risposta qui
            eventiMeseCorrenteP.textContent = data.nEventiMese;
            eventiGiornoCorrenteP.textContent = data.nEventiGiorno;
            nEventiTotaleP.textContent = data.nEventiTot;
        })
        .catch(error => {
            console.error('Errore nella richiesta:', error);
            // Puoi gestire gli errori qui
        });
}

function setAdminCard()  {
    let nAmministratoriP = document.getElementById('nUtentiPerm');
    let nSubAdminP = document.getElementById('nUtentiSenzaPerm');
    let nAdminTotP = document.getElementById('nUtentiTot');
    const apiUrl = 'http://192.168.216.109:8080/Utente/GetNumUtenti';
    const requestOptions = {
        method: 'GET',  
    };
    
    // Esegui la richiesta fetch
    fetch(apiUrl, requestOptions)
        .then(response => response.json()) // Trasforma la risposta in JSON
        .then(data => {
            console.log('Risposta dal server:', data);
            // Puoi gestire la risposta qui
            nAmministratoriP.textContent = data.nUtentiPerm;
            nSubAdminP.textContent = data.nUtentiSenzaPerm;
            nAdminTotP.textContent = data.nUtentiTot;
        })
        .catch(error => {
            console.error('Errore nella richiesta:', error);
            // Puoi gestire gli errori qui
        });
}