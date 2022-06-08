unit MasterRestaurante.core.impl.comandarepository;

interface

uses
  System.SysUtils,
  MasterRestaurante.core.Interfaces,
  MasterRestaurante.Infra.Interfaces,
  MasterRestaurante.Infra.impl.querydbx,
  Data.DB,
  Vcl.Dialogs,
  System.UITypes,
  UFuncoes, MasterRestaurante.Infra.impl.datasetabstract;

type
  TComandaRepository = class(TInterfacedObject, iComandaRepository)
  private
    FQuery: iQuery;
    FDataSet: iDataSetAbstract;
    FMesa: Integer;
    FVendedor: Integer;

  const
    BUSCAMESA =
      'select restaurante_mesa_id from restaurante_mesa where numero = %s';
    COMANDA = 'select * from restaurante_comanda where venda_id = 0 and cancelado = 0 and vendedor_id = %s ';
    ATUALIZACOMANDA = 'update restaurante_comanda set venda_id = %s  where restaurante_comanda_id = %s';
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iComandaRepository;
    function Mesa(Value: Integer): iComandaRepository;
    function Vendedor(Value: Integer): iComandaRepository;
    function ExisteComanda(var aComandaID: Integer): iComandaRepository;
    function LiberaComanda(aVendaId, aComandaID: Integer) : iComandaRepository;
    function RegistraComanda(aMesaId, aGarcomId: Integer; aDataSet: TDataSet) : iComandaRepository;
  end;

implementation

constructor TComandaRepository.Create;
begin
  FQuery := TQueryDBX.New;
  FDataSet := TDataSetAbstract.New;
end;

destructor TComandaRepository.Destroy;
begin

  inherited;
end;

function TComandaRepository.ExisteComanda(var aComandaID: Integer)
  : iComandaRepository;
begin
  Result := Self;
  aComandaID := FQuery.SQL(Format(COMANDA + ' AND RESTAURANTE_MESA_ID IN (' + BUSCAMESA +
    ')', [FVendedor.ToString, FMesa.ToString])).Open.DataSet
      .FieldByName('RESTAURANTE_COMANDA_ID').AsInteger;

  if aComandaID <= 0 then
  begin
    Mensagem('Nenhuma Comanda foi Localizada!', mtWarning, [mbOk], mrOk, 0);
    Abort;
  end;
end;

function TComandaRepository.LiberaComanda(aVendaId, aComandaID: Integer) : iComandaRepository;
begin
  Result := Self;
  FQuery.StartTransaction;
  try
    FQuery
      .SQL(Format(ATUALIZACOMANDA,[aVendaId.ToString, aComandaID.ToString])).ExecSQL.Commit;
  except
    FQuery.Rollback;
    raise Exception.Create('Erro ao tentar liberar comanda');
  end;
end;

function TComandaRepository.Mesa(Value: Integer): iComandaRepository;
begin
  Result := Self;
  FMesa := Value;
end;

class function TComandaRepository.New: iComandaRepository;
begin
  Result := Self.Create;
end;

function TComandaRepository.RegistraComanda(aMesaId, aGarcomId: Integer;
  aDataSet: TDataSet): iComandaRepository;
begin
  Result := Self;
  try
    FDataSet.UseDataSet(aDataSet)
    .Atualizar
      .Append
      .Fields('RESTAURANTE_MESA_ID',aMesaId)
      .Fields('RESTAURANTE_GARCON_ID',aGarcomId)
    .Post
    .Atualizar;
  except begin
    Mensagem('Falha ao Tentar iniciar a Comanda!', mtWarning, [mbOk],
        mrOk, 0);
    Abort;
    end;
  end;
end;

function TComandaRepository.Vendedor(Value: Integer): iComandaRepository;
begin
  Result := Self;
  FVendedor := Value;
end;

end.
