pageextension 50054 "Purchase Journal" extends "Purchase Journal"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Document_Date"; "Document Date")
            {
                ApplicationArea = all;
            }

            field("Due_Date"; "Due Date")
            {
                ApplicationArea = all;
            }

        }
        addafter(Description)
        {
            field("VATProd. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = all;
            }
            field("VAT %"; "VAT %")
            {
                ApplicationArea = all;
                Editable = true;
            }
            field("VATAmount"; "VAT Amount")
            {
                ApplicationArea = all;
            }

        }
        modify("Number of Lines")
        {
            Visible = false;
        }
        modify(Control1903866901)
        {
            Visible = false;
        }
        modify("Total Balance")
        {
            Visible = false;
        }
    }
    actions
    {
        addafter("Apply Entries")
        {
            action("Import Entries")
            {
                ApplicationArea = All;
                Caption = 'Import Entries';
                Promoted = true;
                PromotedCategory = Process;
                Image = Import;
                ToolTip = 'Import journal from desktop';

                trigger OnAction()
                var
                    GenImportData: Codeunit "Import Templates";
                begin
                    GenImportData.SetJournalTemplateBatch(Rec."Journal Template Name", Rec."Journal Batch Name");
                    GenImportData.ImportPurchaseJnl();
                end;
            }
        }
    }
}