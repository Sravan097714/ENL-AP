tableextension 50056 PurchaseCreditMemoHeaderExt extends "Purch. Cr. Memo Hdr."
{
    fields
    {
        field(50000; PurchaseOrderNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Order No.';
        }

    }

}