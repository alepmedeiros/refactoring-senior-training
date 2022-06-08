unit MasterRestaurante.Infra.impl.datasetabstract;

interface

uses
  MasterRestaurante.Infra.Interfaces, Data.DB;

type
  TDataSetAbstract = class(TInterfacedObject, iDataSetAbstract)
    private
      FDataSet: TDataSet;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iDataSetAbstract;
      function UseDataSet(Value: TDataSet) : iDataSetAbstract;
      function Atualizar : iDataSetAbstract;
      function Fields(aField: String; aValue: Variant) : iDataSetAbstract;
      function Append : iDataSetAbstract;
      function Post : iDataSetAbstract;
  end;

implementation

function TDataSetAbstract.Append: iDataSetAbstract;
begin
  Result := Self;
  FDataSet.Append;
end;

function TDataSetAbstract.Atualizar: iDataSetAbstract;
begin
  Result := Self;
  FDataSet.Close;
  FDataSet.Open;
end;

constructor TDataSetAbstract.Create;
begin

end;

destructor TDataSetAbstract.Destroy;
begin

  inherited;
end;

function TDataSetAbstract.Fields(aField: String;
  aValue: Variant): iDataSetAbstract;
begin
  Result := Self;
  FDataSet.FieldByName(aField).Value := aValue;
end;

class function TDataSetAbstract.New : iDataSetAbstract;
begin
  Result := Self.Create;
end;

function TDataSetAbstract.Post: iDataSetAbstract;
begin
  Result := Self;
  FDataSet.Post;
end;

function TDataSetAbstract.UseDataSet(Value: TDataSet): iDataSetAbstract;
begin
  Result := Self;
  FDataSet:= Value;
end;

end.
