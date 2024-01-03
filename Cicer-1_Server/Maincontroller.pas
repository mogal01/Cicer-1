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
  FireDAC.Comp.Client, DbU, System.SysUtils,
  MVCFramework,
  MVCFramework.Logger,
  MVCFramework.Commons,
  Web.HTTPApp, UtentiU, EdificiU, EventiU, ResponsabiliU, DestinazioniU,
  System.JSON;

type

  [MVCPath('/')]
  TApp1MainController = class(TMVCController)

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

    [MVCPath('/Edificio/Aggiungi/($aNome)')]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiEdificio(aNome: String);

    [MVCPath('/Edificio/Remove/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveEdificio(aId: SmallInt);

    [MVCPath('/Edificio/Update/($aNome)/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateEdificio(aNome: String; aId: SmallInt);

    [MVCPath('/Edificio/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListEdifici(aFiltro: String);

    [MVCPath('/Evento/Aggiungi/($aNome)/($aDataOraInizio)/($aDataOraFine)/($aTipo)/($aIdDestinazione)/($aIdUtente)/($aIdResponsabile)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiEvento(aNome: String;
      aDataOraInizio, aDataOraFine: String; aTipo: String;
      aIdDestinazione, aIdUtente, aIdResponsabile: SmallInt);

    [MVCPath('/Evento/Remove/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveEvento(aId: SmallInt);

    [MVCPath('/Evento/Update/($aNome)/($aDataOraInizio)/($aDataOraFine)/($aTipo)/($aIdDestinazione)/($aIdUtente)/($aIdResponsabile)/($aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateEvento(aNome: String; aDataOraInizio, aDataOraFine: String;
      aTipo: String; aIdDestinazione, aIdUtente, aIdResponsabile,
      aId: SmallInt);

    [MVCPath('/Evento/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListEventi(aFiltro: String);

    [MVCPath('/Responsabile/Aggiungi/($aNome)/($aCognome)/($aOraInizioRicevimento)/($aOraFineRicevimento)/($aIdDestinazione)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiResponsabile(aNome, aCognome, aOraInizioRicevimento,
      aOraFineRicevimento: String; aIdDestinazione: SmallInt);

    [MVCPath('/Responsabile/Remove/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveResponsabile(aId: SmallInt);

    [MVCPath('/Responsabile/Update/($aNome)/($aCognome)/($aOraInizioRicevimento)/($aOraFineRicevimento)/($aIdDestinazione)/(%aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateResponsabile(aNome, aCognome, aOraInizioRicevimento,
      aOraFineRicevimento: String; aIdDestinazione, aId: SmallInt);

    [MVCPath('/Responsabile/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListResponsabile(aFiltro: String);

    [MVCPath('/Destinazione/Aggiungi/($aNome)/($aStato)/($aTipo)/($aIdEdificio)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure AggiungiDestinazione(aNome, aStato, aTipo: String;
      aIdEdificio: SmallInt);

    [MVCPath('/Destinazione/Remove/($aId)')]
    [MVCHTTPMethod([httpPOST])]
    procedure RemoveDestinazione(aId: SmallInt);

    [MVCPath('/Destinazione/Update/($aNome)/($aStato)/($aTipo)/($aIdEdificio)/($aId)')
      ]
    [MVCHTTPMethod([httpPOST])]
    procedure UpdateDestinazione(aNome, aStato, aTipo: String;
      aIdEdificio, aId: SmallInt);

    [MVCPath('/Destinazione/GetList/($aFiltro)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetListDestinazioni(aFiltro: String);

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

      if (lUtente.aggiungi(aNome, aCognome, aEmail, aPsw, aPermessi)) then
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

      if (lUtente.Update(aNome, aCognome, aEmail, aPsw, aPermessi, aId)) then
      begin
        JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
        render(JSONResponse, false);

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

procedure TApp1MainController.AggiungiEdificio(aNome: String);

var
  lEdificio: tEdifici;
  JSONResponse: TJsonObject;

begin
  lEdificio := tEdifici.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lEdificio.aggiungi(aNome)) then

    begin
      JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
      render(JSONResponse, false);
    end

    else
    begin
      JSONResponse.S['Result'] := 'Aggiunta non avvenuta con successo';
      render(500, JSONResponse, false);
    end;
  finally
    JSONResponse.Free;
    lEdificio.Free;

  end;
end;

procedure TApp1MainController.RemoveEdificio(aId: SmallInt);

var
  lEdificio: tEdifici;
  JSONResponse: TJsonObject;

begin
  lEdificio := tEdifici.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lEdificio.Remove(aId)) then
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
    lEdificio.Free;
  end;
end;

procedure TApp1MainController.UpdateEdificio(aNome: String; aId: SmallInt);

var
  lEdificio: tEdifici;
  JSONResponse: TJsonObject;

begin
  lEdificio := tEdifici.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lEdificio.Update(aNome, aId)) then

    begin
      JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
      render(JSONResponse, false);

    end

    else
    begin
      JSONResponse.S['Result'] := 'Modifica non avvenuta';
      render(500, JSONResponse, false);
    end;

  finally
    JSONResponse.Free;
    lEdificio.Free;
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
  aDataOraInizio, aDataOraFine: String; aTipo: String;
  aIdDestinazione, aIdUtente, aIdResponsabile: SmallInt);
var
  lEvento: tEventi;
  JSONResponse: TJsonObject;

begin
  lEvento := tEventi.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lEvento.aggiungi(aNome, StrToDateTime(aDataOraInizio.Replace('-', '/')),
      StrToDateTime(aDataOraFine.Replace('-', '/')), aTipo, aIdDestinazione,
      aIdUtente, aIdResponsabile)) then

    begin

      JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
      render(JSONResponse, false);

    end

    else

    begin

      JSONResponse.S['Result'] := 'Aggiunta non avvenuta con successo';
      render(500, JSONResponse, false);

    end;
  finally
    JSONResponse.Free;
    lEvento.Free;
  end;

end;

procedure TApp1MainController.RemoveEvento(aId: SmallInt);
var
  lEvento: tEventi;
  JSONResponse: TJsonObject;
begin
  lEvento := tEventi.Create;
  JSONResponse := TJsonObject.Create;

  try

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

  finally
    JSONResponse.Free;
    lEvento.Free;
  end;
end;

procedure TApp1MainController.UpdateEvento(aNome, aDataOraInizio, aDataOraFine,
  aTipo: String; aIdDestinazione, aIdUtente, aIdResponsabile, aId: SmallInt);
var
  lEvento: tEventi;
  JSONResponse: TJsonObject;

begin
  lEvento := tEventi.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lEvento.Update(aNome, StrToDateTime(aDataOraInizio.Replace('-', '/')),
      StrToDateTime(aDataOraFine.Replace('-', '/')), aTipo, aIdDestinazione,
      aIdUtente, aIdResponsabile, aId)) then

    begin
      JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
      render(JSONResponse, false);

    end

    else
    begin
      JSONResponse.S['Result'] := 'Modifica non avvenuta';
      render(500, JSONResponse, false);
    end;
  finally
    JSONResponse.Free;
    lEvento.Free;
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
        lJSONRecord.I['destinazione'] := lFDQuery.FieldByName('destinazione')
          .AsInteger;
        lJSONRecord.I['utente'] := lFDQuery.FieldByName('utente').AsInteger;
        lJSONRecord.I['responsabile'] := lFDQuery.FieldByName('responsabile')
          .AsInteger;

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

procedure TApp1MainController.AggiungiResponsabile(aNome, aCognome,
  aOraInizioRicevimento, aOraFineRicevimento: String;
  aIdDestinazione: SmallInt);
var
  lResponsabile: tResponsabili;
  JSONResponse: TJsonObject;

begin
  lResponsabile := tResponsabili.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lResponsabile.aggiungi(aNome, aCognome,
      StrToDateTime(aOraInizioRicevimento), StrToDateTime(aOraFineRicevimento),
      aIdDestinazione)) then

    begin
      JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
      render(JSONResponse, false);
    end

    else
    begin
      JSONResponse.S['Result'] := 'Aggiunta non avvenuta con successo';
      render(500, JSONResponse, false);
    end;
  finally
    JSONResponse.Free;
    lResponsabile.Free;

  end;
end;

procedure TApp1MainController.RemoveResponsabile(aId: SmallInt);
var
  lResponsabile: tResponsabili;
  JSONResponse: TJsonObject;

begin
  lResponsabile := tResponsabili.Create;
  JSONResponse := TJsonObject.Create;

  try
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

  finally
    JSONResponse.Free;
    lResponsabile.Free;
  end;
end;

procedure TApp1MainController.UpdateResponsabile(aNome, aCognome,
  aOraInizioRicevimento, aOraFineRicevimento: String;
  aIdDestinazione, aId: SmallInt);
var
  lResponsabile: tResponsabili;
  JSONResponse: TJsonObject;

begin
  lResponsabile := tResponsabili.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lResponsabile.Update(aNome, aCognome,
      StrToDateTime(aOraInizioRicevimento), StrToDateTime(aOraFineRicevimento),
      aIdDestinazione, aId)) then

    begin
      JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
      render(JSONResponse, false);

    end

    else
    begin
      JSONResponse.S['Result'] := 'Modifica non avvenuta';
      render(500, JSONResponse, false);
    end;
  finally
    JSONResponse.Free;
    lResponsabile.Free;

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

procedure TApp1MainController.AggiungiDestinazione(aNome, aStato, aTipo: String;
  aIdEdificio: SmallInt);
var
  lDestinazione: tDestinazioni;
  JSONResponse: TJsonObject;

begin
  lDestinazione := tDestinazioni.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lDestinazione.aggiungi(aNome, aStato, aTipo, aIdEdificio)) then

    begin
      JSONResponse.S['Result'] := 'Aggiunta avvenuta con successo';
      render(JSONResponse, false);
    end

    else
    begin
      JSONResponse.S['Result'] := 'Aggiunta non avvenuta con successo';
      render(500, JSONResponse, false);
    end;
  finally
    JSONResponse.Free;
    lDestinazione.Free;

  end;
end;

procedure TApp1MainController.RemoveDestinazione(aId: SmallInt);
var
  lDestinazione: tDestinazioni;
  JSONResponse: TJsonObject;

begin
  lDestinazione := tDestinazioni.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lDestinazione.Remove(aId)) then

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
    lDestinazione.Free;

  end;
end;

procedure TApp1MainController.UpdateDestinazione(aNome, aStato, aTipo: String;
  aIdEdificio, aId: SmallInt);
var
  lDestinazione: tDestinazioni;
  JSONResponse: TJsonObject;

begin
  lDestinazione := tDestinazioni.Create;
  JSONResponse := TJsonObject.Create;

  try
    if (lDestinazione.Update(aNome, aStato, aTipo, aIdEdificio, aId)) then

    begin
      JSONResponse.S['Result'] := 'Modifica avvenuta con successo';
      render(JSONResponse, false);

    end

    else
    begin
      JSONResponse.S['Result'] := 'Modifica non avvenuta';
      render(500, JSONResponse, false);
    end;
  finally
    JSONResponse.Free;
    lDestinazione.Free;

  end;
end;

procedure TApp1MainController.GetListDestinazioni(aFiltro: String);
var
  lDestinazione: tDestinazioni;
  lFDQuery: tFDQuery;
  lJSONArray: TJsonArray;
  lJSONRecord: TJsonObject;

begin

  lDestinazione := tDestinazioni.Create;
  lFDQuery := lDestinazione.getList(aFiltro);
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

end.
