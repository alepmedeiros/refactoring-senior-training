unit MasterRestaurante.core.impl.comandaitensrepository;

interface

uses
  System.SysUtils,
  MasterRestaurante.core.Interfaces,
  Data.DB, MasterRestaurante.Infra.Interfaces,
  MasterRestaurante.Infra.impl.querydbx, Datasnap.DBClient;

type
  TComandaItensRepository = class(TInterfacedObject, iComandaItensRepository)
  private
    FQuery: iQuery;

    const
      COMANDAITENS =
        'select produto_id, und, COALESCE(sum(quantidade), 0.0), COALESCE(sum(total), 0.0), COALESCE(preco,0) from restaurante_comanda_item'+
        ' where cancelado = 0 and restaurante_comanda_id = %s group by produto_id, und, preco';
      ITENSVENDA = 'insert into venda_item (venda_id,cancelado,produto_id,und,item,quantidade,preco,total) values (%s,0,%s,%s,%s,%s,%s,%s)';
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iComandaItensRepository;
    function GravarItensVenda(aVendaId, aComanda: Integer) : iComandaItensRepository;
  end;

implementation

constructor TComandaItensRepository.Create;
begin
  FQuery := TQueryDBX.New;
end;

destructor TComandaItensRepository.Destroy;
begin
  inherited;
end;

function TComandaItensRepository.GravarItensVenda(aVendaId, aComanda: Integer) : iComandaItensRepository;
var
  lItem : Integer;
  lDataSet: TDataSet;
begin
  Result := Self;
  lItem := 0;

  lDataSet := TQueryDBX.New.SQL(Format(COMANDAITENS,[aComanda.ToString])).Open.DataSet;

  FQuery.StartTransaction;
  try
    lDataSet.First;
    while not lDataSet.Eof do
    begin
      inc(lItem);

      FQuery
        .SQL(Format(ITENSVENDA,
          [aVendaId.ToString, lDataSet.fields[0].AsString,
          QuotedStr(lDataSet.fields[1].AsString),
          lItem.ToString,
          FloatToStr(lDataSet.fields[2].AsFloat),
          FloatToStr(lDataSet.fields[4].AsFloat),
          FloatTOStr(lDataSet.fields[3].AsFloat)]))
        .ExecSQL.Commit;

      lDataSet.Next;
    end;
  except
    FQuery.Rollback;
    raise Exception.Create('Não foi possivel inserir os intens da comanda na venda.');
  end;
end;

class function TComandaItensRepository.New: iComandaItensRepository;
begin
  Result := Self.Create;
end;

end.
