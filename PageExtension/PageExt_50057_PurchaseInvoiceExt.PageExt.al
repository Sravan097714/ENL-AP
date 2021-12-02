pageextension 50057 PurchaseInvoiceExt extends "Purchase Invoice"
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
        // Add changes to page layout here
        addafter(Status)
        {
            field(PurchaseOrderNo; Rec.PurchaseOrderNo)
            {
                ToolTip = 'Purchase Order No.';
                ApplicationArea = All;

                trigger OnLookup(var text: text): boolean
                var
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseHeaderPage: Page "Purchase List";
                begin
                    if Rec."Buy-from Vendor No." <> '' then
                        PurchaseHeader.SetRange("Buy-from Vendor No.", Rec."Buy-from Vendor No.");
                    PurchaseHeaderPage.SetTableView(PurchaseHeader);
                    PurchaseHeaderPage.LookupMode(true);

                    if PurchaseHeaderPage.RunModal() = Action::LookupOK then begin
                        PurchaseHeaderPage.GetRecord(PurchaseHeader);
                        Rec.PurchaseOrderNo := PurchaseHeader."No.";
                        CurrPage.Update(true);
                    end;

                end;

                trigger OnValidate()
                begin
                    CurrPage.Update(true);
                end;

            }

            field(ReceiptNo; Rec.ReceiptNo)
            {
                ToolTip = 'Receipt No.';
                ApplicationArea = All;
                TableRelation = "Purch. Rcpt. Header"."No." where("Order No." = field(PurchaseOrderNo));

            }
            field("PO_Approved By"; "PO_Approved By")
            {
                ApplicationArea = all;
                Visible = false;
            }
            field("PI Approved By"; "PI Approved By")
            { ApplicationArea = all; Visible = false; }
        }

        /* addbefore("Attached Documents")
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


    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "PO_Approved By" := '';
    end;



}