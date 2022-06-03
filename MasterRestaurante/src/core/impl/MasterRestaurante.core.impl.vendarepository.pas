unit MasterRestaurante.core.impl.vendarepository;

interface

uses
  Data.DB,
  System.SysUtils,
  MasterRestaurante.core.Interfaces,
  MasterRestaurante.Infra.Interfaces,
  MasterRestaurante.Infra.impl.querydbx;

type
  TVendaRepository = class(TInterfacedObject, iVendaRepository)
  private
    FQuery: iQuery;
    FDataSet: TDataSet;

  const
    CLIENTE = 'select cliente_id from cliente where pessoa_id ' +
      ' in(select pessoa_id from pessoa where nome_razao = %s)';
    LIMPAITEMVENDA = 'delete from venda_item where venda_id = %s';
    LIMPANEGOCIACAO = 'delete from negociacao where venda_id = %s';
    LIMPAVENDAS = 'delete from venda where venda_id = %s';
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iVendaRepository;
    function UseDataSet(Value: TDataSet): iVendaRepository;
    function IniciarVenda: Integer;
    function SetaVendedor(Value: Integer): iVendaRepository;
    function SetaCliente(Value: String): iVendaRepository;
    function LimpaItensVendas(aVendaId: Integer) : iVendaRepository;
    function LimpaNegociacoes(aVendaId: Integer) : iVendaRepository;
    function LimpaVenda(aVendaId: Integer) : iVendaRepository;
  end;

implementation

constructor TVendaRepository.Create;
begin
  FQuery := TQueryDBX.New;
end;

destructor TVendaRepository.Destroy;
begin

  inherited;
end;

function TVendaRepository.IniciarVenda: Integer;
begin
  Result := FDataSet.FieldByName('VENDA_ID').Value;
  FDataSet.Post;
end;

function TVendaRepository.LimpaItensVendas(aVendaId: Integer): iVendaRepository;
begin
  Result := Self;
  FQuery.StartTransaction;
  try
    FQuery.SQL(Format(LIMPAITEMVENDA,[aVendaId.ToString])).ExecSQL.Commit;
  except
    FQuery.Rollback;
    raise Exception.Create('Erro ao tentar limpar os itens da venda');
  end;
end;

function TVendaRepository.LimpaNegociacoes(aVendaId: Integer): iVendaRepository;
begin
  Result := Self;
  FQuery.StartTransaction;
  try
    FQuery.SQL(Format(LIMPANEGOCIACAO,[aVendaId.ToString])).ExecSQL.Commit;
  except
    FQuery.Rollback;
    raise Exception.Create('Erro ao tentar limpar as negociações da venda');
  end;
end;

function TVendaRepository.LimpaVenda(aVendaId: Integer): iVendaRepository;
begin
  Result := Self;
  FQuery.StartTransaction;
  try
    FQuery.SQL(Format(LIMPAVENDAS,[aVendaId.ToString])).ExecSQL.Commit;
  except
    FQuery.Rollback;
    raise Exception.Create('Erro ao tentar limpa as vendas');
  end;
end;

class function TVendaRepository.New: iVendaRepository;
begin
  Result := Self.Create;
end;

function TVendaRepository.SetaCliente(Value: String): iVendaRepository;
var
  qry: string;
begin
  Result := Self;
  FDataSet.FieldByName('CLIENTE_ID').Value :=
    FQuery.SQL(Format(CLIENTE, [QuotedStr(Value)])).Open.DataSet.Fields
    [0].Value;
end;

function TVendaRepository.SetaVendedor(Value: Integer): iVendaRepository;
begin
  Result := Self;
  FDataSet.FieldByName('VENDEDOR_ID').Value := VAlue;
end;

function TVendaRepository.UseDataSet(Value: TDataSet): iVendaRepository;
begin
  Result := Self;
  FDataSet := Value;

  FDataSet.Close;
  FDataSet.Open;
  FDataSet.Append;
end;

end.
