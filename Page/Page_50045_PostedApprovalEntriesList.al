page 50045 "Posted Approval Entries List"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Approval Entry";
    Caption = 'Posted Approval Entries List';

    layout
    {
        area(Content)
        {
            field(Approvername; Approvername)
            {
                ApplicationArea = All;
                Caption = 'Approved By';
            }
            field("Last Date-Time Modified"; "Last Date-Time Modified")
            {
                ApplicationArea = all;
                Caption = 'Approved On';
            }
        }
    }

    var
        Approvername: Text[100];

    trigger OnAfterGetRecord()
    var
        UserRec: Record User;
    begin

        UserRec.SetRange("User Name", "Approver ID");
        if UserRec.FindFirst() then Approvername := UserRec."Full Name";
    end;
}