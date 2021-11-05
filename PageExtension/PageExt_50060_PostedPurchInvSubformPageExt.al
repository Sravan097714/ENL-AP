pageextension 50060 PostedPurchInvSubformPageExt extends 139
{
    layout
    {
        addafter("Line Amount")
        {
            field("VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
        }
    }


}