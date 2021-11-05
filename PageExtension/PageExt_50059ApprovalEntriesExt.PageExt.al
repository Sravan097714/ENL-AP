pageextension 50059 ApprovalEntriesExt extends "Approval Entries"
{
    layout
    {
        addbefore(Overdue)
        {
            field("DocumentNo."; "Document No.")
            {
                ApplicationArea = all;
            }
        }
        modify(Overdue) { Visible = false; }
        modify("Limit Type") { Visible = false; }
        modify("Approval Type") { Visible = false; }
        modify(RecordIDText) { Visible = false; }
        modify("Salespers./Purch. Code") { Visible = false; }
        modify("Available Credit Limit (LCY)") { Visible = false; }
        /* addafter("Sender ID")
        {
            field(SenderName; Sender_Name)
            {
                ApplicationArea = all;
            }
        }
        addafter("Approver ID")
        {
            field(ApproverName; Approver_Name)
            {
                ApplicationArea = all;
            }
        } */
        addafter(Status)
        {
            field(Sender_Name; Sender_Name) { ApplicationArea = all; Caption = 'Sender Name'; }
            field(Approver_Name; Approver_Name) { ApplicationArea = all; Caption = 'Approver Name'; }

        }
        modify("Sender ID") { Visible = false; }
        modify("Approver ID") { Visible = false; }
        modify("Last Modified By User ID") { Visible = false; }

        addafter("Last Date-Time Modified")
        {
            field(lastmodifiedusername; lastmodifiedusername)
            {
                ApplicationArea = all;
                Caption = 'Last Modified By';
            }
        }
    }

    actions
    {
        // Add changes to page actions here
        modify(Record)
        {
            Visible = false;
            Enabled = false;
        }
        modify(Comments)
        {
            Visible = false;
        }
        modify("O&verdue Entries")
        {
            Visible = false;
        }
        modify("All Entries")
        {
            Visible = false;
        }
        modify("&Show")
        {
            Visible = false;
        }


        /* addafter("&Delegate")
        {
            action("Record1")
            {
                ApplicationArea = Suite;
                Caption = 'Record';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Open the document, journal line, or card that the approval request is for.';
                trigger OnAction()

                var
                    PurchaseHeader: Record "Purchase Header";

                begin

                    //     if Rec."Document Type" = Rec."Document Type"::Order then begin
                    //         PurchaseHeader.SetRange("No.", Rec."Document No.");
                    //         Page.RunModal(50055, PurchaseHeader);
                    //     end

                    //     else
                    Rec.ShowRecord;

                end;
            }
        } */


    }
    trigger OnAfterGetRecord()
    var
        userrec: Record User;
    begin
        userrec.Reset();
        userrec.SetRange("User Name", "Approver ID");
        if userrec.FindFirst then
            Approver_Name := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Sender ID");
        if userrec.FindFirst then
            Sender_Name := userrec."Full Name";

        userrec.Reset();
        userrec.SetRange("User Name", "Last Modified By User ID");
        if userrec.FindFirst then
            lastmodifiedusername := userrec."Full Name";
    end;

    var
        lastmodifiedusername: Text;
}