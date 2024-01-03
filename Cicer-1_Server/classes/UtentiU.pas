unit UtentiU;

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
  tUTenti = class

    constructor Create();
    destructor Destroy();

    function logIn(aEmail, aPsw: String): String;
    function logOut(aToken: String): boolean;
    function aggiungi(aNome, aCognome, aEmail, aPsw, aPermessi: String)
      : boolean;
    function remove(aId: SmallInt): boolean;
    function update(aNome, aCognome, aEmail, aPsw, aPermessi: String;
      aId: SmallInt): boolean;
    function getList(aFiltr: String): TFDQuery;
    function checkAccessFunzionalitaUtenti(aToken: String): boolean;
  private
    fDB: tDB;
  end;

implementation

{ tUTenti }

constructor tUTenti.Create;
begin

  inherited;
  fDB := tDB.Create();

end;

destructor tUTenti.Destroy;
begin

  fDB.Free;
  inherited;

end;

function tUTenti.logIn(aEmail, aPsw: String): String;
var
  lQuery: String;
  lFDQuery: TFDQuery;
  lFDQueryToken: TFDQuery;
  lQueryToken: String;
  lToken: String;

begin

  result := '';

  try
    lQuery := 'Select * from utente where email=' + QuotedStr(aEmail) +
      ' and password= ' + QuotedStr(aPsw);
    lFDQuery := fDB.getQueryResult(lQuery);

    if (lFDQuery.RecordCount = 1) then
    begin

      lToken := TGUID.NewGuid.ToString;

      lQueryToken := 'INSERT INTO token (utente,token) VALUES (' +
        lFDQuery.FieldByName('id').AsString + ',' + QuotedStr(lToken) + ')';
      lFDQueryToken := fDB.executeQuery(lQueryToken);
      result := lToken;
      lFDQueryToken.Free;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tUTenti.logOut(aToken: String): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin
  result := false;
  try
    lQuery := 'DELETE FROM token WHERE token=' + QuotedStr(aToken);

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tUTenti.aggiungi(aNome, aCognome, aEmail, aPsw,
  aPermessi: String): boolean;

var
  lQuery: String;
  lFDQuery: TFDQuery;

begin

  result := false;

  try
    lQuery := 'INSERT INTO utente (nome, cognome, email, password, permessi) VALUES ('
      + QuotedStr(aNome) + ', ' + QuotedStr(aCognome) + ', ' + QuotedStr(aEmail)
      + ', ' + QuotedStr(aPsw) + ', ' + QuotedStr(aPermessi) + ')';

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;
end;

function tUTenti.remove(aId: SmallInt): boolean;

var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := false;

  try
    lQuery := 'DELETE FROM utente WHERE id=' + (aId).ToString;

    lFDQuery := fDB.executeQuery(lQuery);

    if (lFDQuery.RowsAffected > 0) then
    begin

      result := true;

    end;

  finally

    lFDQuery.Free;

  end;

end;

function tUTenti.update(aNome, aCognome, aEmail, aPsw, aPermessi: String;
  aId: SmallInt): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := false;

  try
    lQuery := 'UPDATE utente SET nome= ' + QuotedStr(aNome) + ' ,cognome= ' +
      QuotedStr(aCognome) + ', email= ' + QuotedStr(aEmail) + ', password=' +
      QuotedStr(aPsw) + ', permessi= ' + QuotedStr(aPermessi) + ' WHERE id=' +
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

function tUTenti.getList(aFiltr: String): TFDQuery;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin

  result := nil;
  try
    lQuery := 'SELECT *  FROM utente WHERE UPPER(nome) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ') or UPPER(cognome) LIKE UPPER(' +
      QuotedStr('%' + aFiltr + '%') + ')';

    lFDQuery := fDB.getQueryResult(lQuery);

    result := lFDQuery;
  finally

  end;

end;

function tUTenti.checkAccessFunzionalitaUtenti(aToken: String): boolean;
var
  lQuery: String;
  lFDQuery: TFDQuery;
begin
  result := false;

  try
  
    lQuery := 'Select permessi from utente, token where token=' +
      QuotedStr(aToken) + ' and utente.id= token.utente';
    lFDQuery := fDB.getQueryResult(lQuery);
    
    if (lFDQuery.FieldByName('permessi').AsString = 'amministratore') then
    
    begin
      result := true;
    end

  finally

    lFDQuery.Free;
  end;

end;

end.
