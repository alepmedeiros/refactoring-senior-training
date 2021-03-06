unit MasterRestaurante.Infra.Interfaces;

interface

uses
  Data.DB;

type
  iQuery = interface
    function StartTransaction : iQuery;
    function SQL(value: String) : iQuery;
    function Params(aParams: String; Value: Variant) : iQuery; overload;
    function Params(aParams: String) : Variant; overload;
    function Open: iQuery;
    function ExecSQL : iQuery;
    function DataSet(Value: TDataSource) : iQuery; overload;
    function DataSet : TDataSet; overload;
    function Commit : iQuery;
    function Rollback : iQuery;
  end;

implementation

end.
