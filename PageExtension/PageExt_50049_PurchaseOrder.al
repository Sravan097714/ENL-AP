pageextension 50049 "Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        moveafter("No."; Description)

        /*modify(Description)
        {
            Caption = 'Remarks';
            Visible = false;
        }
        */
        modify("VAT Prod. Posting Group")
        {
            Visible = true;
        }


    }

    actions
    {
        // Add changes to page actions here
    }

    trigger OnAfterGetRecord()
    var
        GLAccountRec: Record "G/L Account";
    begin

        if GLAccountRec.GET(Rec."No.") then GLAccName := GLAccountRec.Name;
    end;

    var
        GLAccName: Text[100];
}