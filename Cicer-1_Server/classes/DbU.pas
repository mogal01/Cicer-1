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
  FFDConnection := TfdConnection.Create(nil);

  FFDConnection.DriverName := 'PG';

  FFDConnection.Params.Add('Server=localhost');
  FFDConnection.Params.Add('Database=Cicer1');
  FFDConnection.Params.Add('User_Name=postgres');
  FFDConnection.Params.Add('Password=159753');
  FFDConnection.Connected := True;

  result := FFDConnection;
end;

function tDB.getQueryResult(aQuery: String): TFDQuery;
begin
  result := TFDQuery.Create(nil);
  result.Connection := connect();
  result.SQL.Text := aQuery;
  result.Open();
  result.First;
end;

function tDB.executeQuery(aQuery: String): TFDQuery;
begin

  result := TFDQuery.Create(nil);
  result.Connection := connect();
  result.SQL.Text := aQuery;
  result.ExecSQL();

end;

end.
