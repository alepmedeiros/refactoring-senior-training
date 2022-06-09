unit UPrincipal;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  IniFiles,
  ComCtrls,
  ImgList,
  ExtCtrls,
  ActnList,
  Menus,
  Buttons,
  Grids,
  DBGrids,
  AppEvnts,
  StdCtrls,
  JvExStdCtrls,
  JvEdit,
  JvValidateEdit,
  Data.DB,
  System.ImageList,
  System.Actions,
  MasterRestaurante.core.impl.mesarepository,
  MasterRestaurante.core.impl.vendarepository,
  MasterRestaurante.core.impl.comandarepository,
  MasterRestaurante.core.impl.comandaitensrepository,
  MasterRestaurante.core.impl.garcomrepository,
  MasterRestaurante.Infra.impl.datasetabstract;

type
  TPrincipalForm = class(TForm)
    SBPrincipal: TStatusBar;
    MainMenuPrincipal: TMainMenu;
    Arquivo1: TMenuItem;
    rocarUsurio1: TMenuItem;
    Sair1: TMenuItem;
    ActionListPrincipal: TActionList;
    ATrocarUsuario: TAction;
    TimerPrincipal: TTimer;
    ImageListPrincipal: TImageList;
    PAtalhos: TPanel;
    BTFechar: TSpeedButton;
    Bevel1: TBevel;
    BTControleMesa: TSpeedButton;
    NBPrincipal: TNotebook;
    Panel1: TPanel;
    BTCadastrarItensComanda: TSpeedButton;
    BTAbrirComanda: TSpeedButton;
    BTEncerrarComanda: TSpeedButton;
    BTComandaEmAberto: TSpeedButton;
    DBGrid1: TDBGrid;
    ApplicationEvents: TApplicationEvents;
    Action1: TAction;
    Action2: TAction;
    BTVenda: TSpeedButton;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    Action7: TAction;
    Action8: TAction;
    Action9: TAction;
    AAjuda: TAction;
    Ajuda1: TMenuItem;
    BTImprimeComanda: TSpeedButton;
    BTCancelaComanda: TSpeedButton;
    Action10: TAction;
    CadastrarGaronsMesa1: TMenuItem;
    Relatrios1: TMenuItem;
    VendasporPerodo1: TMenuItem;
    BTFecharConta: TSpeedButton;
    Action11: TAction;
    SomenteMesasemuso1: TMenuItem;
    Panel2: TPanel;
    BTEncerrarComanda1: TSpeedButton;
    BTImprimir1: TSpeedButton;
    BTExcluirItem: TSpeedButton;
    Label4: TLabel;
    LBTotal: TLabel;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    Panel4: TPanel;
    Panel5: TPanel;
    Label7: TLabel;
    LBComanda: TLabel;
    Label5: TLabel;
    LBMesa: TLabel;
    Label6: TLabel;
    LBGarcon: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    EditCodigo: TEdit;
    Shape2: TShape;
    Shape1: TShape;
    EditDescricao: TEdit;
    EditQtd: TJvValidateEdit;
    Shape3: TShape;
    Label3: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ATrocarUsuarioExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure BTFecharClick(Sender: TObject);
    procedure ApplicationEventsHint(Sender: TObject);
    procedure BTControleMesaClick(Sender: TObject);
    procedure NBPrincipalPageChanged(Sender: TObject);
    procedure BTAbrirComandaClick(Sender: TObject);
    procedure BTCadastrarItensComandaClick(Sender: TObject);
    procedure EditCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure EditQtdKeyPress(Sender: TObject; var Key: Char);
    procedure Action1Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure BTVendaClick(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure TimerPrincipalTimer(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure BTEncerrarComandaClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Action9Execute(Sender: TObject);
    procedure AAjudaExecute(Sender: TObject);
    procedure BTEncerrarComanda1Click(Sender: TObject);
    procedure BTImprimir1Click(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure BTExcluirItemClick(Sender: TObject);
    procedure BTComandaEmAbertoClick(Sender: TObject);
    procedure BTCancelaComandaClick(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure CadastrarGaronsMesa1Click(Sender: TObject);
    procedure VendasporPerodo1Click(Sender: TObject);
    procedure BTFecharContaClick(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure BTImprimeComandaClick(Sender: TObject);
    procedure SomenteMesasemuso1Click(Sender: TObject);
    procedure EditCodigoExit(Sender: TObject);
    procedure DBGrid2TitleClick(Column: TColumn);
  private
    { Private declarations }
    ArquivoIni: TIniFile;
    path: String;
    procedure LogarVendedor;

    // refatoração
    procedure ApagarGarconMesa;
    function CarregarMesasAtiva(Value: Boolean): TDataSet;
    function CarregarTodosGarcons: TDataSet;
    procedure CarregarGarconsMesas(aIdMesa, aIdGarcon: String);

    procedure BuscarMesa(var MesaId: Integer);
    procedure VerificaMesaEncerrada(MesaId: Integer);
    procedure SetaVenda;
    function BuscarComanda(MesaId: Integer): Integer;
    procedure SetaItensVenda(ComandaId: Integer);
    procedure FinalizarVenda;
    procedure VendaConcluida(MesaId, ComandaId: Integer);
    procedure ResetaMesa;
    procedure RegistraComanda(MesaId: Integer);
    procedure PreparaItensVenda(aMesa, aComanda: Integer);

    procedure ChamaMesa(aTitulo, aDescricao: String; var aMesa: Integer);
  public
    { Public declarations }
  end;

var
  PrincipalForm: TPrincipalForm;
  Logado: Boolean = False;
  DataSistema: TDate;
  VendedorID: Integer;

implementation

uses Base,
  Base64,
  UFuncoes,
  UConexao,
  ULogin,
  UPesquisaProduto,
  UVenda,
  UItem,
  UAjuda,
  UPesquisaComanda,
  UPeriodo,
  UImprimeComanda,
  UFinalizadora;

{$R *.dfm}

procedure TPrincipalForm.LogarVendedor;
begin
  try
    if not Assigned(LoginForm) then
      LoginForm := TLoginForm.Create(Application);
    LoginForm.ShowModal;
    if (Logado) then
    begin
      Log(BancoDados.qryLog, BancoDados.qryLoginVENDEDOR_ID.Value,
        BancoDados.Tabela, 'Login Efetuado: Login = ' +
        BancoDados.qryLoginLOGIN.Value + '.');

      VendedorID := BancoDados.qryLoginVENDEDOR_ID.Value;

      SBPrincipal.Panels[0].Text := ' Empresa: ';
      SBPrincipal.Panels[1].Text := ' Vendedor: ' +
        BancoDados.qryLoginLOGIN.Value;
      SBPrincipal.Panels[2].Text := ' Data: ' +
        FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
      DataSistema := Date;
    end
    else
    begin
      if (VendedorID > 0) then
        LoginForm.Close
      else
        Application.Terminate;
    end;
    path := RCopy(Application.ExeName, '\');
    if FileExists(path + 'MasterERP.ini') then
    begin
      ArquivoIni := TIniFile.Create(path + 'MasterERP.ini');
      SomenteMesasemuso1.Checked := ArquivoIni.ReadBool('GERAL',
        'MesasEmAberto', False);

      try
        if (ArquivoIni.ReadBool('GERAL', 'ExecutaScript', False)) then
          WinExec(PAnsiChar(AnsiString(path + 'Impressora.bat')), 0);
      except
      end;
    end;
  finally
    LoginForm.Free;
    LoginForm := nil;
  end;
end;

procedure TPrincipalForm.ApagarGarconMesa;
begin
  BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
  try
    BancoDados.qryExecute.SQL.Text := 'delete from restaurante_mesa_garcon;';
    BancoDados.qryExecute.ExecSQL(True);
    BancoDados.Conexao.Commit(BancoDados.Transacao);
  except
    raise Exception.Create('Erro ao limpar os garcons cadastrados');
    BancoDados.Conexao.Rollback(BancoDados.Transacao);
  end;
end;

procedure TPrincipalForm.NBPrincipalPageChanged(Sender: TObject);
begin
  if not(BancoDados.CDSRestauranteComanda.IsEmpty) then
  begin
    with BancoDados.qryAuxiliar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select COALESCE(sum(total), 0.0) as total from restaurante_comanda_item '
        + 'where cancelado = 0 and restaurante_comanda_id = ' +
        IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.Value));
      Open;
    end;
    LBTotal.Caption := FormatFloat('R$ ,0.00',
      BancoDados.qryAuxiliar.Fields[0].Value);
  end;

  if (NBPrincipal.PageIndex = 1) then
  begin
    EditCodigo.Text := '';
    EditDescricao.Text := '';
    EditQtd.Text := '0,0000';
    EditCodigo.SetFocus;
  end;

  try
    BancoDados.CDSRestauranteMesa.DisableControls;
    BancoDados.CDSRestauranteMesa.Close;
    BancoDados.qryRestauranteMesa.SQL.Text :=
      'select * from restaurante_mesa where ativo = 1';
    if (SomenteMesasemuso1.Checked) then
      BancoDados.qryRestauranteMesa.SQL.Add(' and status <> ' +
        QuotedStr('LIVRE'));

    BancoDados.qryRestauranteMesa.SQL.Add('order by numero');
    BancoDados.CDSRestauranteMesa.Open;
    BancoDados.CDSRestauranteMesa.First;
  finally
    BancoDados.CDSRestauranteMesa.EnableControls;
  end;
end;

procedure TPrincipalForm.ResetaMesa;
begin
  try
    BancoDados.CDSRestauranteMesa.Close;
    BancoDados.qryRestauranteMesa.SQL.Text :=
      'select * from restaurante_mesa where ativo = 1';
    if (SomenteMesasemuso1.Checked) then
      BancoDados.qryRestauranteMesa.SQL.Add(' and status <> ' +
        QuotedStr('LIVRE'));

    BancoDados.qryRestauranteMesa.SQL.Add('order by numero');
    BancoDados.CDSRestauranteMesa.Open;
    BancoDados.CDSRestauranteMesa.First;
  finally
    BancoDados.CDSRestauranteMesa.EnableControls;
    BancoDados.VendaID := 0;
  end;
end;

procedure TPrincipalForm.RegistraComanda(MesaId: Integer);
begin
  TMesaRepository.New.EstaOcupada(MesaId).MesaEncerrada(MesaId);

  TComandaRepository.New.RegistraComanda(MesaId,
    TGarcomRepository.New.BuscaGarcomMesa(MesaId).RetornaGarcom,
    BancoDados.CDSRestauranteComanda);
end;

procedure TPrincipalForm.PreparaItensVenda(aMesa, aComanda: Integer);
begin
  BancoDados.CDSItens.Close;
  BancoDados.qryItens.SQL.Text := 'select produto_id, descricao, und, preco,' +
    'COALESCE(sum(quantidade), 0.0)as QUANTIDADE,COALESCE(sum(total), 0.0)as TOTAL'
    + ' from restaurante_comanda_item where cancelado = 0 and restaurante_comanda_id = '
    + IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.Value) +
    'group by produto_id, descricao, und, preco';
  BancoDados.CDSItens.Open;

  LBMesa.Caption := aMesa.ToString;
  LBComanda.Caption := FormatFloat('0000000000',aComanda);
  NBPrincipal.PageIndex := 1;
  EditQtd.Value := 1;
  EditCodigo.SetFocus;
end;

procedure TPrincipalForm.SetaItensVenda(ComandaId: Integer);
begin
  TComandaItensRepository.New.GravarItensVenda(BancoDados.VendaID, ComandaId);
end;

procedure TPrincipalForm.SetaVenda;
begin
  BancoDados.VendaID := TVendaRepository.New.UseDataSet(BancoDados.CDSVenda)
    .SetaVendedor(VendedorID).SetaCliente('CLIENTE BALCÃO').IniciarVenda;
end;

procedure TPrincipalForm.SomenteMesasemuso1Click(Sender: TObject);
begin
  if (NBPrincipal.PageIndex = 0) then
  begin
    if (NBPrincipal.Visible) then
    begin
      TMesaRepository.New.VisualizaEmUso(SomenteMesasemuso1.Checked,
        BancoDados.CDSRestauranteMesa);
    end;
  end;
end;

procedure TPrincipalForm.TimerPrincipalTimer(Sender: TObject);
begin
  SBPrincipal.Panels[2].Text := ' Data: ' +
    FormatDateTime('dd/mm/yyyy hh:mm:ss', Now);
end;

procedure TPrincipalForm.VendaConcluida(MesaId, ComandaId: Integer);
begin
  if not BancoDados.VendaConcluida then
  begin
    TVendaRepository.New.LimpaItensVendas(BancoDados.VendaID)
      .LimpaNegociacoes(BancoDados.VendaID).LimpaVenda(BancoDados.VendaID);
    Abort;
  end;
  TMesaRepository.New.MesaLivre(MesaId);
  TComandaRepository.New.LiberaComanda(BancoDados.VendaID, ComandaId);
end;

procedure TPrincipalForm.VendasporPerodo1Click(Sender: TObject);
begin
  CriaForm(TPeriodoForm, PeriodoForm);
end;

procedure TPrincipalForm.VerificaMesaEncerrada(MesaId: Integer);
begin
  TMesaRepository.New.MesaEncerrada(MesaId);
end;

procedure TPrincipalForm.AAjudaExecute(Sender: TObject);
begin
  try
    if not Assigned(AjudaForm) then
      AjudaForm := TAjudaForm.Create(Application);
    with AjudaForm.MAjuda do
    begin
      Lines.Clear;
      Lines.Add('');
      Lines.Add('F1 - Ajuda');
      Lines.Add('F2 - Controle de Mesas');
      Lines.Add('F3 - Venda Direta');
      Lines.Add('F4 - Pesquisar Produtos');
      Lines.Add('F5 - Abrir Comanda');
      Lines.Add('F6 - Alterar Comanda');
      Lines.Add('F7 - Imprimir Comanda (Espelho de Conferencia)');
      Lines.Add('F8 - Encerrar Comanda');
      Lines.Add('F10 - Cancelar Item da Comanda');
      Lines.Add('Ctrl + L - Liberar Mesa');
    end;
    AjudaForm.ShowModal;
  finally
    AjudaForm.Free;
    AjudaForm := nil;
  end;
end;

procedure TPrincipalForm.Action10Execute(Sender: TObject);
begin
  if (NBPrincipal.PageIndex = 0) then
    BTComandaEmAbertoClick(Sender);
end;

procedure TPrincipalForm.Action11Execute(Sender: TObject);
begin
  BTFecharContaClick(Sender);
end;

procedure TPrincipalForm.Action1Execute(Sender: TObject);
begin
  BTControleMesaClick(Sender);
end;

procedure TPrincipalForm.Action2Execute(Sender: TObject);
begin
  BTVendaClick(Sender);
end;

procedure TPrincipalForm.Action3Execute(Sender: TObject);
begin
  if ((NBPrincipal.PageIndex = 0) and (NBPrincipal.Visible)) then
    BTAbrirComandaClick(Sender);
end;

procedure TPrincipalForm.Action4Execute(Sender: TObject);
begin
  if ((NBPrincipal.PageIndex = 0) and (NBPrincipal.Visible)) then
    BTCadastrarItensComandaClick(Sender);
end;

procedure TPrincipalForm.Action5Execute(Sender: TObject);
begin
  BTImprimeComandaClick(Sender);
end;

procedure TPrincipalForm.Action6Execute(Sender: TObject);
begin
  if (NBPrincipal.Visible) then
    BTEncerrarComandaClick(Sender);
end;

procedure TPrincipalForm.Action7Execute(Sender: TObject);
begin
  if (NBPrincipal.Visible) then
    BTCancelaComandaClick(Sender);
end;

procedure TPrincipalForm.Action8Execute(Sender: TObject);
var
  ItemID: Integer;
begin
  if ((NBPrincipal.PageIndex = 1) and (NBPrincipal.Visible)) then
  begin
    if (Mensagem('Deseja Excluir este Item?', mtConfirmation, [mbYES, mbNO],
      mrYes, 0) = mrYes) then
    begin
      try
        BancoDados.CDSItens.DisableControls;

        BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
        BancoDados.qryExecute.SQL.Text := 'delete from restaurante_comanda_item'
          + ' where produto_id = ' +
          IntToStr(BancoDados.CDSItensPRODUTO_ID.Value) +
          ' and restaurante_comanda_id = ' +
          IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.
          Value) + ';';
        BancoDados.qryExecute.ExecSQL(True);
        BancoDados.Conexao.Commit(BancoDados.Transacao);

        BancoDados.CDSItens.Close;
        BancoDados.qryItens.SQL.Text :=
          'select produto_id, descricao, und, preco,' +
          'COALESCE(sum(quantidade), 0.0)as QUANTIDADE,COALESCE(sum(total), 0.0)as TOTAL'
          + ' from restaurante_comanda_item where cancelado = 0 and restaurante_comanda_id = '
          + IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.
          Value) + 'group by produto_id, descricao, und, preco';
        BancoDados.CDSItens.Open;

        with BancoDados.qryAuxiliar do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select COALESCE(sum(total), 0.0) as total from restaurante_comanda_item '
            + 'where cancelado = 0 and restaurante_comanda_id = ' +
            IntToStr(BancoDados.
            CDSRestauranteComandaRESTAURANTE_COMANDA_ID.Value));
          Open;
        end;
        LBTotal.Caption := FormatFloat('R$ ,0.00',
          BancoDados.qryAuxiliar.Fields[0].Value);
      finally
        BancoDados.CDSItens.EnableControls;
      end;
    end;
  end;
end;

procedure TPrincipalForm.Action9Execute(Sender: TObject);
begin
  if (NBPrincipal.PageIndex = 1) then
  begin
    try
      if not Assigned(PesquisaProdutoForm) then
        PesquisaProdutoForm := TPesquisaProdutoForm.Create(Application);
      if (PesquisaProdutoForm.ShowModal = mrOk) then
        EditCodigo.Text := FormatFloat('0000000000',
          BancoDados.CDSProdutoPRODUTO_ID.Value);
      EditCodigo.SetFocus;
    finally
      PesquisaProdutoForm.Free;
      PesquisaProdutoForm := nil;
    end;
  end;
end;

procedure TPrincipalForm.ApplicationEventsHint(Sender: TObject);
begin
  SBPrincipal.Panels[3].Text := Application.Hint;
end;

procedure TPrincipalForm.ATrocarUsuarioExecute(Sender: TObject);
begin
  BancoDados.qryLogin.Close;
  Logado := False;
  LogarVendedor;
end;

procedure TPrincipalForm.BTAbrirComandaClick(Sender: TObject);
var
  MesaId: Integer;
begin
  TItemForm.New(Application).Title('MasterRestaurante - Abrir Comanda')
    .Descricao('Mesa Nº:').Show.Mesa(MesaId);

  RegistraComanda(MesaId);

  TMesaRepository.New.ColocaMesaOcupada(MesaId);
end;

procedure TPrincipalForm.BTCadastrarItensComandaClick(Sender: TObject);
var
  MesaId, GarconID, lComanda: Integer;
begin
  try
    TItemForm.New(Application)
      .Title('MasterRestaurante - Cadastrar Iten na Comanda')
      .Descricao('Mesa Nº:').Show.Mesa(MesaId);

    TMesaRepository.New.MesaEncerrada(MesaId);

    RegistraComanda(MesaId);

    lComanda := BuscarComanda(MesaId);

    PreparaItensVenda(MesaId, lComanda);
  except
    begin
      Mensagem('Falha ao Tentar alterar os itens da Comanda!', mtWarning,
        [mbOk], mrOk, 0);
      Abort;
    end;
  end;
end;

procedure TPrincipalForm.BTComandaEmAbertoClick(Sender: TObject);
var
  MesaId: Integer;
begin
  if (NBPrincipal.Visible) then
  begin
    try
      MesaId := 0;
      BancoDados.CDSRestauranteComandaItem.DisableControls;
      if not Assigned(VendaForm) then
        VendaForm := TVendaForm.Create(Application);
      VendaForm.Comanda := True;

      BancoDados.CDSVenda.Close;
      BancoDados.CDSVenda.Open;
      BancoDados.CDSVendaItem.Close;
      BancoDados.CDSVendaItem.Open;
      try
        if not Assigned(ItemForm) then
          ItemForm := TItemForm.Create(Application);
        ItemForm.Caption := 'MasterRestaurante - Abrir Comanda';
        ItemForm.LBTexto.Caption := 'Mesa Nº:';
        if (ItemForm.ShowModal = mrOk) then
          MesaId := ItemForm.EditItem.Value
        else
        begin
          Mensagem('Nenhuma Mesa foi informada!', mtWarning, [mbOk], mrOk, 0);
          Abort;
        end;
      finally
        ItemForm.Free;
        ItemForm := nil;
      end;

      BancoDados.CDSRestauranteComanda.Close;
      BancoDados.qryRestauranteComanda.SQL.Text :=
        'select * from restaurante_comanda' +
        ' where fechado = 0 and cancelado = 0 and vendedor_id = ' +
        IntToStr(VendedorID) +
        ' and restaurante_mesa_id in(select restaurante_mesa_id from restaurante_mesa'
        + ' where numero = ' + IntToStr(MesaId) + ')';
      BancoDados.CDSRestauranteComanda.Open;

      if (BancoDados.CDSRestauranteComandaFECHADO.Value = 1) then
      begin
        try
          if not Assigned(PesquisaComandaForm) then
            PesquisaComandaForm := TPesquisaComandaForm.Create(Application);
          PesquisaComandaForm.MesaId := MesaId;
          if (PesquisaComandaForm.ShowModal = mrOk) then
            BancoDados.VendaID :=
              BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.Value
          else
            Exit;
        finally
          PesquisaComandaForm.Free;
          PesquisaComandaForm := nil;
        end;
      end;
      BancoDados.CDSVenda.Close;
      BancoDados.qryVenda.SQL.Text := 'select * from venda where venda_id = ' +
        IntToStr(BancoDados.VendaID);
      BancoDados.CDSVenda.Open;

      BancoDados.CDSVendaItem.Close;
      BancoDados.qryVendaItem.SQL.Text :=
        'select * from venda_item where venda_id = ' +
        IntToStr(BancoDados.VendaID);
      BancoDados.CDSVendaItem.Open;

      with BancoDados.qryAuxiliar do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select COALESCE(sum(total), 0.0) as total from venda_item ' +
          'where venda_id = ' + IntToStr(BancoDados.VendaID));
        Open;
      end;

      if not(BancoDados.qryAuxiliar.IsEmpty) then
        VendaForm.LBTotal.Caption := FormatFloat('R$ ,0.00',
          BancoDados.qryAuxiliar.Fields[0].Value);

      VendaForm.ShowModal;
    finally
      VendaForm.Free;
      VendaForm := nil;
      BancoDados.CDSRestauranteComandaItem.EnableControls;
      BancoDados.CDSRestauranteMesa.Close;
      BancoDados.CDSRestauranteMesa.Open;
      NBPrincipal.PageIndex := 0;
    end;
  end;
end;

procedure TPrincipalForm.BTCancelaComandaClick(Sender: TObject);
var
  MesaId: Integer;
begin
  if (NBPrincipal.Visible) then
  begin
    try
      BancoDados.CDSRestauranteMesa.DisableControls;

      if (NBPrincipal.PageIndex = 0) then
      begin
        try
          if not Assigned(ItemForm) then
            ItemForm := TItemForm.Create(Application);
          ItemForm.Caption := 'MasterRestaurante - Abrir Comanda';
          ItemForm.LBTexto.Caption := 'Mesa Nº:';
          if (ItemForm.ShowModal = mrOk) then
            MesaId := ItemForm.EditItem.Value
          else
          begin
            Mensagem('Nenhuma Mesa foi informada!', mtWarning, [mbOk], mrOk, 0);
            Abort;
          end;
        finally
          ItemForm.Free;
          ItemForm := nil;
        end;
      end
      else
        MesaId := StrToInt(LBMesa.Caption);

      if (Mensagem('Deseja Cancelar a Comanda?', mtConfirmation, [mbYES, mbNO],
        mrYes, 0) = mrYes) then
      begin
        BancoDados.CDSRestauranteComanda.Close;
        BancoDados.qryRestauranteComanda.SQL.Text :=
          'select * from restaurante_comanda' +
          ' where fechado = 0 and cancelado = 0 and venda_id = 0 and vendedor_id = '
          + IntToStr(VendedorID) +
          ' and restaurante_mesa_id in(select restaurante_mesa_id from restaurante_mesa'
          + ' where numero = ' + IntToStr(MesaId) + ')';
        BancoDados.CDSRestauranteComanda.Open;

        BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
        BancoDados.qryExecute.SQL.Text :=
          'update restaurante_comanda set cancelado = 1,' +
          ' fechado = 0 where restaurante_comanda_id = ' +
          IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.
          Value) + ';';
        BancoDados.qryExecute.ExecSQL(True);
        BancoDados.Conexao.Commit(BancoDados.Transacao);

        BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
        BancoDados.qryExecute.SQL.Text :=
          'update restaurante_mesa set status = ' + QuotedStr('LIVRE') +
          ' where numero = ' + IntToStr(MesaId) + ';';
        BancoDados.qryExecute.ExecSQL(True);
        BancoDados.Conexao.Commit(BancoDados.Transacao);

        BancoDados.CDSRestauranteMesa.Close;
        BancoDados.qryRestauranteMesa.SQL.Text :=
          'select * from restaurante_mesa where ativo = 1';
        if (SomenteMesasemuso1.Checked) then
          BancoDados.qryRestauranteMesa.SQL.Add
            (' and status <> ' + QuotedStr('LIVRE'));

        BancoDados.qryRestauranteMesa.SQL.Add('order by numero');
        BancoDados.CDSRestauranteMesa.Open;
        BancoDados.CDSRestauranteMesa.First;

        NBPrincipal.PageIndex := 0;
      end;
    finally
      BancoDados.CDSRestauranteMesa.EnableControls;
    end;
  end;
end;

procedure TPrincipalForm.BTExcluirItemClick(Sender: TObject);
begin
  if (NBPrincipal.PageIndex = 1) then
    Action8Execute(Sender);
end;

procedure TPrincipalForm.BTControleMesaClick(Sender: TObject);
begin
  if (NBPrincipal.PageIndex = 0) then
    NBPrincipal.Visible := (not NBPrincipal.Visible)
  else
    NBPrincipal.PageIndex := 0;

  if (NBPrincipal.Visible) then
  begin
    BancoDados.CDSRestauranteMesa.Close;
    BancoDados.qryRestauranteMesa.SQL.Text :=
      'select * from restaurante_mesa where ativo = 1';
    if (SomenteMesasemuso1.Checked) then
      BancoDados.qryRestauranteMesa.SQL.Add(' and status <> ' +
        QuotedStr('LIVRE'));

    BancoDados.qryRestauranteMesa.SQL.Add('order by numero');
    BancoDados.CDSRestauranteMesa.Open;
    BancoDados.CDSRestauranteMesa.First;
  end;
end;

procedure TPrincipalForm.BTEncerrarComanda1Click(Sender: TObject);
begin
  if (NBPrincipal.PageIndex = 1) then
    Action6Execute(Sender);
end;

procedure TPrincipalForm.BTEncerrarComandaClick(Sender: TObject);
var
  MesaId, Item, ComandaId: Integer;
begin
  MesaId := 0;
  ComandaId := 0;
  if (NBPrincipal.PageIndex = 0) then
    ChamaMesa('MasterRestaurante - Encerrar Comanda',
      'Mesa Nº:',MesaId)
  else
    MesaId := StrToInt(LBMesa.Caption);

  ComandaId := BuscarComanda(MesaId);

  if not(BancoDados.qryAuxiliar.IsEmpty) then
  begin
    with BancoDados.qryAuxiliar do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select restaurante_comanda_id from restaurante_comanda_item' +
        ' where cancelado = 0 and restaurante_comanda_id = ' +
        IntToStr(ComandaId));
      Open;
    end;

    if not(BancoDados.qryAuxiliar.IsEmpty) then
    begin
      try
        BancoDados.CDSRestauranteMesa.DisableControls;

        BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
        BancoDados.qryExecute.SQL.Text :=
          'update restaurante_comanda set fechado = 1' +
          ' where restaurante_comanda_id = ' + IntToStr(ComandaId) + ';';
        BancoDados.qryExecute.ExecSQL(True);
        BancoDados.Conexao.Commit(BancoDados.Transacao);

        BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
        BancoDados.qryExecute.SQL.Text :=
          'update restaurante_mesa set status = ' + QuotedStr('ENCERRANDO') +
          ' where numero = ' + IntToStr(MesaId) + ';';
        BancoDados.qryExecute.ExecSQL(True);
        BancoDados.Conexao.Commit(BancoDados.Transacao);

        BancoDados.CDSRestauranteMesa.Close;
        BancoDados.qryRestauranteMesa.SQL.Text :=
          'select * from restaurante_mesa where ativo = 1';
        if (SomenteMesasemuso1.Checked) then
          BancoDados.qryRestauranteMesa.SQL.Add
            (' and status <> ' + QuotedStr('LIVRE'));

        BancoDados.qryRestauranteMesa.SQL.Add('order by numero');
        BancoDados.CDSRestauranteMesa.Open;
        BancoDados.CDSRestauranteMesa.First;

        if (Mensagem('Deseja Imprimir a Comanda?', mtConfirmation,
          [mbYES, mbNO], mrYes, 0) = mrYes) then
          ImprimeComanda(ComandaId);

        NBPrincipal.PageIndex := 0;
      finally
        BancoDados.CDSRestauranteMesa.EnableControls;
      end;
    end
    else
    begin
      Mensagem('Não foram inseridos Itens nesta Comanda!', mtWarning,
        [mbOk], mrOk, 0);
      Exit;
    end;
  end
  else
  begin
    Mensagem('Não foi localizada nenhuma Comanda em Aberto para esta Mesa!',
      mtWarning, [mbOk], mrOk, 0);
    Exit;
  end;
end;

procedure TPrincipalForm.BTFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TPrincipalForm.BTFecharContaClick(Sender: TObject);
var
  MesaId, Item, ComandaId: Integer;
begin
  MesaId := 0;
  ComandaId := 0;

  BuscarMesa(MesaId);

  VerificaMesaEncerrada(MesaId);

  SetaVenda;

  ComandaId := BuscarComanda(MesaId);

  SetaItensVenda(ComandaId);

  FinalizarVenda;

  VendaConcluida(MesaId, ComandaId);

  ResetaMesa;
end;

procedure TPrincipalForm.BTImprimeComandaClick(Sender: TObject);
var
  lMesa,lComanda: Integer;
begin
  if (NBPrincipal.PageIndex = 0) then
  begin
    ChamaMesa('MasterRestaurante - Imprimir Comanda','Mesa Nº:',lMesa);

    TComandaRepository.New
      .Mesa(lMesa)
      .Vendedor(VendedorID)
      .ExisteComanda(lComanda);
  end;

  ImprimeComanda(lComanda);

  if (NBPrincipal.PageIndex = 0) then
  begin
    BancoDados.CDSItens.Close;
    BancoDados.CDSRestauranteComanda.Close;
  end;
end;

procedure TPrincipalForm.BTImprimir1Click(Sender: TObject);
begin
  BTImprimir1Click(Sender);
end;

procedure TPrincipalForm.BTVendaClick(Sender: TObject);
begin
  try
    if not Assigned(VendaForm) then
      VendaForm := TVendaForm.Create(Application);
    VendaForm.ShowModal;
  finally
    VendaForm.Free;
    VendaForm := nil;
  end;
end;

function TPrincipalForm.BuscarComanda(MesaId: Integer): Integer;
begin
  TComandaRepository.New.Mesa(MesaId).Vendedor(VendedorID)
    .ExisteComanda(Result);
end;

procedure TPrincipalForm.BuscarMesa(var MesaId: Integer);
begin
  if not NBPrincipal.PageIndex = 0 then
  begin
    MesaId := StrToInt(LBMesa.Caption);
    Exit;
  end;

  TItemForm.New(Application).Title('MasterRestaurante - Fechar Conta')
    .Descricao('Mesa Nº:').Show.Mesa(MesaId);
end;

procedure TPrincipalForm.CadastrarGaronsMesa1Click(Sender: TObject);
var
  lDataSetMesa, lDataSetGarcon: TDataSet;
begin
  if (Mensagem('Deseja Inserir os Garçons nas suas Mesas?', mtConfirmation,
    [mbYES, mbNO], mrYes, 0) = mrYes) then
  begin
    ApagarGarconMesa;

    lDataSetMesa := CarregarMesasAtiva(SomenteMesasemuso1.Checked);
    lDataSetGarcon := CarregarTodosGarcons;

    lDataSetMesa.First;
    while not lDataSetMesa.Eof do
    begin
      lDataSetGarcon.First;
      while not lDataSetGarcon.Eof do
      begin
        CarregarGarconsMesas(lDataSetMesa.FieldByName('RESTAURANTE_MESA_ID')
          .Value, lDataSetGarcon.FieldByName('RESTAURANTE_GARCON_ID').Value);

        lDataSetGarcon.Next;
      end;
      lDataSetMesa.Next;
    end;
  end;
end;

procedure TPrincipalForm.CarregarGarconsMesas(aIdMesa, aIdGarcon: String);
begin
  BancoDados.Conexao.StartTransaction(BancoDados.Transacao);
  try
    BancoDados.qryExecute.SQL.Text := 'insert into restaurante_mesa_garcon(' +
      'restaurante_mesa_id,restaurante_garcon_id) ' + ' values (' + aIdMesa +
      ', ' + aIdGarcon + ');';
    BancoDados.qryExecute.ExecSQL(True);
    BancoDados.Conexao.Commit(BancoDados.Transacao);
  except
    BancoDados.Conexao.Rollback(BancoDados.Transacao);
    raise Exception.Create('Não foi possivel adicionar o garcon a mesa');
  end;
end;

function TPrincipalForm.CarregarMesasAtiva(Value: Boolean): TDataSet;
begin
  BancoDados.CDSRestauranteMesa.Close;
  BancoDados.qryRestauranteMesa.SQL.Text :=
    'select * from restaurante_mesa where ativo = 1';

  if Value then
    BancoDados.qryRestauranteMesa.SQL.Add(' and status <> ' +
      QuotedStr('LIVRE'));

  BancoDados.qryRestauranteMesa.SQL.Add('order by numero');
  BancoDados.CDSRestauranteMesa.Open;

  Result := BancoDados.CDSRestauranteMesa;
end;

function TPrincipalForm.CarregarTodosGarcons: TDataSet;
begin
  BancoDados.CDSRestauranteGarcon.Close;
  BancoDados.qryRestauranteGarcon.SQL.Text :=
    'select * from restaurante_garcon';
  BancoDados.CDSRestauranteGarcon.Open;

  Result := BancoDados.CDSRestauranteGarcon;
end;

procedure TPrincipalForm.ChamaMesa(aTitulo, aDescricao: String; var aMesa: Integer);
begin
  TItemForm.New(Application)
    .Title(aTitulo)
    .Descricao(aDescricao)
    .Show
    .Mesa(aMesa);
end;

procedure TPrincipalForm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  TxtAlign, XOffset, RectWidth: Integer;
begin
  if (DataCol = 1) then
  begin
    DBGrid1.Canvas.Font.Color := clWindow;
    if (BancoDados.CDSRestauranteMesaSTATUS.Value = 'LIVRE') then
      DBGrid1.Canvas.Brush.Color := clLime
    else if (BancoDados.CDSRestauranteMesaSTATUS.Value = 'OCUPADA') then
      DBGrid1.Canvas.Brush.Color := clYellow
    else if (BancoDados.CDSRestauranteMesaSTATUS.Value = 'ENCERRANDO') then
      DBGrid1.Canvas.Brush.Color := clBlue;
  end;

  DBGrid1.Fields[0].Alignment := taCenter;
  DBGrid1.Fields[1].Alignment := taCenter;
  DBGrid1.Fields[2].Alignment := taCenter;
  DBGrid1.Fields[3].Alignment := taRightJustify;
  DBGrid1.Canvas.FillRect(Rect);
  DBGrid1.DefaultDrawDataCell(Rect, DBGrid1.columns[DataCol].field, State);
end;

procedure TPrincipalForm.DBGrid2TitleClick(Column: TColumn);
begin
  try
    BancoDados.CDSItens.DisableControls;
    BancoDados.CDSItens.Close;
    BancoDados.qryItens.SQL.Text := 'select produto_id, descricao, und, preco,'
      + 'COALESCE(sum(quantidade), 0.0)as QUANTIDADE,COALESCE(sum(total), 0.0)as TOTAL'
      + ' from restaurante_comanda_item where cancelado = 0 and restaurante_comanda_id = '
      + IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.Value) +
      'group by produto_id, descricao, und, preco';
    BancoDados.CDSItens.Open;
    BancoDados.CDSItens.First;
  finally
    BancoDados.CDSItens.EnableControls;
  end;
end;

procedure TPrincipalForm.EditCodigoExit(Sender: TObject);
begin
  if (EditCodigo.Text <> '') then
  begin
    if (TestaInteiro(EditCodigo.Text)) then
    begin
      BancoDados.CDSUnidade.Close;
      BancoDados.qryUnidade.SQL.Text := 'select * from unidade';
      BancoDados.CDSUnidade.Open;

      BancoDados.CDSProduto.Close;
      BancoDados.qryProduto.SQL.Text := 'select p.*,pp.preco from produto p ' +
        'left join produto_preco pp on (p.produto_id=pp.produto_id) ' +
        'where p.produto_id = ' + EditCodigo.Text;
      BancoDados.CDSProduto.Open;

      if (BancoDados.CDSProduto.IsEmpty) then
      begin
        Mensagem('Produto não Encontrado!', mtWarning, [mbOk], mrOk, 0);
        EditCodigo.SetFocus;
        Abort;
      end
      else
      begin
        EditCodigo.Text := FormatFloat('0000000000',
          BancoDados.CDSProdutoPRODUTO_ID.Value);
        EditDescricao.Text := BancoDados.CDSProdutoDESCRICAO.Value;
        EditQtd.SetFocus;
      end;
    end;
  end;
end;

procedure TPrincipalForm.EditCodigoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if (EditCodigo.Text <> '') then
    begin
      if (TestaInteiro(EditCodigo.Text)) then
      begin
        BancoDados.CDSUnidade.Close;
        BancoDados.qryUnidade.SQL.Text := 'select * from unidade';
        BancoDados.CDSUnidade.Open;

        BancoDados.CDSProduto.Close;
        BancoDados.qryProduto.SQL.Text := 'select p.*,pp.preco from produto p '
          + 'left join produto_preco pp on (p.produto_id = pp.produto_id) ' +
          'where p.produto_id = ' + EditCodigo.Text;
        BancoDados.CDSProduto.Open;

        if (BancoDados.CDSProduto.IsEmpty) then
        begin
          Mensagem('Produto não Encontrado!', mtWarning, [mbOk], mrOk, 0);
          EditCodigo.Text := '';
          EditCodigo.SetFocus;
          Abort;
        end
        else
        begin
          EditCodigo.Text := FormatFloat('0000000000',
            BancoDados.CDSProdutoPRODUTO_ID.Value);
          EditDescricao.Text := BancoDados.CDSProdutoDESCRICAO.Value;
          EditQtd.Value := 1;
          EditQtd.SetFocus;
        end;
      end;
    end
    else
    begin
      try
        if not Assigned(PesquisaProdutoForm) then
          PesquisaProdutoForm := TPesquisaProdutoForm.Create(Application);
        if (PesquisaProdutoForm.ShowModal = mrOk) then
          EditCodigo.Text := FormatFloat('0000000000',
            BancoDados.CDSProdutoPRODUTO_ID.Value);
        EditCodigo.SetFocus;
      finally
        PesquisaProdutoForm.Free;
        PesquisaProdutoForm := nil;
      end;
    end;
  end;
end;

procedure TPrincipalForm.EditQtdKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    if (EditQtd.Value > 0) then
    begin
      try
        BancoDados.CDSItens.DisableControls;

        try
          BancoDados.CDSRestauranteComandaItem.Open;
          BancoDados.CDSRestauranteComandaItem.Append;
          BancoDados.CDSRestauranteComandaItemPRODUTO_ID.Value :=
            BancoDados.CDSProdutoPRODUTO_ID.Value;
          BancoDados.CDSRestauranteComandaItemDESCRICAO.Value :=
            BancoDados.CDSProdutoDESCRICAO.Value;
          BancoDados.CDSRestauranteComandaItemUND.Value :=
            BancoDados.CDSProdutol_unidade.Value;
          BancoDados.CDSRestauranteComandaItemPRECO.Value :=
            BancoDados.CDSProdutoPRECO.Value;
          BancoDados.CDSRestauranteComandaItemQUANTIDADE.Value := EditQtd.Value;
          BancoDados.CDSRestauranteComandaItemTOTAL.Value :=
            (BancoDados.CDSProdutoPRECO.Value * EditQtd.Value);
          BancoDados.CDSRestauranteComandaItem.Post;
          BancoDados.CDSRestauranteComandaItem.Close;
        except
          Mensagem('Falha ao Tentar inserir um novo Produto!', mtWarning,
            [mbOk], mrOk, 0);
        end;

        BancoDados.CDSItens.Close;
        BancoDados.qryItens.SQL.Text :=
          'select produto_id, descricao, und, preco,' +
          'COALESCE(sum(quantidade), 0.0)as QUANTIDADE,COALESCE(sum(total), 0.0)as TOTAL'
          + ' from restaurante_comanda_item where cancelado = 0 and restaurante_comanda_id = '
          + IntToStr(BancoDados.CDSRestauranteComandaRESTAURANTE_COMANDA_ID.
          Value) + 'group by produto_id, descricao, und, preco';
        BancoDados.CDSItens.Open;

        with BancoDados.qryAuxiliar do
        begin
          Close;
          SQL.Clear;
          SQL.Add('select COALESCE(sum(total), 0.0) as total from restaurante_comanda_item '
            + 'where cancelado = 0 and restaurante_comanda_id = ' +
            IntToStr(BancoDados.
            CDSRestauranteComandaRESTAURANTE_COMANDA_ID.Value));
          Open;
        end;
        LBTotal.Caption := FormatFloat('R$ ,0.00',
          BancoDados.qryAuxiliar.Fields[0].Value);
      finally
        EditQtd.Value := 1;
        EditDescricao.Text := '';
        EditCodigo.Text := '';
        EditCodigo.SetFocus;
        BancoDados.CDSItens.EnableControls;
      end;
    end
    else
    begin
      Mensagem('Informe uma Quantidade maior que zero!', mtWarning,
        [mbOk], mrOk, 0);
      EditQtd.SetFocus;
      Abort;
    end;
  end;
end;

procedure TPrincipalForm.FinalizarVenda;
begin
  if not Assigned(FinalizadoraForm) then
    FinalizadoraForm := TFinalizadoraForm.Create(Application);

  BancoDados.CDSVenda.Close;
  BancoDados.qryVenda.SQL.Text := 'select * from venda where venda_id = ' +
    IntToStr(BancoDados.VendaID);
  BancoDados.CDSVenda.Open;

  FinalizadoraForm.ShowModal;
end;

procedure TPrincipalForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  case Application.MessageBox('Deseja Sair do Sistema?', 'Atenção',
    MB_YesNo + mb_DefButton2 + mb_IconQuestion) of
    6:
      BancoDados.FinalizarConexao(SomenteMesasemuso1.Checked);
    7:
      Abort;
  end;
end;

procedure TPrincipalForm.FormCreate(Sender: TObject);
begin
  ApplicationEvents.Activate;
end;

procedure TPrincipalForm.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #27) then
  begin
    Key := #0;
    Close;
  end;
end;

procedure TPrincipalForm.FormShow(Sender: TObject);
begin
  LogarVendedor;
  Caption := 'MasterSoft - Módulo MasterRestaurante';
  NBPrincipal.Visible := False;
end;

end.
