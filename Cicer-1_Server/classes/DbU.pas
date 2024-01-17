unit DbU;

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
  FireDAC.Comp.Client;

type

  tDB = class

  Public

    FFDConnection: TfdConnection;
    function connect: TfdConnection;
    function getQueryResult(aQuery: String): TFDQuery;
    function executeQuery(aQuery: String): TFDQuery;

  end;

implementation

{ tDB }

function tDB.connect: TfdConnection;
begin
  // Creazione di un nuovo oggetto TfdConnection
  FFDConnection := TfdConnection.Create(nil);
  // Impostazione del driver per PostgreSQL
  FFDConnection.DriverName := 'PG';
  // Configurazione dei parametri di connessione al database PostgreSQL
  FFDConnection.Params.Add('Server=localhost');
  FFDConnection.Params.Add('Database=Cicer1');
  FFDConnection.Params.Add('User_Name=postgres');
  FFDConnection.Params.Add('Password=159753');
  // Connessione effettiva al database
  FFDConnection.Connected := True;
  // Restituzione dell'oggetto TfdConnection
  result := FFDConnection;
end;

function tDB.getQueryResult(aQuery: String): TFDQuery;
begin
  // Creazione di un nuovo oggetto TFDQuery
  result := TFDQuery.Create(nil);
  // Configurazione della connessione per la query
  result.Connection := connect();
  // Impostazione del testo della query SQL
  result.SQL.Text := aQuery;
  // Esecuzione della query e apertura del set di risultati
  result.Open();
  // Spostamento al primo record nel set di risultati
  result.First;
end;

function tDB.executeQuery(aQuery: String): TFDQuery;
begin
  // Creazione di un nuovo oggetto TFDQuery
  result := TFDQuery.Create(nil);
  // Configurazione della connessione per l'esecuzione della query
  result.Connection := connect();
  // Impostazione del testo della query SQL
  result.SQL.Text := aQuery;
  // Esecuzione della query senza restituzione di un set di risultati
  result.ExecSQL();

end;

end.
