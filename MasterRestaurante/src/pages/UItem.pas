unit UItem;

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
  StdCtrls,
  JvExStdCtrls,
  JvEdit,
  JvValidateEdit;

type
  TItemForm = class(TForm)
    EditItem: TJvValidateEdit;
    LBTexto: TLabel;
    procedure FormShow(Sender: TObject);
    procedure EditItemKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    class function New(AWoner: TComponent): TItemForm;
    function Title(Value: String) : TItemForm;
    function Descricao(Value: String) : TItemForm;
    function Mesa(var Value: Integer) : TItemForm;
    function Show : TItemForm;
  end;

var
  ItemForm: TItemForm;

implementation

uses Base,
  UFuncoes;
{$R *.dfm}

function TItemForm.Descricao(Value: String): TItemForm;
begin
  Result := Self;
  LBTexto.Caption := Value;
end;

procedure TItemForm.EditItemKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    ModalResult := mrOk;

  if (Key = #27) then
    ModalResult := mrCancel;
end;

procedure TItemForm.FormShow(Sender: TObject);
begin
  EditItem.SetFocus;
end;

function TItemForm.Mesa(var Value: Integer): TItemForm;
begin
  Result := Self;
  TryStrToInt(EditItem.Text,Value);
  if Value < 1 then
  begin
    Mensagem('Nenhuma Mesa foi informada!', mtWarning, [mbOk], mrOk, 0);
    Abort;
  end;
end;

class function TItemForm.New(AWoner: TComponent): TItemForm;
begin
  Result := Self.Create(AWoner);
end;

function TItemForm.Show: TItemForm;
begin
  Result := Self;
  Self.ShowModal;
end;

function TItemForm.Title(Value: String): TItemForm;
begin
  Result := Self;
  Self.Caption := Value;
end;

end.
