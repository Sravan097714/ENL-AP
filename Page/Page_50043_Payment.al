page 50043 "Payment Cues"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = 81;

    layout
    {
        area(Content)
        {

            cuegroup(Payment)
            {
                field(OnHold; OnHoldCountVar)
                {
                    ApplicationArea = All;
                    Caption = 'On Hold Payment';
                    ToolTip = 'On Hold Payment';
                    /* LookupPageId = "";
                    DrillDownPageId = ""; */
                    TableRelation = "Gen. Journal Line"."Line No." where("On Hold" = const('Y'));
                }
                field(Rejected; RejectedCountVar)
                {
                    ApplicationArea = All;
                    Caption = 'Rejected Payment';
                    /* LookupPageId = "";
                    DrillDownPageId = ""; */
                    ToolTip = 'Rejected Payment';
                }
                field(Approved; ApprovedCountVar)
                {
                    ApplicationArea = All;
                    Caption = 'Approved Payment';
                    /* LookupPageId = "";
                    DrillDownPageId = ""; */
                    ToolTip = 'Approved Payment';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        OnHoldCountVar: Integer;
        ApprovedCountVar: Integer;
        RejectedCountVar: Integer;

}