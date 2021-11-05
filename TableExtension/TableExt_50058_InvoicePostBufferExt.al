tableextension 50058 InvoicePostBufferExt extends "Invoice Post. Buffer"
{
    fields
    {
        field(50008; "PO_Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Approved By';
        }
        field(50009; "PI Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Invoice Approved By';
        }
    }

    var
        myInt: Integer;
}