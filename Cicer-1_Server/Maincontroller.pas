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

    [MVCPath('/Responsabile/Aggiungi/($aNome)/($aCognome)/($aOraInizioRicevimento)/($aOraFineRicevimento)/($aToken)/($aIdDestinazione )')
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
    procedure GetListDestinazioni(aFiltro,aFiltroStato: String);

    [MVCPath('/Destinazione/GetUffici/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListDestinazioniUffici(aFiltro: String);

    [MVCPath('/Destinazione/GetDestinazione/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetDestinazione(aFiltro: SmallInt);

  end;

implementation

uses MVCFramework.Serializer.JSONDataObjects,
  MVCFramework.Serializer.Commons, JSONDataObjects;

procedure TApp1MainController.Index;
begin
  Redirect('/app/index.html');
end;

procedure TApp1MainController.LogIn(aEmail, aPsw: String);
var
  lUtente: tUtenti;
  JSONResponse: TJsonObject;
  lToken: String;

begin
  lUtente := tUtenti.Create;
  JSONResponse := TJsonObject.Create;

  try

    lToken := lUtente.LogIn(aEmail, aPsw);
    if (lToken <> '') then
    begin
      JSONResponse.S['Result'] := 'Bentornato amico!';
      JSONResponse.S['token'] := lToken;
      render(JSONResponse, false);
    end
    else
    begin
      JSONResponse.S['Result'] := 'Chi sei? Goku non lo sai!';
      render(403, JSONResponse, false);
    end;

  finally
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

    if (lUtente.LogOut(aToken)) then
    begin
      JSONResponse.S['Result'] := 'Eliminazione avvenuta con successo';
      render(JSONResponse, false);

    end

    else
    begin
      JSONResponse.S['Result'] := 'Eliminazione non avvenuta';
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
  EmailRegexPattern = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$';
var
  carattere: Char;
  checkNome: Boolean;
  checkCognome: Boolean;
  checkEmail: Boolean;
begin
  checkNome := aNome <> ''; // La stringa non � vuota
  checkCognome := aCognome <> '';
  if (checkNome) then
  begin
    for carattere in aNome do
    begin
      if not TCharacter.IsLetter(carattere) then
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
      if not TCharacter.IsLetter(carattere) then
      begin
        checkCognome := false;
        Break;
      end;
    end;
  end;
  checkEmail := TRegEx.IsMatch(aEmail, EmailRegexPattern);
  if (checkNome and checkCognome and (Length(aPsw) >= 6) and
    (Length(aPsw) <= 20) and checkEmail) then
  begin
    result := true;
  end
  else
  begin
    result := false;
  end;

end;

function TApp1MainController.checkDataEvento(aNome, aTipo: String;
  aDataOraInizio, aDataOraFine: TDateTime; aIdResponsabile: SmallInt): Boolean;

begin

  if ((aNome = '') or (Length(aNome) > 50)) then
  begin
    result := false;
  end
  else
  begin
    if ((aTipo = 'Lezione') or (aTipo = 'Laurea') or (aTipo = 'Convegno') or
      (aTipo = 'Esame') or (aTipo = 'Orientamento')) then
    begin
      if (CompareDateTime(aDataOraInizio, aDataOraFine) <= 0) then
        result := true;
    end;
  end;

end;

function TApp1MainController.checkDataResponsabile(aNome, aCognome,
  aOraInizioRic, aOraFineRic: String; aDestinazione: SmallInt): Boolean;
var
  oraInizio: TDateTime;
  oraFine: TDateTime;
begin
  oraInizio := StrToDateTime(aOraInizioRic);
  oraFine := StrToDateTime(aOraFineRic);
  if (((aNome = '') or (Length(aNome) > 50)) and
    ((aCognome = '') or (Length(aCognome) > 50))) then
  begin
    result := false;
  end
  else
  begin
    if ((CompareTime(oraInizio, oraFine) <= 0) and (aDestinazione > 0)) then
      result := true;
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
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin

      if (checkDataUtente(aNome, aCognome, aEmail, aPsw)) then
      begin
        if (lUtente.aggiungi(aNome, aCognome, aEmail, aPsw, aPermessi)) then
        begin
          JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
          render(JSONResponse, false);

        end
        else
        begin
          JSONResponse.S['Result'] := 'Aggiunta non avvenuta perch� gi� esiste';
          render(500, JSONResponse, false);
        end;
      end
      else
      begin
        JSONResponse.S['Result'] :=
          'Aggiunta non avvenuta con successo perch� i campi so sbagliti';
        render(500, JSONResponse, false);
      end;

    end
    else
    begin
      JSONResponse.S['Result'] := 'Non hai i permessi';
      render(403, JSONResponse, false);
    end;

  finally
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
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin

      if (lUtente.Remove(aId)) then
      begin
        JSONResponse.S['Result'] := 'Eliminazione avvenuta con successo';
        render(JSONResponse, false);

      end

      else
      begin
        JSONResponse.S['Result'] := 'Eliminazione non avvenuta';
        render(500, JSONResponse, false);
      end;
    end
    else
    begin
      JSONResponse.S['Result'] := 'Non hai i permessi';
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
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin
      if (checkDataUtente(aNome, aCognome, aEmail, aPsw)) then
      begin
        if (lUtente.Update(aNome, aCognome, aEmail, aPsw, aPermessi, aId)) then
        begin
          JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
          render(JSONResponse, false);

        end;
      end

      else
      begin
        JSONResponse.S['Result'] := 'Modifica non avvenuta';
        render(500, JSONResponse, false);
      end;
    end
    else
    begin
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
  lUtente: tUtenti;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;

begin

  lUtente := tUtenti.Create;
  lFDQuery := lUtente.getList(aFiltro);
  if (lFDQuery <> nil) then
  begin

    lJSONArray := TJsonArray.Create;

    try
      while (not lFDQuery.Eof) do
      begin
        lJSONRecord := TJsonObject.Create;
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONRecord.S['cognome'] := lFDQuery.FieldByName('cognome').AsString;
        lJSONRecord.S['email'] := lFDQuery.FieldByName('email').AsString;
        lJSONRecord.S['permessi'] := lFDQuery.FieldByName('permessi').AsString;
        lJSONArray.Add(lJSONRecord);
        lFDQuery.Next;
      end;
      render(lJSONArray, false);
    finally
      lJSONArray.Free;
      lFDQuery.Free;
      lUtente.Free;
    end;
  end;

end;

procedure TApp1MainController.GetProfilo(aToken: String);
var
  lUtente: tUtenti;
  lIdUtente: SmallInt;
  lFDQuery: tFDQuery;
  lJSONResponse: TJsonObject;

begin
  lUtente := tUtenti.Create;
  lJSONResponse := TJsonObject.Create;
  try
    begin
      lIdUtente := lUtente.getIdByToken(aToken);
      if (lIdUtente > 0) then
      begin
        lFDQuery := lUtente.GetUtente(lIdUtente);

        if (lFDQuery <> nil) then
        begin
          lFDQuery.First;
          if (not lFDQuery.Eof) then
          begin
            lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
            lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
            lJSONResponse.S['cognome'] :=
              lFDQuery.FieldByName('cognome').AsString;
            lJSONResponse.S['email'] := lFDQuery.FieldByName('email').AsString;
            lJSONResponse.S['permessi'] :=
              lFDQuery.FieldByName('permessi').AsString;

          end;
          render(lJSONResponse, false);
          lFDQuery.Free;
        end;
      end
      else
      begin
        lJSONResponse.S['Result'] := 'Non esiste questo token';
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
    if (lUtente.checkAccessFunzionalitaUtenti(aToken)) then
    begin
      lFDQuery := lUtente.GetUtente(aFiltro);
      if (lFDQuery <> nil) then
      begin
        lFDQuery.First;
        if (not lFDQuery.Eof) then
        begin
          lJSONResponse.I['id'] := lFDQuery.FieldByName('id').AsInteger;
          lJSONResponse.S['nome'] := lFDQuery.FieldByName('nome').AsString;
          lJSONResponse.S['cognome'] := lFDQuery.FieldByName('cognome')
            .AsString;
          lJSONResponse.S['password'] :=
            lFDQuery.FieldByName('password').AsString;
          lJSONResponse.S['email'] := lFDQuery.FieldByName('email').AsString;
          lJSONResponse.S['permessi'] :=
            lFDQuery.FieldByName('permessi').AsString;

        end;
        render(lJSONResponse, false);
      end;
    end
    else
    begin
      lJSONResponse.S['Result'] := 'Non hai i permessi';
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
        lJSONRecord.S['responsabile'] := lFDQuery.FieldByName('nresp').AsString;

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
        lJSONRecord.I['id'] := lFDQuery.FieldByName('id').AsInteger;
        lJSONRecord.S['nome'] := lFDQuery.FieldByName('nome').AsString;
        lJSONRecord.S['cognome'] := lFDQuery.FieldByName('cognome').AsString;
        lJSONRecord.S['orario_inizio_ricevimento'] :=
          lFDQuery.FieldByName('orario_inizio_ricevimento').AsString;
        lJSONRecord.S['orario_fine_ricevimento'] :=
          lFDQuery.FieldByName('orario_fine_ricevimento').AsString;
        lJSONRecord.I['destinazione'] := lFDQuery.FieldByName('destinazione')
          .AsInteger;

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

procedure TApp1MainController.GetListDestinazioni(aFiltro,aFiltroStato: String);
var
  lDestinazione: tDestinazioni;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;

begin

  lDestinazione := tDestinazioni.Create;
  lFDQuery := lDestinazione.getList(aFiltro,aFiltroStato);
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

end.
