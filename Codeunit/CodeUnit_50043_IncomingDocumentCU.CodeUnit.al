codeunit 50043 IncomingDocumentCodeUnit
{

    Permissions = tabledata "Vendor Ledger Entry" = rm;
    trigger OnRun()
    begin

    end;



    [EventSubscriber(ObjectType::Table, database::"Incoming Document", 'OnBeforeCreateManually', '', true, true)]

    local procedure DisableOptionBtn(var IncomingDocument: Record "Incoming Document"; var IsHandled: Boolean)
    var
        RelatedRecord: Variant;
        DocumentTypeOption: Integer;
        PurchaseInvoiceTxt: Label 'Purchase Invoice';
        PurchaseCreditMemoTxt: Label 'Purchase Credit Memo';


    begin
        IsHandled := true;

        IncomingDocument.GetRecord(RelatedRecord);
        DocumentTypeOption :=
          StrMenu(
            StrSubstNo('%1,%2', PurchaseInvoiceTxt, PurchaseCreditMemoTxt), 1);

        if DocumentTypeOption < 1 then
            exit;

        //DocumentTypeOption -= 1;



        if DocumentTypeOption = 1 then
            IncomingDocument.CreatePurchInvoice()
        else
            IncomingDocument.CreatePurchCreditMemo();

    end;

    [EventSubscriber(ObjectType::Table, database::"Incoming Document", 'OnCreatePurchDocOnBeforeShowRecord', '', true, true)]
    local procedure AddVendorInfo(IncomingDocument: Record "Incoming Document"; var IsHandled: Boolean)
    var
        purchaseHeader: Record "Purchase Header";
        orderHeader: Record "Purchase Header";
        DocPrint: Codeunit "Document-Print";
        RecRef: RecordRef;
        DocumentAttachment: Record "Document Attachment";
        TempBlob: Codeunit "Temp Blob";
        Filename: Text[100];
        OutStreamVar: OutStream;
        InStreamVar: InStream;



    begin
        //find the order created newly
        purchaseHeader.Reset();
        purchaseHeader.SetRange("Incoming Document Entry No.", IncomingDocument."Entry No.");
        if purchaseHeader.FindFirst() then begin
            //retrieveing vendor no.
            orderHeader.Reset();
            orderHeader.SetRange("Document Type", orderHeader."Document Type"::Order);
            orderHeader.SetRange("No.", IncomingDocument.PurchaseOrderNo);
            if orderHeader.FindFirst() then begin
                purchaseHeader.Validate("Buy-from Vendor No.", orderHeader."Buy-from Vendor No.");
                purchaseHeader."Purchaser Code" := IncomingDocument.PurchaserCode;
                purchaseHeader.PurchaseOrderNo := IncomingDocument.PurchaseOrderNo;
                purchaseHeader.ReceiptNo := IncomingDocument.ReceiptNo;

                purchaseHeader.Modify();


            end;
        end;

    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Purch.-Get Receipt", 'OnAfterPurchRcptLineSetFilters', '', true, true)]
    local procedure FilterReciptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchaseHeader: Record "Purchase Header")

    begin
        PurchRcptLine.SetFilter("Document No.", PurchaseHeader.ReceiptNo);
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Release Purchase Document", 'OnAfterManualReleasePurchaseDoc', '', true, true)]
    local procedure AttachDocument(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean)
    var
        DocPrint: Codeunit "Document-Print";
    begin
        PurchaseHeader.SetRecFilter();
        DocPrint.PrintPurchaseHeaderToDocumentAttachment(PurchaseHeader);
    end;


    [EventSubscriber(ObjectType::Codeunit, codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitVendLedgEntry', '', true, true)]
    local procedure AttachPurchaseDocumentInVLEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry")
    var
        PurchaseInvoiceHeader: Record "Purch. Inv. Header";
        PurchaseCreditMemo: Record "Purch. Cr. Memo Hdr.";

    begin

        if (VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::Invoice) then begin
            PurchaseInvoiceHeader.Reset();
            PurchaseInvoiceHeader.SetRange("No.", VendorLedgerEntry."Document No.");
            if PurchaseInvoiceHeader.FindFirst() then
                VendorLedgerEntry.PurchaseOrderNo := PurchaseInvoiceHeader.PurchaseOrderNo;

        end

        else

            if (VendorLedgerEntry."Document Type" = VendorLedgerEntry."Document Type"::"Credit Memo") then begin
                PurchaseInvoiceHeader.Reset();
                PurchaseCreditMemo.SetRange("No.", VendorLedgerEntry."Document No.");
                if PurchaseCreditMemo.FindFirst() then
                    VendorLedgerEntry.PurchaseOrderNo := PurchaseCreditMemo.PurchaseOrderNo;

            end;

    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Approvals Mgmt.", 'OnApproveApprovalRequest', '', true, true)]
    local procedure AttachPOOnApproval(var ApprovalEntry: Record "Approval Entry")
    var
        orderHeader: Record "Purchase Header";
        DocPrint: Codeunit "Document-Print";
    begin
        orderHeader.Reset();
        orderHeader.SetRange("Document Type", orderHeader."Document Type"::Order);
        orderHeader.SetRange("No.", ApprovalEntry."Document No.");
        if orderHeader.FindFirst() then
            DocPrint.PrintPurchaseHeaderToDocumentAttachment(orderHeader);

    end;


    [EventSubscriber(ObjectType::Codeunit, 74, 'OnBeforeTransferLineToPurchaseDoc', '', false, false)]
    local procedure OnBeforeTransferLineToPurchaseDoc(var PurchRcptHeader: Record "Purch. Rcpt. Header"; var PurchRcptLine: Record "Purch. Rcpt. Line"; var PurchaseHeader: Record "Purchase Header"; var TransferLine: Boolean)

    var
        documentattachmentrec: Record "Document Attachment";
        documentattachmentrec2: Record "Document Attachment";

    begin
        documentattachmentrec.Reset();
        documentattachmentrec.SetRange("No.", PurchRcptHeader."Order No.");
        documentattachmentrec.SetRange("Document Type", documentattachmentrec."Document Type"::Order);
        if documentattachmentrec.FindSet then begin
            repeat
                documentattachmentrec2.Init();
                documentattachmentrec2.Copy(documentattachmentrec);
                documentattachmentrec2."Document Type" := documentattachmentrec2."Document Type"::Invoice;
                documentattachmentrec2."No." := PurchaseHeader."No.";
                documentattachmentrec2.Insert();
                Commit();
            until documentattachmentrec.Next = 0;
        end;

    end;


    [EventSubscriber(ObjectType::Table, 49, 'OnAfterInvPostBufferPreparePurchase', '', false, false)]
    local procedure OnAfterInvPostBufferPreparePurchase(var PurchaseLine: Record "Purchase Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer")
    var
        purchaseheaderrec: Record "Purchase Header";
    begin
        purchaseheaderrec.Reset();
        purchaseheaderrec.SetRange("No.", PurchaseLine."Document No.");
        if purchaseheaderrec.FindFirst then begin
            purchaseheaderrec.CalcFields("PO_Approved By");
            purchaseheaderrec.CalcFields("PI Approved By");
            InvoicePostBuffer."PO_Approved By" := purchaseheaderrec."PO_Approved By";
            InvoicePostBuffer."PI Approved By" := purchaseheaderrec."PI Approved By";

        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnBeforePostInvPostBuffer', '', false, false)]
    local procedure OnBeforePostInvPostBuffer(VAR GenJnlLine: Record "Gen. Journal Line"; VAR InvoicePostBuffer: Record "Invoice Post. Buffer"; VAR PurchHeader: Record "Purchase Header"; VAR GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line"; PreviewMode: Boolean; CommitIsSupressed: Boolean)
    begin
        GenJnlLine."PO_Approved By" := InvoicePostBuffer."PO_Approved By";
        GenJnlLine."PI Approved By" := InvoicePostBuffer."PI Approved By";
    end;

    [EventSubscriber(ObjectType::Codeunit, 12, 'OnAfterInitVendLedgEntry', '', false, false)]
    local procedure InsertinVendLedgerEntry(VAR VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VendorLedgerEntry."PO_Approved By" := GenJournalLine."PO_Approved By";
        VendorLedgerEntry."PI Approved By" := GenJournalLine."PI Approved By";
    end;

    [EventSubscriber(ObjectType::Codeunit, 90, 'OnPostVendorEntryOnAfterInitNewLine', '', false, false)]
    local procedure OnPostVendorEntryOnAfterInitNewLine(var PurchaseHeader: Record "Purchase Header"; var GenJnlLine: Record "Gen. Journal Line")
    begin
        GenJnlLine."PO_Approved By" := PurchaseHeader."PO_Approved By";
        GenJnlLine."PI Approved By" := PurchaseHeader."PI Approved By";
    end;




}
