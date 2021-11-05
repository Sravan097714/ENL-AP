codeunit 50041 "Import Templates"
{
    trigger OnRun()
    begin
    end;

    procedure ImportPurchaseJnl()
    var
        GenJournalLine: Record "Gen. Journal Line";
        ExcelBufferRec: Record "Excel Buffer";
        Name: Text;
        Sheetname: Text;
        ImportStream: InStream;
        Rows: Integer;
        LineNo: Integer;
        UploadResult: Boolean;
        RowNo: Integer;
        DocumentNo: Text[10];
        NumberSeriesLinesRec: Record "No. Series Line";
    begin
        ExcelBufferRec.DeleteAll();
        UploadResult := UploadIntoStream('Select file to upload', '', '', Name, ImportStream);
        Sheetname := ExcelBufferRec.SelectSheetsNameStream(ImportStream);

        if Sheetname <> '' then begin
            ExcelBufferRec.OpenBookStream(ImportStream, Sheetname);
            ExcelBufferRec.ReadSheet();
            Rows := ExcelBufferRec."Row No.";

            NumberSeriesLinesRec.SetRange("Series Code", 'GEN');
            if NumberSeriesLinesRec.FindLast() then DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            GenJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            GenJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if GenJournalLine.FindLast() then begin
                LineNo += GenJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := JournalBatchName;
                GenJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(GenJournalLine."Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Posting Date");

                Evaluate(GenJournalLine."Document Date", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document Date");

                Evaluate(GenJournalLine."Due Date", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Due Date");

                Evaluate(GenJournalLine."Document No.", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document No.");

                Evaluate(GenJournalLine."Document Type", GetValueAtIndex(RowNo, 5, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document Type");

                Evaluate(GenJournalLine."External Document No.", GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."External Document No.");

                Evaluate(GenJournalLine."Account Type", GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account Type");

                Evaluate(GenJournalLine."Account No.", GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account No.");

                Evaluate(GenJournalLine."Gen. Prod. Posting Group", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Gen. Prod. Posting Group");

                Evaluate(GenJournalLine."Gen. Posting Type", GetValueAtIndex(RowNo, 10, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Gen. Posting Type");

                Evaluate(GenJournalLine."VAT Prod. Posting Group", GetValueAtIndex(RowNo, 11, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."VAT Prod. Posting Group");

                Evaluate(GenJournalLine."Currency Code", GetValueAtIndex(RowNo, 12, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Currency Code");

                Evaluate(GenJournalLine.Description, GetValueAtIndex(RowNo, 13, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Description);

                Evaluate(GenJournalLine.Amount, GetValueAtIndex(RowNo, 14, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Amount);

                Evaluate(GenJournalLine."Amount (LCY)", GetValueAtIndex(RowNo, 15, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Amount (LCY)");

                Evaluate(GenJournalLine."VAT Amount", GetValueAtIndex(RowNo, 16, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."VAT Amount");


                Evaluate(GenJournalLine."Bal. Account Type", GetValueAtIndex(RowNo, 17, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");

                Evaluate(GenJournalLine."Bal. Account No.", GetValueAtIndex(RowNo, 18, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");

                Evaluate(GenJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 19, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");

                Evaluate(GenJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 20, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");



                GenJournalLine.Insert();
                LineNo := LineNo + 10000;
                DocumentNo := IncStr(DocumentNo);
            end;
            Message('Import Completed');
        end;
    end;

    procedure ImportGenJnlFile()
    var
        GenJournalLine: Record "Gen. Journal Line";
        ExcelBufferRec: Record "Excel Buffer";
        Name: Text;
        Sheetname: Text;
        ImportStream: InStream;
        Rows: Integer;
        LineNo: Integer;
        UploadResult: Boolean;
        RowNo: Integer;
        DocumentNo: Text[10];
        NumberSeriesLinesRec: Record "No. Series Line";
    //Coloums: Integer;
    begin
        ExcelBufferRec.DeleteAll();
        UploadResult := UploadIntoStream('Select file to upload', '', '', Name, ImportStream);
        Sheetname := ExcelBufferRec.SelectSheetsNameStream(ImportStream);

        if Sheetname <> '' then begin
            ExcelBufferRec.OpenBookStream(ImportStream, Sheetname);
            ExcelBufferRec.ReadSheet();
            Rows := ExcelBufferRec."Row No.";

            NumberSeriesLinesRec.SetRange("Series Code", 'GEN');
            if NumberSeriesLinesRec.FindLast() then DocumentNo := IncStr(format(NumberSeriesLinesRec."Last No. Used"));

            GenJournalLine.SetFilter("Journal Batch Name", JournalBatchName);
            GenJournalLine.SetFilter("Journal Template Name", JournalTemplateName);
            if GenJournalLine.FindLast() then begin
                LineNo += GenJournalLine."Line No." + 10000;
            end
            else begin
                LineNo := 10000;
            end;

            for RowNo := 2 to Rows do begin

                GenJournalLine."Line No." := LineNo;
                GenJournalLine."Journal Batch Name" := JournalBatchName;
                GenJournalLine."Journal Template Name" := JournalTemplateName;

                Evaluate(GenJournalLine."Posting Date", GetValueAtIndex(RowNo, 1, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Posting Date");

                Evaluate(GenJournalLine."Document Date", GetValueAtIndex(RowNo, 2, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document Date");

                Evaluate(GenJournalLine."Due Date", GetValueAtIndex(RowNo, 3, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Due Date");

                Evaluate(GenJournalLine."Document No.", GetValueAtIndex(RowNo, 4, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document No.");

                Evaluate(GenJournalLine."Document Type", GetValueAtIndex(RowNo, 5, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Document Type");

                Evaluate(GenJournalLine."External Document No.", GetValueAtIndex(RowNo, 6, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."External Document No.");

                Evaluate(GenJournalLine."Account Type", GetValueAtIndex(RowNo, 7, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account Type");

                Evaluate(GenJournalLine."Account No.", GetValueAtIndex(RowNo, 8, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Account No.");

                Evaluate(GenJournalLine."Currency Code", GetValueAtIndex(RowNo, 9, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Currency Code");

                Evaluate(GenJournalLine.Description, GetValueAtIndex(RowNo, 10, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Description);

                Evaluate(GenJournalLine.Amount, GetValueAtIndex(RowNo, 11, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine.Amount);

                Evaluate(GenJournalLine."Amount (LCY)", GetValueAtIndex(RowNo, 12, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Amount (LCY)");

                Evaluate(GenJournalLine."Bal. Account Type", GetValueAtIndex(RowNo, 13, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account Type");

                Evaluate(GenJournalLine."Bal. Account No.", GetValueAtIndex(RowNo, 14, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Bal. Account No.");

                Evaluate(GenJournalLine."Shortcut Dimension 1 Code", GetValueAtIndex(RowNo, 15, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 1 Code");

                Evaluate(GenJournalLine."Shortcut Dimension 2 Code", GetValueAtIndex(RowNo, 16, ExcelBufferRec));
                GenJournalLine.Validate(GenJournalLine."Shortcut Dimension 2 Code");

                GenJournalLine.Insert();
                LineNo := LineNo + 10000;
                DocumentNo := IncStr(DocumentNo);
            end;
            Message('Import Completed');
        end;
    end;

    procedure SetJournalTemplateBatch(Template: Code[10]; Batch: Code[10])
    begin
        JournalTemplateName := Template;
        JournalBatchName := Batch;
    end;

    var
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];

    local procedure GetValueAtIndex(RowNo: Integer; ColNo: Integer; ExcelBufferRec: Record "Excel Buffer"): Text
    begin
        ExcelBufferRec.Reset();
        If ExcelBufferRec.Get(RowNo, ColNo) then
            exit(ExcelBufferRec."Cell Value as Text");

    end;



    //TempEmailItem.SetBodyText('Dear Sir/Madam,' + '<br><br>' + 'Kindly find attached your electronic invoice.' + '<br><br>' + 'Kind Regards,');

    //LPDV/TempEmailItem.SetBodyText('Dear Collaborator,' + '<br><br>' + 'Please find enclosed requested Purchase Order for your further handling.' + '<br><br>' + 'Kindly send the corresponding invoice on tbhoyroo@enl.mu; dchummun@enl.mu.' + '<br><br>' + 'Do not hesitate to contact us if you need any additional information.' + '<br><br>' + 'Regards,' + '<br><br>' + 'Tej Bhoyroo');
    //Courchamps/TempEmailItem.SetBodyText('Dear Collaborator,' + '<br><br>' + 'Please find enclosed requested Purchase Order for your further handling.' + '<br><br>' + 'Kindly send the corresponding invoice on ahofthed@enl.mu; mvencatapillay@enl.mu.' + '<br><br>' + 'Do not hesitate to contact us if you need any additional information.' + '<br><br>' + 'Regards,' + '<br><br>' + 'Anne Sophie Hofthed');
    //MokaResidential/TempEmailItem.SetBodyText('Dear Collaborator,' + '<br><br>' + 'Please find enclosed requested Purchase Order for your further handling.' + '<br><br>' + 'Kindly send the corresponding invoice on mlabour@enl.mu; mvencatapillay@enl.mu.' + '<br><br>' + 'Do not hesitate to contact us if you need any additional information.' + '<br><br>' + 'Regards,' + '<br><br>' + 'Melissa Labour');
    //MokaCity/TempEmailItem.SetBodyText('Dear Collaborator,' + '<br><br>' + 'Please find enclosed requested Purchase Order for your further handling.' + '<br><br>' + 'Kindly send the corresponding invoice on mlabour@enl.mu; mvencatapillay@enl.mu.' + '<br><br>' + 'Do not hesitate to contact us if you need any additional information.' + '<br><br>' + 'Regards,' + '<br><br>' + 'Melissa Labour');
}