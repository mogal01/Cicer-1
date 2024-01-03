unit EventiU;

interface

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
  FireDAC.Comp.Client, DbU, System.SysUtils;

type
  tEventi = class
    constructor Create();
    destructor Destroy();
    function aggiungi(aNome: String; aDataOraInizio, aDataOraFine: TDateTime;
      aTipo: String; aIdDestinazione, aIdUtente, aIdResponsabile
      : SmallInt): boolean;
    function remove(aId: SmallInt): boolean;
    function update(aNome: String; aDataOraInizio, aDataOraFine: TDateTime;
      aTipo: String; aIdDestinazione, aIdUtente, aIdResponsabile,
      aId: SmallInt): boolean;
    function getList(aFiltr: String): TFDQuery;
  private
    fDB: tDB;
  end;

implementation

{ tEventi }

constructor tEventi.Create;
begin

  inherited;
  fDB := tDB.Create();

end;

destructor tEventi.Destroy;
begin

  fDB.Free;
  inherited;

end;

function tEventi.aggiungi(aNome: String;
  aDataOraInizio, aDataOraFine: TDateTime; aTipo: String;
  aIdDestinazione, aIdUtente, aIdResponsabile: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
  // aDataOraInizioStr: String;

begin

  result := true;
  // aDataOraInizioStr:= FormatDateTime('dd-mm-yyyy hh:nn:ss', aDataOraInizio);
  try
    lQuery := 'INSERT INTO evento (nome, data_ora_inizio, data_ora_fine, tipo, destinazione, utente, responsabile) VALUES ('
      + QuotedStr(aNome) + ', ' +
      QuotedStr(FormatDateTime('dd-mm-yyyy hh:nn:ss', aDataOraInizio)) + ', ' +
      QuotedStr(FormatDateTime('dd-mm-yyyy hh:nn:ss', aDataOraFine)) + ', ' +
      QuotedStr(aTipo) + ', ' + aIdDestinazione.ToString + ',' +
      aIdUtente.ToString + ',' + aIdResponsabile.ToString + ')';

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tEventi.remove(aId: SmallInt): boolean;

var
  lQuery: String;
  lFDQuery: TFDQuery;

begin
  result := true;
  try
    lQuery := 'DELETE FROM evento WHERE id=' + (aId).ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;
  finally

    lFDQuery.Free;

  end;

end;

function tEventi.update(aNome: String; aDataOraInizio, aDataOraFine: TDateTime;
  aTipo: String; aIdDestinazione, aIdUtente, aIdResponsabile,
  aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := false;

  try
    lQuery := 'UPDATE evento SET nome= ' + QuotedStr(aNome) +
      ' ,data_ora_inizio= ' + QuotedStr(FormatDateTime('dd-mm-yyyy hh:nn:ss',
      aDataOraInizio)) + ', data_ora_fine= ' +
      QuotedStr(FormatDateTime('dd-mm-yyyy hh:nn:ss', aDataOraFine)) + ', tipo='
      + QuotedStr(aTipo) + ', destinazione= ' + aIdDestinazione.ToString +
      ', utente= ' + aIdUtente.ToString + ', responsabile= ' +
      aIdResponsabile.ToString + ' WHERE id=' + aId.ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;
end;

function tEventi.getList(aFiltr: String): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := nil;
  try
    lQuery := 'SELECT * FROM evento where UPPER(nome) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ') or UPPER(tipo) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ')';
    lFDQuery := fDB.getQueryResult(lQuery);
    result := lFDQuery;
  finally

  end;

end;

end.
