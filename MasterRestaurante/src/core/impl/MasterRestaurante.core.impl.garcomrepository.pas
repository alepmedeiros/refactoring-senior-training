unit MasterRestaurante.core.impl.garcomrepository;

interface

uses
  System.SysUtils,
  MasterRestaurante.core.Interfaces,
  MasterRestaurante.Infra.Interfaces,
  UFuncoes,
  Vcl.Dialogs,
  Vcl.Controls,
  Data.DB, MasterRestaurante.Infra.impl.querydbx;

type
  TGarcomRepository = class(TInterfacedObject, iGarcomRepository)
  private
    FQuery: iQuery;
  const
    GARCOMMESA = 'SELECT RESTAURANTE_GARCON_ID FROM RESTAURANTE_MESA_GARCON WHERE RESTAURANTE_MESA_ID '+
             'IN (SELECT RESTAURANTE_MESA_ID FROM RESTAURANTE_MESA WHERE NUMERO = %S)';
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iGarcomRepository;
    function BuscaGarcomMesa(aMesaId: Integer): iGarcomRepository;
    function RetornaGarcom: Integer;
  end;

implementation

function TGarcomRepository.BuscaGarcomMesa(aMesaId: Integer): iGarcomRepository;
begin
  Result := Self;
  if FQuery.SQL(Format(GARCOMMESA, [aMesaId.ToString])).Open.DataSet.IsEmpty then
  begin
    Mensagem('Não foi localizado nenhum Garçon para esta Mesa: ' +
      aMesaId.ToString, mtWarning, [mbOk], mrOk, 0);
    Abort;
  end;
end;

constructor TGarcomRepository.Create;
begin
  FQuery:= TQueryDBX.New;
end;

destructor TGarcomRepository.Destroy;
begin

  inherited;
end;

class function TGarcomRepository.New: iGarcomRepository;
begin
  Result := Self.Create;
end;

function TGarcomRepository.RetornaGarcom: Integer;
begin
  Result := FQuery.DataSet.fields[0].AsInteger;
end;

end.
