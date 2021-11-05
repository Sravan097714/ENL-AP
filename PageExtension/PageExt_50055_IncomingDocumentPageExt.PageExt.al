pageextension 50055 IncomingDocumentPageExt extends "Incoming Document"
{
    layout
    {
        // Add changes to page layout here
        addafter(Posted)
        {

            field("Vendor No."; Rec."Vendor No.")
            {
                ApplicationArea = All;
                Caption = 'Vendor No.';
                Tooltip = 'Vendor No.';
                TableRelation = "Vendor"."No.";
                trigger OnValidate()
                begin
                    if VendorRec.Get(Rec."Vendor No.") then
                        Rec."Vendor Name" := VendorRec.Name;
                    Rec."Vendor VAT Registration No." := VendorRec."VAT Registration No.";
                    Rec."Vendor Phone No." := VendorRec."Phone No.";

                end;

            }


            field(PurchaseOrderNo; Rec.PurchaseOrderNo)
            {

                ApplicationArea = All;
                Caption = 'Purchase Order No.';
                ToolTip = 'Purchase Order No.';
                //TableRelation = "Purchase Header"."No." where("Buy-from Vendor No." = field("Vendor No."));
                trigger OnLookup(var text: text): boolean
                var
                    PurchaseHeader: Record "Purchase Header";
                    PurchaseHeaderPage: Page "Purchase List";
                begin
                    if Rec."Vendor No." <> '' then PurchaseHeader.SetRange("Buy-from Vendor No.", Rec."Vendor No.");
                    PurchaseHeaderPage.SetTableView(PurchaseHeader);
                    PurchaseHeaderPage.LookupMode(true);

                    if PurchaseHeaderPage.RunModal() = Action::LookupOK then begin
                        PurchaseHeaderPage.GetRecord(PurchaseHeader);
                        Rec.PurchaseOrderNo := PurchaseHeader."No.";
                        // CurrPage.Update(false);
                    end;

                end;

            }

            field(ReceiptNo; Rec.ReceiptNo)
            {

                ApplicationArea = All;
                Caption = 'Receipt No.';
                Tooltip = 'Receipt No.';
                TableRelation = "Purch. Rcpt. Header"."No." where("Order No." = field(PurchaseOrderNo));

            }

            field(PurchaserCode; Rec.PurchaserCode)
            {
                ApplicationArea = All;
                Caption = 'Purchaser Code';
                Tooltip = 'Purchaser Code';
                TableRelation = "Salesperson/Purchaser".Code;
            }







        }



    }


    actions
    {
        // Add changes to page actions here
    }

    var
        VendorRec: Record Vendor;



}