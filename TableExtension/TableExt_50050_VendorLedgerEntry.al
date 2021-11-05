tableextension 50050 "Vendor Ledger Entry Table Ext" extends "Vendor Ledger Entry"
{
    fields
    {
        // Add changes to table fields here
        field(60000; "Released By"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Released By';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(60001; "Released On"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Released On';
            TableRelation = User."User Name";
            ValidateTableRelation = false;
        }
        field(60002; PurchaseOrderNo; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60003; "Approval Status"; Enum "Approval Status")
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Approval Entry".Status where("Document No." = field("Document No."), "Approval Code" = filter('MS-GJLAPW**')));
            Caption = 'Approval Status';
        }
        field(50032; "PO_Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Approved By';

        }
        field(50033; "PI Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Invoice Approved By';
        }
        field(50034; "PO-Approved By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Purchase Order Approved By';
        }
        modify("On Hold")
        {
            trigger OnAfterValidate()
            begin
                if rec."On Hold" = '' then begin
                    "Released By" := UserId();
                    "Released On" := CurrentDateTime;
                    Modify();
                end
                else begin
                    "Released By" := '';
                    "Released On" := 0DT;
                    Modify();
                end;
            end;
        }
    }

}