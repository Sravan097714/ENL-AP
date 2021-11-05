page 50044 "Pay Vendor New"
{
    ApplicationArea = Basic, Suite;
    Caption = 'Released Vendor Invoice Status';
    DataCaptionFields = "Vendor No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Worksheet;
    Permissions = TableData "Vendor Ledger Entry" = m;
    PromotedActionCategories = 'New,Process,Report,Line,Entry';
    SourceTable = "Vendor Ledger Entry";
    SourceTableView = SORTING("Entry No.")
                      ORDER(Descending) WHERE("Document Type" = filter('Invoice' | 'Credit Memo'));
    UsageCategory = History;

    layout
    {
        area(content)
        {
            group(FilterSection)
            {
                Caption = 'Filters';

                field(PostingDate; PostingDateVar)
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date';
                    ToolTip = 'Filter by Posting Date';
                    trigger OnValidate()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin
                        if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                        if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                        if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                        SetRange(Rec."On Hold", OnHoldVar);
                        if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                        if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                        CurrPage.Update(false);
                    end;
                }
                field(DueDate; DueDateVar)
                {
                    ApplicationArea = All;
                    Caption = 'Due Date';
                    ToolTip = 'Filter by Due Date';
                    trigger OnValidate()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin

                        if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                        if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                        if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                        SetRange(Rec."On Hold", OnHoldVar);
                        if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                        if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                        CurrPage.Update(false);
                    end;
                }
                field(DocumentNo; DocumentNoVar)
                {
                    ApplicationArea = All;
                    Caption = 'Document No';
                    ToolTip = 'Filter by Document No';
                    trigger OnLookup(var text: text): Boolean
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                        VendorLedgerEntries: Page "Vendor Ledger Entries";
                    begin
                        if DueDateVar <> 0D then VendorLedgerEntry.SetRange("Due Date", DueDateVar);
                        if VendorNoVar <> '' then VendorLedgerEntry.SetRange("Vendor No.", VendorNoVar);
                        if OnHoldVar <> '' then VendorLedgerEntry.SetRange("On Hold", OnHoldVar);
                        if DocumentType <> DocumentType::" " then VendorLedgerEntry.SetRange("Document Type", DocumentType);
                        if PostingDateVar <> 0D then VendorLedgerEntry.SetRange("Posting Date", PostingDateVar);
                        VendorLedgerEntries.SetTableView(VendorLedgerEntry);
                        VendorLedgerEntries.LookupMode(true);

                        if VendorLedgerEntries.RunModal() = Action::LookupOK then begin
                            VendorLedgerEntries.GetRecord(VendorLedgerEntry);
                            DocumentNoVar := VendorLedgerEntry."Document No.";
                            if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                            if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                            if OnHoldVar <> '' then SetRange(Rec."On Hold", OnHoldVar) else SetRange(rec."On Hold");
                            if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                            if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                            if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                            CurrPage.Update(false);
                        end;
                    end;

                    trigger OnValidate()
                    begin

                        if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                        if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                        if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                        if OnHoldVar <> '' then SetRange(Rec."On Hold", OnHoldVar) else SetRange(rec."On Hold");
                        if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                        if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                        CurrPage.Update(false);
                    end;
                }
                field(VendorNo; VendorNoVar)
                {
                    ApplicationArea = All;
                    TableRelation = "Vendor Ledger Entry"."Vendor No." where("Posting Date" = field("Posting Date"), "Document No." = field("Document No."));
                    Caption = 'Vendor No';
                    ToolTip = 'Filter by Vendor No';
                    trigger OnLookup(var text: text): Boolean
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                        VendorLedgerEntries: Page "Vendor Ledger Entries";
                    begin
                        if DueDateVar <> 0D then VendorLedgerEntry.SetRange("Due Date", DueDateVar);
                        if DocumentNoVar <> '' then VendorLedgerEntry.SetRange("Document No.", DocumentNoVar);
                        if OnHoldVar <> '' then VendorLedgerEntry.SetRange("On Hold", OnHoldVar);
                        if DocumentType <> DocumentType::" " then VendorLedgerEntry.SetRange("Document Type", DocumentType);
                        if PostingDateVar <> 0D then VendorLedgerEntry.SetRange("Posting Date", PostingDateVar);

                        VendorLedgerEntries.SetTableView(VendorLedgerEntry);
                        VendorLedgerEntries.LookupMode(true);
                        if VendorLedgerEntries.RunModal() = Action::LookupOK then begin
                            VendorLedgerEntries.GetRecord(VendorLedgerEntry);
                            VendorNoVar := VendorLedgerEntry."Vendor No.";

                            if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                            if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                            if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                            if OnHoldVar <> '' then SetRange(Rec."On Hold", OnHoldVar) else SetRange(rec."On Hold");
                            if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                            if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                            if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                            CurrPage.Update(false);
                        end;
                    end;

                    trigger OnValidate()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                    begin

                        if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                        if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                        if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                        if OnHoldVar <> '' then SetRange(Rec."On Hold", OnHoldVar);
                        if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                        if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                        CurrPage.Update(false);
                    end;
                }
                field(OnHold; OnHoldVar)
                {
                    ApplicationArea = All;
                    Caption = 'On Hold';
                    //Image = Delete;
                    ToolTip = 'Filter by On Hold';
                    trigger OnLookup(var text: text): Boolean
                    begin

                        SetRange("On Hold");
                        CurrPage.Update(false);
                    end;

                    trigger OnValidate()
                    var
                        VendorLedgerEntry: Record "Vendor Ledger Entry";
                        VendorLedgerEntries: Page "Vendor Ledger Entries";
                    begin
                        if DueDateVar <> 0D then VendorLedgerEntry.SetRange("Due Date", DueDateVar);
                        if DocumentNoVar <> '' then VendorLedgerEntry.SetRange("Document No.", DocumentNoVar);
                        if VendorNoVar <> '' then VendorLedgerEntry.SetRange("Vendor No.", VendorNoVar);
                        if DocumentType <> DocumentType::" " then VendorLedgerEntry.SetRange("Document Type", DocumentType);
                        if PostingDateVar <> 0D then VendorLedgerEntry.SetRange("Posting Date", PostingDateVar);
                        SetRange(Rec."On Hold", OnHoldVar);
                        CurrPage.Update(false);
                    end;
                }
                field(DocumentType; DocumentType)
                {
                    ApplicationArea = All;
                    Caption = 'Document Type';
                    ToolTip = 'Filter by Document Type';
                    trigger OnValidate()
                    begin

                        if DueDateVar <> 0D then SetRange(Rec."Due Date", DueDateVar) else SetRange(rec."Due Date");
                        if DocumentNoVar <> '' then SetRange(Rec."Document No.", DocumentNoVar) else SetRange(rec."Document No.");
                        if VendorNoVar <> '' then SetRange(Rec."Vendor No.", VendorNoVar) else SetRange(rec."Vendor No.");
                        if OnHoldVar <> '' then SetRange(Rec."On Hold", OnHoldVar) else SetRange(rec."On Hold");
                        if DocumentType <> DocumentType::" " then SetRange(Rec."Document Type", DocumentType) else SetRange(rec."Document Type");
                        if PostingDateVar <> 0D then SetRange(Rec."Posting Date", PostingDateVar) else SetRange(Rec."Posting Date");
                        CurrPage.Update(false);
                    end;
                }
            }
            repeater(Control1)
            {
                ShowCaption = false;
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the vendor entry''s posting date.';
                }

                field("Due Date"; Rec."Due Date")
                {
                    ApplicationArea = Basic, Suite;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the due date on the entry.';
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the document type that the vendor entry belongs to.';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the vendor entry''s document number.';
                }
                field("External Document No."; Rec."External Document No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies a document number that refers to the customer''s or vendor''s numbering system.';
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the vendor account that the entry is linked to.';
                }
                /* field("Vendor Name"; Rec."Vendor Name")
                {

                    ApplicationArea = all;
                    ToolTip = 'Specifies the Vendor Name of the vendor account that the entry is linked to.';
                    Enabled = true;
                    Editable = false;
                    Visible = true;
                } */
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ToolTip = 'Specifies the Vendor Name of the vendor account that the entry is linked to.';
                    Visible = VendNameVisible;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the currency code for the amount on the line.';
                }
                field("Remaining Amount"; Rec."Remaining Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("Remaining Amt. (LCY)"; Rec."Remaining Amt. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that remains to be applied to before the entry is totally applied to.';
                }
                field("On Hold"; Rec."On Hold")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies that the related entry represents an unpaid invoice for which either a payment suggestion, a reminder, or a finance charge memo exists.';
                }
                field("Released By"; Rec."Released By")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the person who released';
                    Editable = false;
                }
                field("Released On"; Rec."Released On")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the time when released';
                    Editable = false;
                }
                field("Message to Recipient"; Rec."Message to Recipient")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the message exported to the payment file when you use the Export Payments to File function in the Payment Journal window.';
                    Visible = false;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies a description of the vendor entry.';
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = Dimensions;
                    Editable = false;
                    ToolTip = 'Specifies the code for the global dimension that is linked to the record or entry for analysis purposes. Two global dimensions, typically for the company''s most important activities, are available on all cards, documents, reports, and lists.';
                    Visible = false;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = Intercompany;
                    Editable = false;
                    ToolTip = 'Specifies the code of the intercompany partner that the transaction is related to if the entry was created from an intercompany transaction.';
                    Visible = false;
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies which purchaser is assigned to the vendor.';
                    Visible = false;
                }

                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies how to make payment, such as with bank transfer, cash, or check.';
                }
                field("Payment Reference"; Rec."Payment Reference")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the payment of the purchase invoice.';
                }
                field("Creditor No."; Rec."Creditor No.")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the vendor who sent the purchase invoice.';
                }
                field("Original Amount"; Rec."Original Amount")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the original entry.';
                }
                field("Original Amt. (LCY)"; Rec."Original Amt. (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount that the entry originally consisted of, in LCY.';
                    Visible = false;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry.';
                    Visible = AmountVisible;
                }
                field("Amount (LCY)"; Rec."Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the amount of the entry in LCY.';
                    Visible = AmountVisible;
                }
                field("Debit Amount"; Rec."Debit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits.';
                    Visible = DebitCreditVisible;
                }
                field("Debit Amount (LCY)"; Rec."Debit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent debits, expressed in LCY.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount"; Rec."Credit Amount")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits.';
                    Visible = DebitCreditVisible;
                }
                field("Credit Amount (LCY)"; Rec."Credit Amount (LCY)")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the total of the ledger entries that represent credits, expressed in LCY.';
                    Visible = DebitCreditVisible;
                }

                field("Bal. Account Type"; Rec."Bal. Account Type")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the type of account that a balancing entry is posted to, such as BANK for a cash account.';
                    Visible = false;
                }
                field("Bal. Account No."; Rec."Bal. Account No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the general ledger, customer, vendor, or bank account that the balancing entry is posted to, such as a cash account for cash purchases.';
                    Visible = false;
                }
                field("Pmt. Discount Date"; Rec."Pmt. Discount Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the date on which the amount in the entry must be paid for a payment discount to be granted.';
                }
                field("Pmt. Disc. Tolerance Date"; Rec."Pmt. Disc. Tolerance Date")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the latest date the amount in the entry must be paid in order for payment discount tolerance to be granted.';
                }
                field("Original Pmt. Disc. Possible"; Rec."Original Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the discount that you can obtain if the entry is applied to before the payment discount date.';
                }
                field("Remaining Pmt. Disc. Possible"; Rec."Remaining Pmt. Disc. Possible")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the remaining payment discount which can be received if the payment is made before the payment discount date.';
                }
                field("Max. Payment Tolerance"; Rec."Max. Payment Tolerance")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the maximum tolerated amount the entry can differ from the amount on the invoice or credit memo.';
                }
                field(Open; Rec.Open)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies whether the amount on the entry has been fully paid or there is still a remaining amount that must be applied to.';
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the ID of the user who posted the entry, to be used, for example, in the change log.';
                    Visible = false;

                    trigger OnDrillDown()
                    var
                        UserMgt: Codeunit "User Management";
                    begin
                        UserMgt.DisplayUserInformation(Rec."User ID");
                    end;
                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the source code that specifies where the entry was created.';
                    Visible = false;
                }
                field("Reason Code"; Rec."Reason Code")
                {
                    ApplicationArea = Suite;
                    Editable = false;
                    ToolTip = 'Specifies the reason code, a supplementary source code that enables you to trace the entry.';
                    Visible = false;
                }
                field(Reversed; Rec.Reversed)
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies if the entry has been part of a reverse transaction.';
                    Visible = false;
                }
                field("Reversed by Entry No."; Rec."Reversed by Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the correcting entry that replaced the original entry in the reverse transaction.';
                    Visible = false;
                }
                field("Reversed Entry No."; Rec."Reversed Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the original entry that was undone by the reverse transaction.';
                    Visible = false;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    ToolTip = 'Specifies the number of the entry, as assigned from the specified number series when the entry was created.';
                }
                field("Exported to Payment File"; Rec."Exported to Payment File")
                {
                    ApplicationArea = Basic, Suite;
                    Editable = true;
                    ToolTip = 'Specifies that the entry was created as a result of exporting a payment journal line.';

                    trigger OnValidate()
                    var
                        ConfirmManagement: Codeunit "Confirm Management";
                    begin
                        if not ConfirmManagement.GetResponseOrDefault(ExportToPaymentFileConfirmTxt, true) then
                            Error('');
                    end;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = Dimensions;
                    ToolTip = 'Specifies a reference to a combination of dimension values. The actual values are stored in the Dimension Set Entry table.';
                    Visible = false;
                }
                field(RecipientBankAcc; Rec."Recipient Bank Account")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the bank account to transfer the amount to.';
                }
            }
        }
        area(factboxes)
        {
            part(IncomingDocAttachFactBox; "Incoming Doc. Attach. FactBox")
            {
                ApplicationArea = Basic, Suite;
                ShowFilter = false;
                SubPageLink = "Posting Date" = field("Posting Date"), "Document No." = field("Document No.");
            }

            part("Purchase Attached Documents"; "Document Attachment Factbox")
            {
                ApplicationArea = All;
                Caption = 'Purchase order/Invoice Attachments';
                SubPageLink = "Table ID" = filter(122 | 124), "No." = field("Document No.");
            }
            part("Vendor Attached Documents"; Attachment)
            {
                ApplicationArea = All;
                Caption = 'Vendor Attachments';
                SubPageLink = "Table ID" = CONST(25), "No." = field("Document No.");
            }
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(ViewReport)
            {
                ApplicationArea = All;
                Caption = 'View Supplier Invoice Release For Payment';
                Image = PrintAttachment;
                Promoted = true;
                PromotedCategory = Report;
                ToolTip = 'View a PDF file';

                trigger OnAction()
                begin
                    Report.Run(Report::"Invoice Release For Payment");
                end;
            }
            action(ViewReportForVendor)
            {
                ApplicationArea = All;
                Caption = 'View this Supplier Invoice Release For Payment';
                Image = PrintAttachment;
                Scope = Repeater;
                PromotedCategory = Category4;
                Promoted = true;
                ToolTip = 'View a PDF file';

                trigger OnAction()
                var
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                begin
                    VendorLedgerEntry.SetRange("Vendor No.", Rec."Vendor No.");
                    Report.RunModal(Report::"Invoice Release For Payment", true, true, VendorLedgerEntry);
                end;
            }

            action(RelaseInvoice)
            {
                ApplicationArea = All;
                Caption = 'Release Invoice';
                Image = ReleaseDoc;
                ToolTip = 'Release Invoice';
                Promoted = true;
                Scope = Repeater;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    VendorLedgerEntryRec: Record "Vendor Ledger Entry";
                begin

                    CurrPage.SetSelectionFilter(VendorLedgerEntryRec);
                    if VendorLedgerEntryRec.FindSet() then
                        repeat
                            VendorLedgerEntryRec."On Hold" := '';
                            VendorLedgerEntryRec."Released By" := UserId;
                            VendorLedgerEntryRec."Released On" := CurrentDateTime;
                            VendorLedgerEntryRec.Modify();
                        until VendorLedgerEntryRec.Next() = 0;
                end;
            }
            action("Show Document")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Document';
                Image = Document;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ShortCutKey = 'Return';
                ToolTip = 'Show details for the posted payment, invoice, or credit memo.';

                trigger OnAction()
                begin
                    ShowDoc
                end;
            }
            action(DocAttach)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';

                trigger OnAction()
                var
                    DocumentAttachmentDetails: Page "Document Attachment Details";
                    RecRef: RecordRef;
                begin
                    RecRef.GetTable(Rec);
                    DocumentAttachmentDetails.OpenForRecRef(RecRef);
                    DocumentAttachmentDetails.RunModal;
                end;
            }
            action(AttachAsPDF)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attach Purchase Invoice/Order as PDF';
                Image = PrintAttachment;
                Promoted = true;
                Scope = Repeater;
                PromotedCategory = Process;
                ToolTip = 'Create a PDF file and attach it to the document.';

                trigger OnAction()
                var
                    PurchInvHeader: Record "Purch. Inv. Header";
                begin
                    if PurchInvHeader.Get(Rec."Document No.") then begin
                        PurchInvHeader.SetRecFilter();
                        PrintToDocumentAttachment(PurchInvHeader);
                    end;
                end;
            }
            action(AttachVendorAsPDF)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Attach Supplier Invoice Release for Payment as PDF';
                Image = PrintAttachment;
                Promoted = true;
                Scope = Repeater;
                PromotedCategory = Process;
                ToolTip = 'Create a PDF file and attach it to the document.';

                trigger OnAction()
                var
                    ImportFile: File;
                    InStreamVar: InStream;
                    FileName: Text[250];
                    OutStreamVar: OutStream;
                    RecRef: RecordRef;
                    TempBlob_lRec: Codeunit "Temp Blob";
                    LineNo: Integer;
                    IdVar: Integer;
                    TableId: Integer;
                    VendorLedgerEntry: Record "Vendor Ledger Entry";
                    PurchaseInvHeader: Record 122;
                    DocumentAttachment: Record "Document Attachment";
                    VendorRec: Record Vendor;
                begin
                    Rec.SetRange("Vendor No.", Rec."Vendor No.");
                    RecRef.GetTable(Rec);
                    FileName := 'Supplier_Invoice_' + Rec."Vendor No." + '.pdf';
                    TempBlob_lRec.CreateOutStream(OutStreamVar);
                    Report.SaveAs(Report::"Invoice Release For Payment", '', ReportFormat::Pdf, OutStreamVar, RecRef);
                    TempBlob_lRec.CreateInStream(InStreamVar);

                    CLEAR(DocumentAttachment);
                    DocumentAttachment.Validate("No.", Rec."Document No.");
                    DocumentAttachment.SaveAttachmentFromStream(InStreamVar, RecRef, FileName);
                    Rec.SetRange("Vendor No.");
                end;
            }
            action(ShowDocumentAttachment)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Show Document Attachment';
                Enabled = HasDocumentAttachment;
                Image = Attach;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'View documents or images that are attached to the posted invoice or credit memo.';

                trigger OnAction()
                begin
                    ShowPostedDocAttachment;
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IncomingDocument: Record "Incoming Document";
    begin
        HasIncomingDocument := IncomingDocument.PostedDocExists("Document No.", "Posting Date");
        HasDocumentAttachment := HasPostedDocAttachment;
    end;

    trigger OnAfterGetRecord()
    begin
        StyleTxt := SetStyle;
    end;

    trigger OnInit()
    begin
        AmountVisible := true;
    end;

    trigger OnModifyRecord(): Boolean
    begin
        CODEUNIT.Run(CODEUNIT::"Vend. Entry-Edit", Rec);
        exit(false);
    end;

    trigger OnOpenPage()
    begin

    end;

    var
        StyleTxt: Text;
        HasIncomingDocument: Boolean;
        HasDocumentAttachment: Boolean;
        AmountVisible: Boolean;
        DebitCreditVisible: Boolean;
        VendNameVisible: Boolean;
        ExportToPaymentFileConfirmTxt: Label 'Editing the Exported to Payment File field will change the payment suggestions in the Payment Journal. Edit this field only if you must correct a mistake.\Do you want to continue?';

    var
        PostingDateVar: Date;
        DueDateVar: Date;
        DocumentNoVar: Code[20];
        OnHoldVar: Code[3];
        VendorNoVar: Code[20];

        DocumentType: Enum "Gen. Journal Document Type";

    local procedure PrintToDocumentAttachment(var PurchInvHeaderLocal: Record "Purch. Inv. Header")
    var
        ShowNotificationAction: Boolean;
    begin
        ShowNotificationAction := PurchInvHeaderLocal.Count() = 1;
        if PurchInvHeaderLocal.FindSet() then
            repeat
                DoPrintToDocumentAttachment(PurchInvHeaderLocal, ShowNotificationAction);
            until PurchInvHeaderLocal.Next() = 0;
    end;

    local procedure DoPrintToDocumentAttachment(PurchInvHeaderLocal: Record "Purch. Inv. Header"; ShowNotificationAction: Boolean)
    var
        ReportSelections: Record "Report Selections";
    begin
        PurchInvHeaderLocal.SetRecFilter();

        ReportSelections.SaveAsDocumentAttachment(
            ReportSelections.Usage::"P.Invoice".AsInteger(), PurchInvHeaderLocal, PurchInvHeaderLocal."No.", PurchInvHeaderLocal."Buy-from Vendor No.", true);
    end;
}

