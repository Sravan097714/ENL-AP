tableextension 50041 ApprovalEntryTableExt extends "Approval Entry"
{
    fields
    {
        field(50040; "ApprovName"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50041; "SendName"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50042; "Sender_Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50043; "Approver_Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnInsert()

    begin
        if "Document No." = '' then
            "Document No." := Format("Entry No.");
    end;


}