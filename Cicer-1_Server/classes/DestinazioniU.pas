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
    function update(aStato: String; aId: SmallInt): boolean;
    function getList(aFiltr, aFiltrStato: String): TFDQuery;
    function getUffici(aFiltr: String): TFDQuery;
    function getDestinazione(aFiltr: SmallInt): TFDQuery;
    function getNumAule():TFDQuery;
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

function tDestinazioni.update(aStato: String; aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := true;
  try
    lQuery := 'UPDATE destinazione SET  stato= ' + QuotedStr(aStato) +
      ' WHERE id=' + aId.ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tDestinazioni.getDestinazione(aFiltr: SmallInt): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := nil;
  try
    lQuery := 'SELECT *  FROM destinazione WHERE id= ' + aFiltr.ToString;

    lFDQuery := fDB.getQueryResult(lQuery);

    result := lFDQuery;
  finally

  end;
end;

function tDestinazioni.getList(aFiltr, aFiltrStato: String): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := nil;
  try
    lQuery := 'SELECT destinazione.id,destinazione.nome,destinazione.stato,destinazione.tipo, destinazione.edificio,edificio.nome as nomeEd FROM destinazione join edificio on destinazione.edificio=edificio.id WHERE (UPPER(destinazione.nome) LIKE UPPER('
      + QuotedStr('%' + aFiltr + '%') + ') or UPPER(tipo) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + '))';

    if (not aFiltrStato.IsEmpty) then
    begin
      lQuery := lQuery + ' and destinazione.stato= ' +
        QuotedStr(aFiltrStato);
    end;

    lFDQuery := fDB.getQueryResult(lQuery);
    result := lFDQuery;

  finally

  end;

end;

function tDestinazioni.getNumAule: TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := nil;
  try
    lQuery :='select *, x.aule_accessibili + y.aule_non_accessibili as somma_totale '+
              'from (	(SELECT COUNT(*) AS aule_accessibili FROM destinazione WHERE tipo=''AULA'' and stato=''ACCESSIBILE'')) as x, '+
              '((SELECT COUNT(*) AS aule_non_accessibili FROM destinazione WHERE  tipo=''AULA'' and stato=''NON ACCESSIBILE''))as y';

    lFDQuery := fDB.getQueryResult(lQuery);
    result := lFDQuery;

  finally

  end;

end;

function tDestinazioni.getUffici(aFiltr: String): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := nil;
  try
    lQuery := 'SELECT id, nome  FROM destinazione WHERE UPPER(tipo) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ')';

    lFDQuery := fDB.getQueryResult(lQuery);
    result := lFDQuery;

  finally

  end;

end;

end.
