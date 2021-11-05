pageextension 50046 "Vendor Ledger Entry Page Ext" extends "Vendor Ledger Entries"
{
    Caption = 'Vendor Ledger Entry Page Exentention';
    Description = 'Update the position of Onhold field';

    layout
    {
        /*addbefore(IncomingDocAttachFactBox)
        {
            part("Purchase Order Attachment"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order';

                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = CONST(Order),
                              "No." = field(PurchaseOrderNo);
            }
        }
        */

        // Add changes to page layout here
        addbefore("Currency Code")
        {
            field("On Hold1"; REC."On Hold")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'On Hold';
                ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
            }
        }
        addafter("On Hold1")
        {
            field("Released By"; Rec."Released By")
            {
                ApplicationArea = All;
                Caption = 'Released By';
                ToolTip = 'Person who released this invoice';
            }
            field("Released On"; Rec."Released On")
            {
                ApplicationArea = All;
                Caption = 'Released By';
                ToolTip = 'Date/Time when this invoice was released';
            }
        }
        modify("On Hold")
        {
            Visible = false;
        }

        addafter(IncomingDocAttachFactBox)
        {
            part("Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = filter(122 | 124), "No." = field("Document No.");
            }
        }

        addafter("User ID")
        {
            field("PO_Approved By"; "PO_Approved By")
            {
                ApplicationArea = all;
            }
            field("PI Approved By"; "PI Approved By")
            {
                ApplicationArea = all;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

}