page 50100 "Cost List"
{
    PageType = List;
    SourceTable = Cost;
    CaptionML = ENU = 'Cost';
    Editable = false;
    SourceTableView = order(descending);
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(open; open)
                {
                    ApplicationArea = All;
                }
                field("entryNo"; "entryNo")
                {
                    ApplicationArea = All;
                }
                field("tripNo"; "tripNo")
                {
                    ApplicationArea = All;
                }
                field("costExecutiondate"; "costExecutiondate")
                {
                    ApplicationArea = All;
                }
                field("type"; "type")
                {
                    ApplicationArea = All;
                }
                field("costNo"; "costNo")
                {
                    ApplicationArea = All;
                }
                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }
                field("quantity"; "quantity")
                {
                    ApplicationArea = All;
                }
                field("amount"; "amount")
                {
                    ApplicationArea = All;
                }
                field("shortcutDimension1Code"; "shortcutDimension1Code")
                {
                    ApplicationArea = All;
                }
                field("truckNo"; "truckNo")
                {
                    ApplicationArea = All;
                }
                field("truckDescription"; "truckDescription")
                {
                    ApplicationArea = All;
                }
                field("driverNo"; "driverNo")
                {
                    ApplicationArea = All;
                }
                field("driverName"; "driverName")
                {
                    ApplicationArea = All;
                }
                field("trailerNo"; "trailerNo")
                {
                    ApplicationArea = All;
                }
                field("trailerDescription"; "trailerDescription")
                {
                    ApplicationArea = All;
                }
                field("transportOrderNo"; "transportOrderNo")
                {
                    ApplicationArea = All;
                }
                field("transportOrderLineNo"; "transportOrderLineNo")
                {
                    ApplicationArea = All;
                }
                field("irrNo"; "irrNo")
                {
                    ApplicationArea = All;
                }
                field("legNo"; "legNo")
                {
                    ApplicationArea = All;
                }
                field("unitOfMeasureCode"; "unitOfMeasureCode")
                {
                    ApplicationArea = All;
                }
                field("payToVendorNo"; "payToVendorNo")
                {
                    ApplicationArea = All;
                }
                field("vendorName"; "vendorName")
                {
                    ApplicationArea = All;
                }
                field("currencyCode"; "currencyCode")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    actions
    {
        area(processing)
        {
            Action(Refreshcosts)
            {
                CaptionML = ENU = 'Refresh costs';
                Promoted = true;
                PromotedCategory = Process;
                Image = RefreshLines;
                ApplicationArea = All;
                trigger OnAction();
                begin
                    Refreshcosts();
                    CurrPage.Update;
                    if FindFirst then;
                end;
            }
            Action(TestOpen)
            {
                CaptionML = ENU = 'Test Open';
                Promoted = true;
                PromotedCategory = Process;
                Image = "DocumentEdit";
                ApplicationArea = All;
                trigger OnAction();
                begin
                    SetOpen;
                end;
            }
            Action(TestClosed)
            {
                CaptionML = ENU = 'Test Close';
                Promoted = true;
                PromotedCategory = Process;
                Image = "Close";
                ApplicationArea = All;
                trigger OnAction();
                begin
                    SetClosed;
                end;
            }
        }
    }
    trigger OnOpenPage();
    begin
        Refreshcosts();
    end;
}
