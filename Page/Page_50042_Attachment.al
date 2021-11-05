page 50042 "Attachment"
{
    Caption = 'Documents Attached';
    PageType = CardPart;
    SourceTable = "Document Attachment";

    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;
                field(Documents; NumberOfRecords)
                {
                    ApplicationArea = All;
                    Caption = 'Documents';
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the number of attachments.';

                    trigger OnDrillDown()
                    var
                        DocumentAttached: Record "Document Attachment";
                    begin
                        DocumentAttached.SetFilter("No.", Rec."No.");
                        DocumentAttached.SetFilter("Table ID", '25');
                        Page.Run(Page::"Document Attachment Details", DocumentAttached);
                    end;
                }
            }
        }
    }

    actions
    {
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
    end;

    trigger OnAfterGetCurrRecord()
    var
        currentFilterGroup: Integer;
    begin
        currentFilterGroup := FilterGroup;
        FilterGroup := 4;

        NumberOfRecords := 0;
        if GetFilters() <> '' then
            NumberOfRecords := Count;
        FilterGroup := currentFilterGroup;
    end;

    var
        NumberOfRecords: Integer;
}

