program MasterRestaurante;

uses
  Forms,
  UAjuda in 'src\pages\UAjuda.pas' {AjudaForm},
  UConexao in 'src\pages\UConexao.pas' {ConexaoForm},
  UFinalizadora in 'src\pages\UFinalizadora.pas' {FinalizadoraForm},
  UFormaPagamento in 'src\pages\UFormaPagamento.pas' {FormaPagamentoForm},
  UFormComanda in 'src\pages\UFormComanda.pas' {FormComanda},
  UItem in 'src\pages\UItem.pas' {ItemForm},
  ULogin in 'src\pages\ULogin.pas' {LoginForm},
  UPeriodo in 'src\pages\UPeriodo.pas' {PeriodoForm},
  UPesquisaComanda in 'src\pages\UPesquisaComanda.pas' {PesquisaComandaForm},
  UPesquisaProduto in 'src\pages\UPesquisaProduto.pas' {PesquisaProdutoForm},
  UPrincipal in 'src\pages\UPrincipal.pas' {PrincipalForm},
  UTroco in 'src\pages\UTroco.pas' {TrocoForm},
  UVenda in 'src\pages\UVenda.pas' {VendaForm},
  Base in 'src\infra\db\Base.pas' {BancoDados: TDataModule},
  UCupomNaoFiscal in 'src\utils\UCupomNaoFiscal.pas',
  UFuncoes in 'src\utils\UFuncoes.pas',
  UImprimeComanda in 'src\utils\UImprimeComanda.pas',
  Base64 in 'src\utils\Base64.pas',
  MasterRestaurante.Infra.Interfaces in 'src\infra\db\MasterRestaurante.Infra.Interfaces.pas',
  MasterRestaurante.Infra.impl.querydbx in 'src\infra\db\impl\MasterRestaurante.Infra.impl.querydbx.pas',
  MasterRestaurante.core.Interfaces in 'src\core\MasterRestaurante.core.Interfaces.pas',
  MasterRestaurante.core.impl.mesarepository in 'src\core\impl\MasterRestaurante.core.impl.mesarepository.pas';

{$R *.res}


begin
//  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'MasterRestaurante';
  Application.CreateForm(TBancoDados, BancoDados);
  Application.CreateForm(TPrincipalForm, PrincipalForm);
  Application.Run;
end.
