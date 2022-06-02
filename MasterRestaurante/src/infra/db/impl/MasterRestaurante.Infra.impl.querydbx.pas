unit MasterRestaurante.Infra.impl.querydbx;

interface

uses
  MasterRestaurante.Infra.Interfaces,
  Data.DB,
  Base,
  Data.SqlExpr;

type
  TQueryDBX = class(TInterfacedObject, iQuery)
  private
    FConn: TBancoDados;
    FQuery: TSQLQuery;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iQuery;
    function StartTransaction : iQuery;
    function SQL(value: String): iQuery;
    function Params(aParams: String; value: Variant): iQuery; overload;
    function Params(aParams: String): Variant; overload;
    function Open: iQuery;
    function ExecSQL: iQuery;
    function DataSet(value: TDataSet): iQuery; overload;
    function DataSet: TDataSet; overload;
    function Commit : iQuery;
    function Rollback : iQuery;
  end;

implementation

function TQueryDBX.Commit: iQuery;
begin
  Result := Self;
  FConn.Conexao.Commit(FConn.Transacao);
end;

constructor TQueryDBX.Create;
begin
  if not Assigned(FConn) then
    FConn:= TBancoDados.Create(nil);
  FQuery:= TSQLQuery.Create(nil);
  FQuery.SQLConnection := FConn.Conexao;
end;

function TQueryDBX.DataSet(value: TDataSet): iQuery;
begin
  Result := Self;
  Value := FQuery;
end;

function TQueryDBX.DataSet: TDataSet;
begin
  Result := FQuery;
end;

destructor TQueryDBX.Destroy;
begin
  FConn.Free;
  FQuery.Free;
  inherited;
end;

function TQueryDBX.ExecSQL: iQuery;
begin
  Result := Self;
  FQuery.ExecSQL(true);
end;

class function TQueryDBX.New: iQuery;
begin
  Result := Self.Create;
end;

function TQueryDBX.Open: iQuery;
begin
  Result := self;
  FQuery.Open;
end;

function TQueryDBX.Params(aParams: String): Variant;
begin
  Result := FQuery.ParamByName(aParams).Value;
end;

function TQueryDBX.Rollback: iQuery;
begin
  Result := Self;
  FConn.Conexao.Rollback(FConn.Transacao);
end;

function TQueryDBX.Params(aParams: String; value: Variant): iQuery;
begin
  Result := Self;
  FQuery.ParamByName(aParams).Value := Value;
end;

function TQueryDBX.SQL(value: String): iQuery;
begin
  Result := Self;
  FQuery.Close;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(Value);
end;

function TQueryDBX.StartTransaction: iQuery;
begin
  Result := Self;
  FConn.Conexao.StartTransaction(FConn.Transacao);
end;

end.
