tableextension 50060 GenJnlLineExt extends "Gen. Journal Line"
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