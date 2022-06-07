unit MasterRestaurante.core.impl.mesarepository;

interface

uses
  Data.DB,
  System.SysUtils,
  MasterRestaurante.core.Interfaces,
  MasterRestaurante.Infra.Interfaces,
  MasterRestaurante.Infra.impl.querydbx, UFuncoes, Vcl.Dialogs, Vcl.Controls;

type
  TMesaRepository = class(TInterfacedObject, iMesaRepository)
  private
    FQuery: iQuery;

  const
    MESA = 'SELECT RESTAURANTE_MESA_ID FROM RESTAURANTE_MESA WHERE NUMERO = %S';
    GARCOM = 'SELECT RESTAURANTE_GARCON_ID FROM RESTAURANTE_MESA_GARCON WHERE RESTAURANTE_MESA_ID '+
             'IN (SELECT RESTAURANTE_MESA_ID FROM RESTAURANTE_MESA WHERE NUMERO = %S)';
    STATUS = ' STATUS = %S';
    STATUSNAO = ' AND STATUS <> %S';
    ATUALIZAMESA = 'UPDATE RESTAURANTE_MESA SET STATUS = %S WHERE NUMERO = %S';
    MESASFECHADAS = 'SELECT RESTAURANTE_MESA_ID FROM RESTAURANTE_COMANDA WHERE FECHADO = 1 AND VENDA_ID = 0';
    MESAEMUSO = 'SELECT * FROM RESTAURANTE_MESA WHERE ATIVO = 1';
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iMesaRepository;
    function EstaOcupada(Value: Integer): iMesaRepository;
    function Encerrando(Value: Integer): iMesaRepository;
    function CarregaDados(Value: Integer): TDataSet;
    function CarregaGarcomMesa(Value: Integer): TDataSet;
    function ColocaMesaOcupada(Value: Integer): iMesaRepository;
    function MesaEncerrada(Value: Integer) : iMesaRepository;
    function MesaLivre(Value: Integer) : iMesaRepository;
    function VisualizaEmUso(Value: Boolean; aRestauranteMesa: TDataSet) : iMesaRepository;
  end;

implementation

function TMesaRepository.CarregaDados(Value: Integer): TDataSet;
begin
  Result := FQuery.SQL(Format(MESA, [Value.ToString])).Open.DataSet;
end;

function TMesaRepository.CarregaGarcomMesa(Value: Integer): TDataSet;
begin
  Result := FQuery.SQL(Format(GARCOM, [Value.ToString])).Open.DataSet;
end;

function TMesaRepository.ColocaMesaOcupada(Value: Integer): iMesaRepository;
begin
  Result := Self;
  FQuery.StartTransaction;
  try
    FQuery.SQL(Format(ATUALIZAMESA, [QuotedStr('OCUPADA'), Value.ToString]))
      .ExecSQL.Commit;
  except
    FQuery.Rollback;
    raise Exception.Create('Erro ao colocar a mesa ocupada');
  end;
end;

constructor TMesaRepository.Create;
begin
  FQuery := TQueryDBX.New;
end;

destructor TMesaRepository.Destroy;
begin

  inherited;
end;

function TMesaRepository.Encerrando(Value: Integer): iMesaRepository;
begin
  Result := Self;
  if not FQuery.SQL(Format(MESA +' AND '+STATUS, [Value.ToString, QuotedStr('ENCERRANDO')]))
    .Open.DataSet.IsEmpty then
  begin
    Mensagem('Mesa sendo Encerrada!', mtWarning, [mbOk], mrOk, 0);
    Abort;
  end;
end;

function TMesaRepository.EstaOcupada(Value: Integer): iMesaRepository;
begin
  Result := Self;
  if not FQuery.SQL(Format(MESA +' AND '+STATUS, [Value.ToString, QuotedStr('OCUPADA')]))
    .Open.DataSet.IsEmpty then
  begin
    Mensagem('Existe uma Comanda aberta para esta Mesa!', mtWarning,
      [mbOk], mrOk, 0);
    Abort;
  end;
end;

function TMesaRepository.MesaEncerrada(Value: Integer) : iMesaRepository;
begin
  Result := Self;
  if FQuery
      .SQL(Format(MESA +' AND '+STATUS+' AND RESTAURANTE_MESA_ID IN('+MESASFECHADAS+')',
    [Value.ToString, QuotedStr('ENCERRANDO')])).Open.DataSet.IsEmpty then
  begin
    Mensagem('A Mesa informada não foi Encerrada!', mtWarning, [mbOk], mrOk, 0);
    Abort;
  end;
end;

function TMesaRepository.MesaLivre(Value: Integer): iMesaRepository;
begin
  Result := Self;
  FQuery.StartTransaction;
  try
    FQuery.SQL(Format(ATUALIZAMESA,[QuotedStr('LIVRE'), Value.ToString]))
      .ExecSQL
      .Commit;
  except
    FQuery.Rollback;
    raise Exception.Create('Erro ao tentar colocar mesa como livre');
  end;
end;

class function TMesaRepository.New: iMesaRepository;
begin
  Result := Self.Create;
end;

function TMesaRepository.VisualizaEmUso(Value: Boolean;
  aRestauranteMesa: TDataSet): iMesaRepository;
var
  lStatusLivre: String;
begin
  Result := Self;
  lStatusLivre := Format(STATUSNAO,[QuotedStr('LIVRE')]);

  if not Value then
    lStatusLivre := '';

  aRestauranteMesa.Close;
  aRestauranteMesa := FQuery.SQL(MESAEMUSO+lStatusLivre+' ORDER BY NUMERO')
    .Open.DataSet;
  aRestauranteMesa.Open;
  aRestauranteMesa.First;
end;

end.
