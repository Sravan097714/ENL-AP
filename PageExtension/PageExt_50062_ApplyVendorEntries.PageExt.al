pageextension 50062 ApplyVendorEntries extends "Apply Vendor Entries"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {

    }
    // trigger OnOpenPage()
    // var

    // begin
    //     Rec.SetRange("On Hold", '');
    //     CurrPage.Update(false);

    // end;

    trigger OnOpenPage()
    var

    begin
        Rec.SetRange("Document Type", "Document Type"::"Credit Memo");
        Rec.SetRange("Document Type", "Document Type"::Invoice);
        CurrPage.Update(false);

    end;
}