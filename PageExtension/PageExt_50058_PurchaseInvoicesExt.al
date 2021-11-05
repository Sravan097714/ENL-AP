pageextension 50058 PurchaseInvoicesExt extends 9308
{
    layout
    {
        addafter("No.")
        {
            field(stat; Status)
            {
                ApplicationArea = all;
            }
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Assigned User ID")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}