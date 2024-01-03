unit DestinazioniU;

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
  tDestinazioni = class

    constructor Create();
    destructor Destroy();

    function aggiungi(aNome, aStato, aTipo: String;
      aIdEdificio: SmallInt): boolean;
    function remove(aId: SmallInt): boolean;
    function update(aNome, aStato, aTipo: String;
      aIdEdificio, aId: SmallInt): boolean;
    function getList(aFiltr: String): TFDQuery;
  private
    fDB: tDB;
  end;

implementation

{ tDestinazioni }

constructor tDestinazioni.Create;
begin

  inherited;
  fDB := tDB.Create();

end;

destructor tDestinazioni.Destroy;
begin

  inherited;
  fDB := tDB.Create();

end;

function tDestinazioni.aggiungi(aNome, aStato, aTipo: String;
  aIdEdificio: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := true;
  try
    lQuery := 'INSERT INTO destinazione (nome, stato, tipo, edificio) VALUES ('
      + QuotedStr(aNome) + ', ' + QuotedStr(aStato) + ', ' + QuotedStr(aTipo) +
      ', ' + aIdEdificio.ToString + ')';

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tDestinazioni.remove(aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin
  result := true;
  try
    lQuery := 'DELETE FROM destinazione WHERE id=' + (aId).ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;
  finally

    lFDQuery.Free;

  end;

end;

function tDestinazioni.update(aNome, aStato, aTipo: String;
  aIdEdificio, aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := true;
  try
    lQuery := 'UPDATE destinazione SET nome = ' + QuotedStr(aNome) + ', stato= '
      + QuotedStr(aStato) + ', tipo=' + QuotedStr(aTipo) + ', edificio=' +
      aIdEdificio.ToString + ' WHERE id=' + aId.ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tDestinazioni.getList(aFiltr: String): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := nil;
  try
    lQuery := 'SELECT *  FROM destinazione WHERE UPPER(nome) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ') or UPPER(stato) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ') or UPPER(tipo) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ')';

    lFDQuery := fDB.getQueryResult(lQuery);
    result := lFDQuery;

  finally

  end;

end;

end.
