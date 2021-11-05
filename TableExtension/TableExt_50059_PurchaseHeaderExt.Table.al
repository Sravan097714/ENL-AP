tableextension 50059 PurchaseHeaderExt extends "Purchase Header"
{
    fields
    {
        field(50000; PurchaseOrderNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order No.';
        }

        field(50001; ReceiptNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt No.';
        }
        field(50003; "PI Approved By"; Text[50])
        {

            Caption = 'Purchase Invoice Approved By';
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field("No."), Status = filter(Approved)));
        }
        field(50004; "PO_Approved By"; Text[50])
        {

            Caption = 'Purchase Order Approved By';
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry"."Approver ID" where("Document No." = field(PurchaseOrderNo), Status = filter(Approved)));
        }

    }
    /*trigger OnInsert()
    begin
        "On Hold" := 'Y';
    end;
    */

}