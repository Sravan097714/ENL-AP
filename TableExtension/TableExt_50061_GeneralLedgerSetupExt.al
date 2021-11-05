tableextension 50042 GeneralLedgerSetupExt extends "General Ledger Setup"
{
    fields
    {
        field(50040; "TDS Account"; Code[20])
        {
            TableRelation = "G/L Account";
        }
    }

    var
        myInt: Integer;
}

