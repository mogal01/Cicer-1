unit EdificiU;

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
  tEdifici = class
    constructor Create();
    destructor Destroy();
    function aggiungi(aNome: String): boolean;
    function remove(aId: SmallInt): boolean;
    function update(aNome: String; aId: SmallInt): boolean;
    function getList(aFiltr: String): TFDQuery;
    function getEdificio(aFiltr:SmallInt):TFDQuery;

  private
    fDB: tDB;
  end;

implementation

{ tEdifici }

constructor tEdifici.Create;
begin

  inherited;
   fDB := tDB.create();

end;

destructor tEdifici.Destroy;
begin

  fDB.Free;
  inherited;

end;

function tEdifici.aggiungi(aNome: String): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := false;

  try
    lQuery := 'INSERT INTO edificio (nome) VALUES (' + QuotedStr(aNome) + ')';

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;
end;

function tEdifici.remove(aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := false;

  try
    lQuery := 'DELETE FROM edificio WHERE id=' + (aId).ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tEdifici.update(aNome: String; aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin
  result := false;

  try
    lQuery := 'UPDATE edificio SET nome= ' + QuotedStr(aNome) + ' WHERE id=' +
      aId.ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tEdifici.getEdificio(aFiltr: SmallInt): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := nil;
  try
    lQuery := 'SELECT *  FROM edificio WHERE id= '+aFiltr.ToString;

    lFDQuery := fDB.getQueryResult(lQuery);

    result := lFDQuery;
  finally

  end;
end;

function tEdifici.getList(aFiltr: String): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin
  result := nil;
  try
    lQuery := 'SELECT * FROM evento where UPPER(nome) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ')';

    lFDQuery := fDB.getQueryResult(lQuery);
    result := lFDQuery;
  finally

  end;

end;

end.
