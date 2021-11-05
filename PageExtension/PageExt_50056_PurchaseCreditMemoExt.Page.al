pageextension 50056 PurchaseCreditMemoExt extends "Purchase Credit Memo"
{
    layout
    {
        addafter(Status)
        {
            field(PurchaseOrderNo; Rec.PurchaseOrderNo)
            {
                ToolTip = 'Purchase Order No.';
                ApplicationArea = All;

            }

            field(ReceiptNo; Rec.ReceiptNo)
            {
                ToolTip = 'Receipt No.';
                ApplicationArea = All;

            }


        }

        addbefore("Attached Documents")
        {
            part("Purchase Order Attachment"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Purchase Order';
                Visible = false;

                SubPageLink = "Table ID" = CONST(38),
                              "Document Type" = CONST(Order),
                              "No." = field(PurchaseOrderNo);
            }
        }
        modify("Posting Description")
        {
            ShowMandatory = NOT IsBlank;
        }

    }

    actions
    {

    }
    var
        IsBlank: Boolean;

}