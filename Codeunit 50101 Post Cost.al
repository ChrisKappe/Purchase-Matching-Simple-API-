codeunit 50101 "Post Cost"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvLineInsert', '', false, false)]
    local procedure CreateViaAPI(PurchInvLine: Record "Purch. Inv. Line"; PurchInvHeader: Record "Purch. Inv. Header";
    PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; WhseShip: Boolean; WhseReceive: Boolean);
    var
        Cost: Record Cost;
        GLAcc: Record "G/L Account";
    begin
        if PurchLine.Type <> PurchLine.Type::"G/L Account" then
            exit;

        GLAcc.get(PurchLine."No.");
        if GLAcc."Trip No. Mandatory" then
            PurchLine.TestField("Trip No.");

        if PurchLine."Cost Entry No." = 0 then
            exit;

        Cost.Get(PurchLine."Cost Entry No.");
        Cost.SetClosed;
    end;
}