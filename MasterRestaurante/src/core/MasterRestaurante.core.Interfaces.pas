unit MasterRestaurante.core.Interfaces;

interface

uses
  Data.DB;

type
  iMesaRepository = interface
    function EstaOcupada(Value: Integer) : Boolean;
    function Encerrando(Value: Integer) : Boolean;
    function CarregaDados(Value: Integer) : TDataSet;
    function CarregaGarcomMesa(Value: Integer): TDataSet;
    function ColocaMesaOcupada(Value: Integer): iMesaRepository;
    function MesaEncerrada(Value: Integer) : iMesaRepository;
  end;

implementation

end.
