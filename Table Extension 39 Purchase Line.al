tableextension 50039 "Purchase Line" extends "Purchase Line"
{
    fields
    {
        field(60000; "Trip No."; Code[20])
        {
            TableRelation = Cost.tripNo where (tripNo = filter (<> ''),
                                               open=const(false),
                                               company=const('Riwo'));
            trigger OnValidate();
            var
                Cost: Record Cost;
            begin
                Cost.SetRange(tripNo, "Trip No.");
                if not Cost.FindFirst then begin
                    cost.Refreshcosts;
                    cost.FindFirst;
                end;
                "Trip Execution Date" := Cost.costExecutiondate;
                "Cost Entry No." := Cost.entryNo;
                Validate(Quantity, cost.quantity);
                Validate("Direct Unit Cost", cost.unitCost);
            end;
        }
        field(60001; "Trip Execution Date"; Date)
        {
            Editable = false;
        }
        field(60002; "Cost Entry No."; Integer)
        {
            Editable = false;
        }

    }

}