tableextension 50055 IncomingDocumentTableExt extends "Incoming Document"
{
    fields
    {
        // Add changes to table fields here
        field(50000; PurchaseOrderNo; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purchase Header"."No.";
        }

        field(50001; ReceiptNo; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Purch. Rcpt. Header"."No." where("Order No." = field(PurchaseOrderNo));
        }

        field(50002; PurchaserCode; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Salesperson/Purchaser".Code;
        }



    }

    var
        myInt: Integer;
}