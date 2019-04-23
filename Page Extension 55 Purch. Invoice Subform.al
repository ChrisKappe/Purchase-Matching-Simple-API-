pageextension 50055 "Purch. Invoice Subform" extends "Purch. Invoice Subform"
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