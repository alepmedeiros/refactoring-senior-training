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
    function MesaLivre(Value: Integer) : iMesaRepository;
  end;

  iVendaRepository = interface
    function UseDataSet(Value: TDataSet) : iVendaRepository;
    function IniciarVenda : Integer;
    function SetaVendedor(Value: Integer) : iVendaRepository;
    function SetaCliente(Value: String)  : iVendaRepository;
    function LimpaItensVendas(aVendaId: Integer) : iVendaRepository;
    function LimpaNegociacoes(aVendaId: Integer) : iVendaRepository;
    function LimpaVenda(aVendaId: Integer) : iVendaRepository;
  end;

  iComandaRepository = interface
    function Mesa(Value: Integer) : iComandaRepository;
    function Vendedor(Value: Integer) : iComandaRepository;
    function ExisteComanda(var aComandaID: Integer) : iComandaRepository;
    function LiberaComanda(aVendaId, aComandaID: Integer) : iComandaRepository;
  end;

  iComandaItensRepository = interface
    function GravarItensVenda(aVendaId, aComanda: Integer) : iComandaItensRepository;
  end;

implementation

end.
