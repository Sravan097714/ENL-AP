pageextension 50047 SalesJnl extends "Sales Journal"
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

