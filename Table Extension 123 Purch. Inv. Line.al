tableextension 50123 "Purch. Inv. Line" extends "Purch. Inv. Line"
{
    fields
    {
        field(60000; "Trip No."; Code[20])
        {
            Editable = false;
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