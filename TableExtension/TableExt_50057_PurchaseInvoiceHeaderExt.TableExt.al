tableextension 50057 PurchaseInvoiceHeaderExt extends "Purch. Inv. Header"
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