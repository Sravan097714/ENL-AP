pageextension 50063 "Purchase Order" extends "Purchase Order"
{
    layout
    {
        addafter(Control1904651607)
        {
            part(PostedApprovalEntries; "Posted Approval Entries List")
            {
                ApplicationArea = All;
                Caption = 'Approvals Log';
                SubPageLink = "Document No." = field("No.");
            }
        }
    }
}