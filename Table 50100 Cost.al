table 50058 Cost
{
    LookupPageId = "Cost List";

    fields
    {
        field(1; "entryNo"; Integer)
        {
            CaptionML = ENU = 'entryNo';
        }
        field(2; id; Guid)
        {

        }
        field(3; "tripNo"; Text[250])
        {
            CaptionML = ENU = 'Trip No.';
        }
        field(4; "costExecutiondate"; Date)
        {
            CaptionML = ENU = 'Cost Executiondate';
        }
        field(5; "type"; Text[250])
        {
            CaptionML = ENU = 'Type';
        }
        field(6; "costNo"; Text[250])
        {
            CaptionML = ENU = 'Cost No.';
        }
        field(7; "description"; Text[250])
        {
            CaptionML = ENU = 'Description';
        }
        field(8; "quantity"; Decimal)
        {
            CaptionML = ENU = 'Quantity';
        }
        field(9; "amount"; Decimal)
        {
            CaptionML = ENU = 'Amount';
        }
        field(10; "shortcutDimension1Code"; Text[250])
        {
            CaptionML = ENU = 'shortcutDimension1Code';
        }
        field(11; "truckNo"; Text[250])
        {
            CaptionML = ENU = 'truckNo';
        }
        field(12; "truckDescription"; Text[250])
        {
            CaptionML = ENU = 'truckDescription';
        }
        field(13; "driverNo"; Text[250])
        {
            CaptionML = ENU = 'driverNo';
        }
        field(14; "driverName"; Text[250])
        {
            CaptionML = ENU = 'driverName';
        }
        field(15; "trailerNo"; Text[250])
        {
            CaptionML = ENU = 'trailerNo';
        }
        field(16; "trailerDescription"; Text[250])
        {
            CaptionML = ENU = 'trailerDescription';
        }
        field(17; "transportOrderNo"; Text[250])
        {
            CaptionML = ENU = 'transportOrderNo';
        }
        field(18; "transportOrderLineNo"; Integer)
        {
            CaptionML = ENU = 'transportOrderLineNo';
        }
        field(19; "irrNo"; Integer)
        {
            CaptionML = ENU = 'irrNo';
        }
        field(20; "legNo"; Integer)
        {
            CaptionML = ENU = 'legNo';
        }
        field(21; "unitOfMeasureCode"; Text[250])
        {
            CaptionML = ENU = 'unitOfMeasureCode';
        }
        field(22; "payToVendorNo"; Text[250])
        {
            CaptionML = ENU = 'payToVendorNo';
        }
        field(23; "vendorName"; Text[250])
        {
            CaptionML = ENU = 'vendorName';
        }
        field(24; "currencyCode"; Text[250])
        {
            CaptionML = ENU = 'currencyCode';
            trigger OnValidate();
            begin
                if currencyCode = '' then
                    currencyCode := 'EUR';
            end;
        }
        field(25; company; Text[30]) { }
        field(26; open; Boolean) { }
        field(27; genProdPostingGroup; Code[20]) { }
        field(28; unitCost; Decimal) { }
        field(29; invoiced; Boolean) { }
    }
    fieldgroups
    {
        fieldgroup(DropDown; tripNo, vendorName, costExecutiondate, quantity, unitCost, amount) { }
    }
    procedure Refreshcosts();
    var
        Refreshcosts: Codeunit "Cost API";
    begin
        Refreshcosts.Refresh();
    end;

    procedure SetOpen();
    var
        Refreshcosts: Codeunit "Cost API";
    begin
        Refreshcosts.ExecuteFunction('(' + Format(entryNo) + ')/NAV.SetOpen');
    end;

    procedure SetClosed();
    var
        Refreshcosts: Codeunit "Cost API";
    begin
        Refreshcosts.ExecuteFunction('(' + Format(entryNo) + ')/NAV.SetClosed');
    end;

}
