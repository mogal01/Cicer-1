unit Maincontroller;

interface

{$I dmvcframework.inc}

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Phys.PG,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, DbU, System.SysUtils, System.Character, DateUtils,
  System.RegularExpressions,
  MVCFramework,
  MVCFramework.Logger,
  MVCFramework.Commons,
  Web.HTTPApp, UtentiU, EdificiU, EventiU, ResponsabiliU, DestinazioniU,
  System.JSON;

type

  [MVCPath('/')]
  TApp1MainController = class(TMVCController)

    function checkDataUtente(aNome, aCognome, aEmail, aPsw: string): Boolean;
    function checkDataEvento(aNome, aTipo: String;
      aDataOraInizio, aDataOraFine: TDateTime;
      aIdResponsabile: SmallInt): Boolean;
    function checkDataResponsabile(aNome, aCognome, aOraInizioRic,
      aOraFineRic: String; aDestinazione: SmallInt): Boolean;
  public

    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    [MVCPath('/Login/($aEmail)/($aPsw)')]
    [MVCHTTPMethod([httpPOST])]
    procedure LogIn(aEmail, aPsw: String);

    [MVCPath('/LogOut/($aToken)')]
    [MVCHTTPMethod([httpPOST])]
    procedure LogOut(aToken: String);

    [MVCPath('/Utente/Aggiungi/($aToken)/($aNome)/($aCognome)/($aEmail)/($aPsw)/($aPermessi)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiUtente(aToken, aNome, aCognome, aEmail, aPsw,
      aPermessi: String);

    [MVCPath('/Utente/Remove/($aToken)/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveUtente(aToken: String; aId: SmallInt);

    [MVCPath('/Utente/Update/($aToken)/($aNome)/($aCognome)/($aEmail)/($aPsw)/($aPermessi)/($aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateUtente(aToken, aNome, aCognome, aEmail, aPsw,
      aPermessi: String; aId: SmallInt);

    [MVCPath('/Utente/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListUtenti(aFiltro: String);

    [MVCPath('/Utente/GetNumUtenti')]
    [MVCHTTPMethod([httpGET])]
    procedure GetNumUtenti();

    [MVCPath('/Utente/GetUtente/($aToken)/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetUtente(aToken: String; aFiltro: SmallInt);

    [MVCPath('/Utente/GetProfilo/($aToken)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetProfilo(aToken: String);

    [MVCPath('/Edificio/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListEdifici(aFiltro: String);

    [MVCPath('/Evento/Aggiungi/($aNome)/($aDataOraInizio)/($aDataOraFine)/($aTipo)/($aToken)/($aIdDestinazione)/($aIdResponsabile)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiEvento(aNome: String;
      aDataOraInizio, aDataOraFine: String; aTipo, aToken: String;
      aIdDestinazione, aIdResponsabile: SmallInt);

    [MVCPath('/Evento/Remove/($aToken)/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveEvento(aToken: String; aId: SmallInt);

    [MVCPath('/Evento/Update/($aNome)/($aDataOraInizio)/($aDataOraFine)/($aTipo)/($aToken)/($aIdDestinazione)/($aIdResponsabile)/($aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateEvento(aNome: String; aDataOraInizio, aDataOraFine: String;
      aTipo, aToken: String; aIdDestinazione, aIdResponsabile, aId: SmallInt);

    [MVCPath('/Evento/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListEventi(aFiltro: String);

    [MVCPath('/Evento/GetEvento/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetEvento(aFiltro: SmallInt);

    [MVCPath('/Evento/GetNumEventi')]
    [MVCHTTPMethod([httpGET])]
    procedure GetNumEventi();

    [MVCPath('/Responsabile/Aggiungi/($aNome)/($aCognome)/($aOraInizioRicevimento)/($aOraFineRicevimento)/($aToken)/($aIdDestinazione)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiResponsabile(aNome, aCognome, aOraInizioRicevimento,
      aOraFineRicevimento, aToken: String; aIdDestinazione: SmallInt);

    [MVCPath('/Responsabile/Remove/($aToken)/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveResponsabile(aToken: String; aId: SmallInt);

    [MVCPath('/Responsabile/Update/($aNome)/($aCognome)/($aOraInizioRicevimento)/($aOraFineRicevimento)/($aToken)/($aIdDestinazione)/(%aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateResponsabile(aNome, aCognome, aOraInizioRicevimento,
      aOraFineRicevimento, aToken: String; aIdDestinazione, aId: SmallInt);

    [MVCPath('/Responsabile/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListResponsabile(aFiltro: String);

    [MVCPath('/Responsabile/GetResponsabile/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetResponsabile(aFiltro: SmallInt);

    [MVCPath('/Destinazione/Update/($aToken)/($aStato)/($aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateDestinazione(aStato, aToken: String; aId: SmallInt);

    [MVCPath('/Destinazione/GetList/($aFiltro)/($aFiltroStato)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListDestinazioni(aFiltro, aFiltroStato: String);

    [MVCPath('/Destinazione/GetUffici/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListDestinazioniUffici(aFiltro: String);

    [MVCPath('/Destinazione/GetNumDest')]
    [MVCHTTPMethod([httpGET])]
    procedure GetNumDest();

    [MVCPath('/Destinazione/GetDestinazione/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetDestinazione(aFiltro: SmallInt);

  end;

implementation

uses MVCFramework.Serializer.JSONDataObjects,
  MVCFramework.Serializer.Commons, JSONDataObjects;

procedure TApp1MainController.Index;
begin
  // Reindirizza la richiesta alla pagina principale dell'applicazione, "/app/index.html".
  Redirect('/app/index.html');
end;

procedure TApp1MainController.LogIn(aEmail, aPsw: String);
var
  lUtente: tUtenti; // Oggetto utente che gestir� l'autenticazione.
  JSONResponse: TJsonObject; // Oggetto JSON per creare la risposta JSON.
  lToken: String; // Stringa per memorizzare il token di autenticazione.

begin
  lUtente := tUtenti.Create; // Creazione di un'istanza della classe utenti.
  JSONResponse := TJsonObject.Create;
  // Creazione di un'istanza della classe JSON per costruire la risposta.

  try

    lToken := lUtente.LogIn(aEmail, aPsw);
    // Chiamata al metodo di autenticazione dell'utente con email e password.
    // Verifica se il token � stato restituito (autenticazione riuscita).
    if (lToken <> '') then
    begin
      // Se l'autenticazione � riuscita, imposta il messaggio di benvenuto e il token nella risposta JSON.
      JSONResponse.S['Result'] := 'Bentornato amico!';
      JSONResponse.S['token'] := lToken;
      // Utilizza il metodo render per inviare la risposta JSON al client.
      render(JSONResponse, false);
    end
    else
    begin
      // Se l'autenticazione non � riuscita, imposta un messaggio di errore nella risposta JSON.
      JSONResponse.S['Result'] := 'Chi sei? Goku non lo sai!';
      // Utilizza il metodo render con codice di stato 403 per indicare un accesso vietato.
      render(403, JSONResponse, false);
    end;

  finally
    // Libera le risorse allocate.
    JSONResponse.Free;
    lUtente.Free;

  end;

end;

procedure TApp1MainController.LogOut(aToken: String);
var
  lUtente: tUtenti;
  JSONResponse: TJsonObject;

begin

  lUtente := tUtenti.Create;
  JSONResponse := TJsonObject.Create;

  try
    // Chiamata al metodo di logout dell'utente con il token di autenticazione.
    if (lUtente.LogOut(aToken)) then
    begin
      // Se il logout ha avuto successo, imposta un messaggio di successo nella risposta JSON.
      JSONResponse.S['Result'] := 'Eliminazione avvenuta con successo';
      // Utilizza il metodo render per inviare la risposta JSON al client.
      render(JSONResponse, false);

    end

    else
    begin
      // Se il logout non ha avuto successo, imposta un messaggio di errore nella risposta JSON.
      JSONResponse.S['Result'] := 'Eliminazione non avvenuta';
      // Utilizza il metodo render con codice di stato 500 per indicare un errore del server.
      render(500, JSONResponse, false);
    end;

  finally
    JSONResponse.Free;
    lUtente.Free;

  end;
end;

function TApp1MainController.checkDataUtente(aNome, aCognome, aEmail,
  aPsw: string): Boolean;
const
  // Espressione regolare per validare l'indirizzo email.
  EmailRegexPattern = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$';
var
  carattere: Char;
  checkNome: Boolean;
  checkCognome: Boolean;
  checkEmail: Boolean;
begin
  // Inizializza le variabili di controllo ai valori di default.
  checkNome := aNome <> ''; // La stringa non � vuota
  checkCognome := aCognome <> '';
  // Verifica la validit� del nome.
  if (checkNome) then
  begin
    for carattere in aNome do
    begin
      // Controlla se ogni carattere del nome � una lettera o uno spazio.
      if not(TCharacter.IsLetter(carattere) or (carattere = ' ')) then
      begin
        checkNome := false;
        Break;
      end;
    end;
  end;
  if (checkCognome) then
  begin
    for carattere in aCognome do
    begin
      if not(TCharacter.IsLetter(carattere) or (carattere = ' ')) then
      begin
        checkCognome := false;
        Break;
      end;
    end;
  end;
  // Verifica la validit� dell'indirizzo email utilizzando l'espressione regolare.
  checkEmail := TRegEx.IsMatch(aEmail, EmailRegexPattern);
  // Verifica complessiva: nome, cognome, lunghezza della password e validit� email.
  if (checkNome and checkCognome and (Length(aPsw) >= 6) and
    (Length(aPsw) <= 20) and checkEmail) then
  begin
    // Tutte le condizioni sono soddisfatte, restituisce true.
    result := true;
  end
  else
  begin
    // Almeno una condizione non � soddisfatta, restituisce false.
    result := false;
  end;

end;

function TApp1MainController.checkDataEvento(aNome, aTipo: String;
  aDataOraInizio, aDataOraFine: TDateTime; aIdResponsabile: SmallInt): Boolean;

begin
  // Verifica se il nome dell'evento � vuoto o supera i 50 caratteri.
  if ((aNome = '') or (Length(aNome) > 50)) then
  begin
    // Se il nome dell'evento non � valido, restituisce false.
    result := false;
  end
  else
  begin
    // Se il nome dell'evento � valido, verifica il tipo dell'evento.
    if ((aTipo = 'Lezione') or (aTipo = 'Laurea') or (aTipo = 'Convegno') or
      (aTipo = 'Esame') or (aTipo = 'Orientamento') or (aTipo <> '')) then
    begin
      // Se il tipo dell'evento � valido, verifica se la data di inizio � precedente o uguale a quella di fine.
      if (CompareDateTime(aDataOraInizio, aDataOraFine) <= 0) then
        result := true; // Se la data � valida, restituisce true.
    end;
  end;

end;

function TApp1MainController.checkDataResponsabile(aNome, aCognome,
  aOraInizioRic, aOraFineRic: String; aDestinazione: SmallInt): Boolean;
var
  oraInizio: TDateTime;
  oraFine: TDateTime;
begin
  // Converti le stringhe di orario in oggetti TDateTime.
  oraInizio := StrToDateTime(aOraInizioRic);
  oraFine := StrToDateTime(aOraFineRic);
  // Verifica se il nome e il cognome del responsabile sono vuoti o superano i 50 caratteri.
  if (((aNome = '') or (Length(aNome) > 50)) or
    ((aCognome = '') or (Length(aCognome) > 50))) then
  begin
    // Se il nome o il cognome del responsabile non sono validi, restituisce false.
    result := false;
  end
  else
  begin
    // Se il nome e il cognome del responsabile sono validi, verifica se l'orario di inizio � precedente o uguale a quello di fine
    // e se la destinazione � un numero positivo.
    if ((CompareTime(oraInizio, oraFine) <= 0) and (aDestinazione > 0)) then
      result := true; // Se tutti i controlli sono superati, restituisce true.
  end;

end;

procedure TApp1MainController.AggiungiUtente(aToken, aNome, aCognome, aEmail,
  aPsw, aPermessi: String);
var
  lUtente: tUtenti;
  JSONResponse: TJsonObject;

begin

  lUtente := tUtenti.Create;
  JSONResponse := TJsonObject.Create;

  try
    // Verifica se l'utente che invia la richiesta ha i permessi necessari.
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin
      // Se l'utente ha i permessi, verifica la validit� dei dati dell'utente.
      if (checkDataUtente(aNome, aCognome, aEmail, aPsw)) then
      begin
        // Se i dati dell'utente sono validi, tenta di aggiungere l'utente.
        if (lUtente.aggiungi(aNome, aCognome, aEmail, aPsw, aPermessi)) then
        begin
          // Se l'aggiunta ha successo, imposta un messaggio di successo nella risposta JSON.
          JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
          // Utilizza il metodo render per inviare la risposta JSON al client.
          render(JSONResponse, false);

        end
        else
        begin
          // Se l'aggiunta non ha successo (utente gi� esistente), imposta un messaggio di errore nella risposta JSON.
          JSONResponse.S['Result'] := 'Aggiunta non avvenuta perch� gi� esiste';
          // Utilizza il metodo render con codice di stato 500 per indicare un errore del server.
          render(500, JSONResponse, false);
        end;
      end
      else
      begin
        // Se i dati dell'utente non sono validi, imposta un messaggio di errore nella risposta JSON.
        JSONResponse.S['Result'] :=
          'Aggiunta non avvenuta con successo perch� i campi so sbagliti';
        // Utilizza il metodo render con codice di stato 500 per indicare un errore del server.
        render(400, JSONResponse, false);
      end;
    end
    else
    begin
      // Se l'utente non ha i permessi, imposta un messaggio di errore nella risposta JSON.
      JSONResponse.S['Result'] := 'Non hai i permessi';
      // Utilizza il metodo render con codice di stato 403 per indicare un accesso vietato.
      render(403, JSONResponse, false);
    end;

  finally
    // Libera le risorse allocate.
    JSONResponse.Free;
    lUtente.Free;

  end;

end;

procedure TApp1MainController.RemoveUtente(aToken: String; aId: SmallInt);
var
  lUtente: tUtenti;
  JSONResponse: TJsonObject;

begin
  lUtente := tUtenti.Create;
  JSONResponse := TJsonObject.Create;

  try
    // Verifica se l'utente che invia la richiesta ha i permessi necessari.
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin
      // Se l'utente ha i permessi, tenta di rimuovere l'utente con l'ID specificato.
      if (lUtente.Remove(aId)) then
      begin
        // Se la rimozione ha successo, imposta un messaggio di successo nella risposta JSON.
        JSONResponse.S['Result'] := 'Eliminazione avvenuta con successo';
        // Utilizza il metodo render per inviare la risposta JSON al client.
        render(JSONResponse, false);
      end
      else
      begin
        // Se la rimozione non ha successo, imposta un messaggio di errore nella risposta JSON.
        JSONResponse.S['Result'] := 'Eliminazione non avvenuta';
        // Utilizza il metodo render con codice di stato 500 per indicare un errore del server.
        render(500, JSONResponse, false);
      end;
    end
    else
    begin
      // Se l'utente non ha i permessi, imposta un messaggio di errore nella risposta JSON.
      JSONResponse.S['Result'] := 'Non hai i permessi';
      // Utilizza il metodo render con codice di stato 403 per indicare un accesso vietato.
      render(403, JSONResponse, false);
    end;

  finally
    JSONResponse.Free;
    lUtente.Free;

  end;
end;

procedure TApp1MainController.UpdateUtente(aToken, aNome, aCognome, aEmail,
  aPsw, aPermessi: String; aId: SmallInt);
var
  lUtente: tUtenti;
  JSONResponse: TJsonObject;

begin
  lUtente := tUtenti.Create;
  JSONResponse := TJsonObject.Create;

  try
    // Verifica se l'utente che invia la richiesta ha i permessi necessari.
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin
      // Verifica se i dati dell'utente sono validi
      if (checkDataUtente(aNome, aCognome, aEmail, aPsw)) then
      begin
        // Aggiorna le informazioni dell'utente
        if (lUtente.Update(aNome, aCognome, aEmail, aPsw, aPermessi, aId)) then
        begin
          // Se l'aggiornamento � riuscito, imposta il risultato in JSONResponse e lo renderizza
          JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
          render(JSONResponse, false);

        end;
      end

      else
      begin
        // Se i dati dell'utente non sono validi, imposta il risultato in JSONResponse e lo renderizza con stato 500
        JSONResponse.S['Result'] := 'Modifica non avvenuta';
        render(500, JSONResponse, false);
      end;
    end
    else
    begin
      // Se l'utente non ha i permessi richiesti, imposta il risultato in JSONResponse e lo renderizza con stato 403
      JSONResponse.S['Result'] := 'Non hai i permessi';
      render(403, JSONResponse, false);
    end;

  finally
    JSONResponse.Free;
    lUtente.Free;

  end;
end;

procedure TApp1MainController.GetListUtenti(aFiltro: String);
var
  lUtente: tUtenti; // Oggetto utente per gestire l'ottenimento della lista.
  lFDQuery: tFDQuery; // Oggetto FDQuery per eseguire la query sul database.
  lJSONArray: TJsonArray;
  // Oggetto JSONArray per creare una lista di oggetti JSON.
  lJSONRecord: TJsonObject;
  // Oggetto JsonObject per rappresentare un singolo record JSON.

begin

  lUtente := tUtenti.Create;
  // Esecuzione della query per ottenere la lista degli utenti in base al filtro specificato.
  lFDQuery := lUtente.getList(aFiltro);
  if (lFDQuery <> nil) then
  begin
    // Creazione di un array JSON per contenere la lista degli utenti.
    lJSONArray := TJsonArray.Create;

    try
      // Scorrimento dei record nella query.
      while (not lFDQuery.Eof) do
      begin
        // Creazione di un oggetto JSON per rappresentare un singolo record.
        lJSONRecord := TJsonObject.Create;
        // Popolamento del record JSON con i dati del record corrente nella query.
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONRecord.S['cognome'] := lFDQuery.FieldByName('cognome').AsString;
        lJSONRecord.S['email'] := lFDQuery.FieldByName('email').AsString;
        lJSONRecord.S['permessi'] := lFDQuery.FieldByName('permessi').AsString;
        // Aggiunta del record JSON all'array JSON.
        lJSONArray.Add(lJSONRecord);
        // Passaggio al record successivo nella query.
        lFDQuery.Next;
      end;
      // Invio dell'array JSON al client.
      render(lJSONArray, false);
    finally
      // Libera le risorse allocate.
      lJSONArray.Free;
      lFDQuery.Free;
      lUtente.Free;
    end;
  end;

end;

procedure TApp1MainController.GetNumUtenti();
var
  lUtente: tUtenti;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;

begin

  lUtente := tUtenti.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lUtente.GetNumUtenti();
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse.I['nUtentiPerm'] := lFDQuery.FieldByName('amm_perm')
          .AsInteger;
        lJSONResponse.I['nUtentiSenzaPerm'] :=
          lFDQuery.FieldByName('amm_sen_perm').AsInteger;
        lJSONResponse.I['nUtentiTot'] :=
          lFDQuery.FieldByName('somma_amministratori').AsInteger;

      end;
      render(lJSONResponse, false);
    end;

  finally
    lJSONResponse.Free;
    lFDQuery.Free;
  end;
end;

procedure TApp1MainController.GetProfilo(aToken: String);
var
  lUtente: tUtenti; // Oggetto utente per gestire l'ottenimento del profilo.
  lIdUtente: SmallInt; // ID dell'utente ottenuto dal token.
  lFDQuery: tFDQuery; // Oggetto FDQuery per eseguire la query sul database.
  lJSONResponse: TJsonObject;
  // Oggetto JsonObject per rappresentare il profilo JSON.

begin
  lUtente := tUtenti.Create;
  // Creazione di un oggetto JSON per rappresentare la risposta JSON.
  lJSONResponse := TJsonObject.Create;
  try
    begin
      // Ottenimento dell'ID dell'utente dal token.
      lIdUtente := lUtente.getIdByToken(aToken);
      if (lIdUtente > 0) then
      begin
        // Esecuzione della query per ottenere il profilo dell'utente.
        lFDQuery := lUtente.GetUtente(lIdUtente);

        if (lFDQuery <> nil) then
        begin
          // Posizionamento sulla prima riga della query.
          lFDQuery.First;
          if (not lFDQuery.Eof) then
          begin
            // Popolamento dell'oggetto JSON con i dati del profilo dell'utente.
            lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
            lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
            lJSONResponse.S['cognome'] :=
              lFDQuery.FieldByName('cognome').AsString;
            lJSONResponse.S['email'] := lFDQuery.FieldByName('email').AsString;
            lJSONResponse.S['permessi'] :=
              lFDQuery.FieldByName('permessi').AsString;

          end;
          // Invio della risposta JSON al client.
          render(lJSONResponse, false);
          // Libera le risorse della query.
          lFDQuery.Free;
        end;
      end
      else
      begin
        // Se non esiste l'ID dell'utente, imposta un messaggio di errore nella risposta JSON.
        lJSONResponse.S['Result'] := 'Non esiste questo token';
        // Utilizza il metodo render con codice di stato 404 per indicare risorsa non trovata.
        render(404, lJSONResponse, false);
      end;
    end;
  finally
    lJSONResponse.Free;
    lUtente.Free;
  end;

end;

procedure TApp1MainController.GetUtente(aToken: String; aFiltro: SmallInt);
var
  lUtente: tUtenti;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;

begin

  lUtente := tUtenti.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lUtente.GetUtente(aFiltro);
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONResponse.S['cognome'] := lFDQuery.FieldByName('cognome').AsString;
        lJSONResponse.S['password'] := lFDQuery.FieldByName('password')
          .AsString;
        lJSONResponse.S['email'] := lFDQuery.FieldByName('email').AsString;
        lJSONResponse.S['permessi'] := lFDQuery.FieldByName('permessi')
          .AsString;

      end;
      render(lJSONResponse, false);
    end
    else
    begin
      lJSONResponse.S['Result'] := 'No!';
      render(403, lJSONResponse, false);
    end;

  finally
    lJSONResponse.Free;
    lFDQuery.Free;
    lUtente.Free;
  end;
end;

procedure TApp1MainController.GetListEdifici(aFiltro: String);
var
  lEdificio: tEdifici;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;

begin

  lEdificio := tEdifici.Create;
  lFDQuery := lEdificio.getList(aFiltro);
  if (lFDQuery <> nil) then
  begin

    lJSONArray := TJsonArray.Create;

    try
      while (not lFDQuery.Eof) do

      begin
        lJSONRecord := TJsonObject.Create;
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONArray.Add(lJSONRecord);
        lFDQuery.Next;
      end;
      render(lJSONArray, false);
    finally
      lJSONArray.Free;
      lFDQuery.Free;
      lEdificio.Free;
    end;
  end;

end;

procedure TApp1MainController.AggiungiEvento(aNome: String;
  aDataOraInizio, aDataOraFine: String; aTipo, aToken: String;
  aIdDestinazione, aIdResponsabile: SmallInt);
var
  lUtente: tUtenti;
  lEvento: tEventi;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lEvento := tEventi.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin

      if (checkDataEvento(aNome, aTipo,
        StrToDateTime(aDataOraInizio.Replace('-', '/')),
        StrToDateTime(aDataOraFine.Replace('-', '/')), aIdResponsabile)) then
      begin
        if (lEvento.aggiungi(aNome, StrToDateTime(aDataOraInizio.Replace('-',
          '/')), StrToDateTime(aDataOraFine.Replace('-', '/')), aTipo,
          aIdDestinazione, lIdUtente, aIdResponsabile)) then
        begin
          JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
          render(JSONResponse, false);
        end
        else
        begin

          JSONResponse.S['Result'] := 'Aggiunta non avvenuta con successo';
          render(500, JSONResponse, false);

        end;
      end;

    end;
  finally

    JSONResponse.Free;
    lEvento.Free;
    lUtente.Free;
  end;

end;

procedure TApp1MainController.RemoveEvento(aToken: String; aId: SmallInt);
var
  lUtente: tUtenti;
  lEvento: tEventi;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lEvento := tEventi.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin
      if (lEvento.Remove(aId)) then
      begin
        JSONResponse.S['Result'] := 'Eliminazione avvenuta con successo';
        render(JSONResponse, false);

      end

      else
      begin
        JSONResponse.S['Result'] := 'Eliminazione non avvenuta';
        render(500, JSONResponse, false);
      end;
    end;

  finally
    JSONResponse.Free;
    lEvento.Free;
    lUtente.Free;
  end;
end;

procedure TApp1MainController.UpdateEvento(aNome, aDataOraInizio, aDataOraFine,
  aTipo, aToken: String; aIdDestinazione, aIdResponsabile, aId: SmallInt);
var
  lUtente: tUtenti;
  lEvento: tEventi;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lEvento := tEventi.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin

      if (checkDataEvento(aNome, aTipo,
        StrToDateTime(aDataOraInizio.Replace('-', '/')),
        StrToDateTime(aDataOraFine.Replace('-', '/')), aIdResponsabile)) then
      begin
        if (lEvento.Update(aNome, StrToDateTime(aDataOraInizio.Replace('-', '/')
          ), StrToDateTime(aDataOraFine.Replace('-', '/')), aTipo,
          aIdDestinazione, lIdUtente, aIdResponsabile, aId)) then

        begin
          JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
          render(JSONResponse, false);

        end

        else
        begin
          JSONResponse.S['Result'] := 'Modifica non avvenuta';
          render(500, JSONResponse, false);
        end;
      end;
    end;
  finally
    JSONResponse.Free;
    lEvento.Free;
    lUtente.Free;
  end;
end;

procedure TApp1MainController.GetListEventi(aFiltro: String);

var
  lEvento: tEventi;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;
begin
  lEvento := tEventi.Create;
  lFDQuery := lEvento.getList(aFiltro);
  if (lFDQuery <> nil) then
  begin

    lJSONArray := TJsonArray.Create;
    try
      while (not lFDQuery.Eof) do
      begin
        lJSONRecord := TJsonObject.Create;
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONRecord.S['data_ora_inizio'] :=
          lFDQuery.FieldByName('data_ora_inizio').AsString;
        lJSONRecord.S['data_ora_fine'] :=
          lFDQuery.FieldByName('data_ora_fine').AsString;
        lJSONRecord.S['tipo'] := lFDQuery.FieldByName('tipo').AsString;
        lJSONRecord.S['destinazione'] := lFDQuery.FieldByName('ndset').AsString;
        lJSONRecord.S['utente'] := lFDQuery.FieldByName('nadmin').AsString;
        lJSONRecord.S['responsabile'] := lFDQuery.FieldByName('nresp').AsString
          + ' ' + lFDQuery.FieldByName('cognome').AsString;

        lJSONArray.Add(lJSONRecord);
        lFDQuery.Next;
      end;
      render(lJSONArray, false);
    finally
      lJSONArray.Free;
      lFDQuery.Free;
      lEvento.Free;
    end;

  end;
end;

procedure TApp1MainController.GetEvento(aFiltro: SmallInt);
var
  lEvento: tEventi;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;
begin
  lEvento := tEventi.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lEvento.GetEvento(aFiltro);
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONResponse.S['data_ora_inizio'] :=
          lFDQuery.FieldByName('data_ora_inizio').AsString;
        lJSONResponse.S['data_ora_fine'] :=
          lFDQuery.FieldByName('data_ora_fine').AsString;
        lJSONResponse.S['tipo'] := lFDQuery.FieldByName('tipo').AsString;
        lJSONResponse.I['destinazione'] := lFDQuery.FieldByName('destinazione')
          .AsInteger;
        lJSONResponse.I['utente'] := lFDQuery.FieldByName('utente').AsInteger;
        lJSONResponse.I['responsabile'] := lFDQuery.FieldByName('responsabile')
          .AsInteger;

      end;
      render(lJSONResponse, false);

    end;
  finally
    lJSONResponse.Free;
    lFDQuery.Free;
    lEvento.Free;
  end;

end;

procedure TApp1MainController.GetNumEventi;
var
  lEvento: tEventi;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;
begin
  lEvento := tEventi.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lEvento.GetNumEventi();
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse.I['nEventiMese'] := lFDQuery.FieldByName('eventi_mese')
          .AsInteger;
        lJSONResponse.I['nEventiGiorno'] :=
          lFDQuery.FieldByName('eventi_giorno').AsInteger;
        lJSONResponse.I['nEventiTot'] := lFDQuery.FieldByName('eventi_totali')
          .AsInteger;

      end;
      render(lJSONResponse, false);
    end;

  finally
    lJSONResponse.Free;
    lFDQuery.Free;
  end;
end;

procedure TApp1MainController.AggiungiResponsabile(aNome, aCognome,
  aOraInizioRicevimento, aOraFineRicevimento, aToken: String;
  aIdDestinazione: SmallInt);
var
  lUtente: tUtenti;
  lResponsabile: tResponsabili;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lResponsabile := tResponsabili.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin
      if (checkDataResponsabile(aNome, aCognome, aOraInizioRicevimento,
        aOraFineRicevimento, aIdDestinazione)) then
      begin

        if (lResponsabile.aggiungi(aNome, aCognome,
          StrToDateTime(aOraInizioRicevimento),
          StrToDateTime(aOraFineRicevimento), aIdDestinazione)) then

        begin
          JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
          render(JSONResponse, false);
        end

        else
        begin
          JSONResponse.S['Result'] := 'Aggiunta non avvenuta con successo';
          render(500, JSONResponse, false);
        end;
      end
      else
      begin
        JSONResponse.S['Result'] :=
          'Aggiunta non avvenuta con successo perch� i campi so sbagliti';
        render(400, JSONResponse, false);
      end;
    end;
  finally
    JSONResponse.Free;
    lResponsabile.Free;
    lUtente.Free;

  end;
end;

procedure TApp1MainController.RemoveResponsabile(aToken: String; aId: SmallInt);
var
  lUtente: tUtenti;
  lResponsabile: tResponsabili;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lResponsabile := tResponsabili.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin
      if (lResponsabile.Remove(aId)) then

      begin
        JSONResponse.S['Result'] := 'Eliminazione avvenuta con successo';
        render(JSONResponse, false);

      end

      else
      begin
        JSONResponse.S['Result'] := 'Eliminazione non avvenuta';
        render(500, JSONResponse, false);
      end;
    end;

  finally
    JSONResponse.Free;
    lResponsabile.Free;
    lUtente.Free;
  end;
end;

procedure TApp1MainController.UpdateResponsabile(aNome, aCognome,
  aOraInizioRicevimento, aOraFineRicevimento, aToken: String;
  aIdDestinazione, aId: SmallInt);
var
  lUtente: tUtenti;
  lResponsabile: tResponsabili;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lResponsabile := tResponsabili.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin
      if (checkDataResponsabile(aNome, aCognome, aOraInizioRicevimento,
        aOraFineRicevimento, aIdDestinazione)) then
      begin
        if (lResponsabile.Update(aNome, aCognome,
          StrToDateTime(aOraInizioRicevimento),
          StrToDateTime(aOraFineRicevimento), aIdDestinazione, aId)) then

        begin
          JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
          render(JSONResponse, false);

        end

        else
        begin
          JSONResponse.S['Result'] := 'Modifica non avvenuta';
          render(500, JSONResponse, false);
        end;
      end;
    end;
  finally

    JSONResponse.Free;
    lResponsabile.Free;
    lUtente.Free;

  end;
end;

procedure TApp1MainController.GetListResponsabile(aFiltro: String);
var
  lResponsabile: tResponsabili;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;
begin
  lResponsabile := tResponsabili.Create;
  lFDQuery := lResponsabile.getList(aFiltro);
  if (lFDQuery <> nil) then
  begin

    lJSONArray := TJsonArray.Create;
    try
      while (not lFDQuery.Eof) do
      begin
        lJSONRecord := TJsonObject.Create;
        lJSONRecord.I['id'] := lFDQuery.FieldByName('ID').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('NOME').AsString;
        lJSONRecord.S['cognome'] := lFDQuery.FieldByName('COGNOME').AsString;
        lJSONRecord.S['orario_inizio_ricevimento'] :=
          lFDQuery.FieldByName('ORA_INIZIO').AsString;
        lJSONRecord.S['orario_fine_ricevimento'] :=
          lFDQuery.FieldByName('ORA_FINE').AsString;
        lJSONRecord.S['destinazione'] := lFDQuery.FieldByName('DNOME').AsString;

        lJSONArray.Add(lJSONRecord);
        lFDQuery.Next;
      end;
      render(lJSONArray, false);
    finally
      lJSONArray.Free;
      lFDQuery.Free;
      lResponsabile.Free;
    end;

  end;
end;

procedure TApp1MainController.GetResponsabile(aFiltro: SmallInt);
var
  lResponsabile: tResponsabili;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;
begin
  lResponsabile := tResponsabili.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lResponsabile.GetResponsabile(aFiltro);
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse := TJsonObject.Create;
        lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONResponse.S['cognome'] := lFDQuery.FieldByName('cognome').AsString;
        lJSONResponse.S['orario_inizio_ricevimento'] :=
          lFDQuery.FieldByName('orario_inizio_ricevimento').AsString;
        lJSONResponse.S['orario_fine_ricevimento'] :=
          lFDQuery.FieldByName('orario_fine_ricevimento').AsString;
        lJSONResponse.I['destinazione'] := lFDQuery.FieldByName('destinazione')
          .AsInteger;

      end;
      render(lJSONResponse, false);
    end;
  finally
    lJSONResponse.Free;
    lFDQuery.Free;
    lResponsabile.Free;

  end;
end;

procedure TApp1MainController.UpdateDestinazione(aStato, aToken: String;
  aId: SmallInt);
var
  lUtente: tUtenti;
  lDestinazione: tDestinazioni;
  JSONResponse: TJsonObject;
  lIdUtente: SmallInt;

begin
  lUtente := tUtenti.Create;
  lDestinazione := tDestinazioni.Create;
  JSONResponse := TJsonObject.Create;

  try
    lIdUtente := lUtente.getIdByToken(aToken);
    if (lIdUtente > 0) then
    begin
      if (lDestinazione.Update(aStato, aId)) then

      begin
        JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
        render(JSONResponse, false);

      end

      else
      begin
        JSONResponse.S['Result'] := 'Modifica non avvenuta';
        render(500, JSONResponse, false);
      end;
    end;
  finally
    JSONResponse.Free;
    lDestinazione.Free;
    lUtente.Free;

  end;
end;

procedure TApp1MainController.GetListDestinazioni(aFiltro,
  aFiltroStato: String);
var
  lDestinazione: tDestinazioni;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;

begin

  lDestinazione := tDestinazioni.Create;
  lFDQuery := lDestinazione.getList(aFiltro, aFiltroStato);
  if (lFDQuery <> nil) then
  begin

    lJSONArray := TJsonArray.Create;

    try
      while (not lFDQuery.Eof) do
      begin
        lJSONRecord := TJsonObject.Create;
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONRecord.S['stato'] := lFDQuery.FieldByName('stato').AsString;
        lJSONRecord.S['tipo'] := lFDQuery.FieldByName('tipo').AsString;
        lJSONRecord.S['edificio'] := lFDQuery.FieldByName('edificio').AsString;
        lJSONRecord.S['nomeEd'] := lFDQuery.FieldByName('nomeEd').AsString;
        lJSONArray.Add(lJSONRecord);
        lFDQuery.Next;
      end;
      render(lJSONArray, false);
    finally
      lJSONArray.Free;
      lFDQuery.Free;
      lDestinazione.Free;
    end;
  end;

end;

procedure TApp1MainController.GetListDestinazioniUffici(aFiltro: String);
var
  lDestinazione: tDestinazioni;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;

begin

  lDestinazione := tDestinazioni.Create;
  lFDQuery := lDestinazione.getUffici(aFiltro);
  if (lFDQuery <> nil) then
  begin

    lJSONArray := TJsonArray.Create;

    try
      while (not lFDQuery.Eof) do
      begin
        lJSONRecord := TJsonObject.Create;
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONArray.Add(lJSONRecord);
        lFDQuery.Next;
      end;
      render(lJSONArray, false);
    finally
      lJSONArray.Free;
      lFDQuery.Free;
      lDestinazione.Free;
    end;
  end;

end;

procedure TApp1MainController.GetDestinazione(aFiltro: SmallInt);
var
  lDestinazione: tDestinazioni;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;
begin
  lDestinazione := tDestinazioni.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lDestinazione.GetDestinazione(aFiltro);
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse := TJsonObject.Create;
        lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONResponse.S['stato'] := lFDQuery.FieldByName('stato').AsString;
        lJSONResponse.S['tipo'] := lFDQuery.FieldByName('tipo').AsString;
        lJSONResponse.I['edificio'] := lFDQuery.FieldByName('edificio')
          .AsInteger;

      end;
      render(lJSONResponse, false);
    end;
  finally
    lJSONResponse.Free;
    lFDQuery.Free;
    lDestinazione.Free;

  end;
end;

procedure TApp1MainController.GetNumDest;
var
  lDestinazione: tDestinazioni;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;
begin
  lDestinazione := tDestinazioni.Create;
  lJSONResponse := TJsonObject.Create;
  try
    lFDQuery := lDestinazione.getNumAule();
    if (lFDQuery <> nil) then
    begin
      lFDQuery.First;
      if (not lFDQuery.Eof) then
      begin
        lJSONResponse.I['nAuleAcc'] := lFDQuery.FieldByName('aule_accessibili')
          .AsInteger;
        lJSONResponse.I['nAuleNonAcc'] :=
          lFDQuery.FieldByName('aule_non_accessibili').AsInteger;
        lJSONResponse.I['nAuleTot'] := lFDQuery.FieldByName('somma_totale')
          .AsInteger;

      end;
      render(lJSONResponse, false);
    end;
  finally
    lJSONResponse.Free;
    lFDQuery.Free;
    lDestinazione.Free;

  end;
end;

end.
