pageextension 50139 "Posted Purch. Invoice Subform" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addafter(Quantity)
        {
            field("Trip No."; "Trip No.") { }
            field("Trip Execution Date"; "Trip Execution Date") { }
            field("Cost Entry No."; "Cost Entry No.") { }
        }
    }
}