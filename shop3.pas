program shop;

uses crt, sysutils;


type
    tSortiment = record
        Artikel : string;
        Preis : single;
    end;
    

    tPosition = record
        Artikel : string;
        menge : integer;
        einzelpreis : single;
        gesamtpreis : single;
    end;

    tWarenkorb = record
        Positionen : array[1..20] of tPosition;
        anz_Artikel : integer;
        gesamtwert : single;
    end;

    tBank = record
        iban : string;
    end;

    tKunde = record
        Name : string;
        Einkaufskorb : tWarenkorb;
        Bankverbindung : tBank
    end;

var
    Sortiment : array[1..50] of tSortiment;
    Kunde : tKunde;
    eingabe : integer;
    maxArtikel : integer;
    angemeldet : boolean;
//-------------------------------------------
procedure init();
var
    Datei : Text;
    gelesen : string;
    anz, i : integer;
begin
    assign(Datei, 'sortiment.dat'); //Das Sortiment steht in dieser Textdatei
    reset(Datei);                   //1. Zeile: Anzahl der Elemente  
    if not eof(Datei) then
    begin
        readln(Datei, anz);
        maxArtikel := anz;
    end;
    for i := 1 to anz do
    begin
        readln(Datei, gelesen);
        Sortiment[i].Artikel := gelesen;
        readln(Datei, gelesen);
        Sortiment[i].Preis := StrToFloat(gelesen);
    end;
    close(Datei);
    Kunde.Name := '';
end;
//-------------------------------------------
procedure Laden();      //Laedt die Datei "kundenname.dat"
var
    Datei : file of tKunde;
    dateiname : string;
begin

    if Kunde.Name <> '' then
    begin
        dateiname := Kunde.Name + '.dat';
        if fileexists(dateiname) = true then
        begin
            assign(Datei, dateiname);
            reset(Datei);
            if not eof(Datei) then read(Datei, Kunde);
            close(Datei);
        end;
    end
    else 
    begin
        writeln('Nicht angemeldet... (Taste druecken)');
        readkey();
    end;
end;

//-------------------------------------------
procedure Speichern();      //Speichert die Datei "kundenname.dat"
var
    Datei : file of tKunde;
    dateiname : string;
begin
    if Kunde.Name <> '' then
    begin
        dateiname := Kunde.Name + '.dat';
        assign(Datei, dateiname);
        rewrite(Datei);
        write(Datei, Kunde);
        close(Datei);
    end
    else
    begin
        writeln('Nicht angemeldet. Daten werden nicht gespeichert. (Taste druecken)');
        readkey();
    end;
end;
//-------------------------------------------
procedure ArtikellisteAnzeigen();
var
    i : integer;
    p : single;
    x : String;
begin
    writeln();
    for i := 1 to maxArtikel do
    begin
        x := Sortiment[i].Artikel;
        p := Sortiment[i].Preis;
        writeln(i, ') ', x, ' (', p:0:2, ' Euro pro Stueck)');
    end;
    writeln();
    writeln();
end;
//-------------------------------------------
procedure ArtikelInWarenkorbLegen();
var
    artikel, menge, anz : integer;
begin
    ArtikellisteAnzeigen();
    write('Waehlen Sie einen Artikel: ');
    readln(artikel);
    write('Menge: ');
    read(menge);
    Kunde.Einkaufskorb.anz_Artikel := Kunde.Einkaufskorb.anz_Artikel + 1;
    anz := Kunde.Einkaufskorb.anz_Artikel;
    Kunde.Einkaufskorb.Positionen[anz].artikel := Sortiment[artikel].Artikel;
    Kunde.Einkaufskorb.Positionen[anz].menge := menge;
    Kunde.Einkaufskorb.Positionen[anz].einzelpreis := Sortiment[Artikel].Preis;
    Kunde.Einkaufskorb.Positionen[anz].gesamtpreis := Sortiment[Artikel].Preis * menge;
    Kunde.Einkaufskorb.gesamtwert := Kunde.Einkaufskorb.gesamtwert + Kunde.Einkaufskorb.Positionen[anz].gesamtpreis;
end;
//-------------------------------------------
procedure WarenkorbAnzeigen();
var
    i : integer;
    artikel : string;
    EinzelPreis, PositionPreis, GesamtPreis : single;
    menge : integer; 
begin
    writeln();
    writeln();
    writeln('Ihr Warenkorb:');
    writeln();
    for i := 1 to Kunde.Einkaufskorb.anz_Artikel do
    begin
        artikel := Kunde.Einkaufskorb.Positionen[i].artikel;
        menge := Kunde.Einkaufskorb.Positionen[i].menge;
        EinzelPreis := Kunde.Einkaufskorb.Positionen[i].einzelpreis;
        PositionPreis := Kunde.Einkaufskorb.Positionen[i].gesamtpreis;
        GesamtPreis := Kunde.Einkaufskorb.gesamtwert;

        writeln(menge, ' x ', artikel, ' zum Preis von ', Einzelpreis:0:2, ' = ', PositionPreis:0:2, ' Euro');
    end;
    writeln();
    writeln('Gesamtsumme: ', GesamtPreis:0:2, ' Euro');
    writeln();
    writeln();
    write('Taste druecken...');
    readkey();
end;
//-------------------------------------------
procedure Anmelden();
begin
    write('Ihr Benutzername: ');
    readln(Kunde.Name);
    Laden();
end;
//-------------------------------------------
begin //Hauptprogramm
    init();
    writeln('Datei gelesen');
    repeat
        clrscr();
        writeln('Angemeldet als: ', Kunde.Name);
        writeln();
        writeln();
        writeln('   1) Sortiment anzeigen');
        writeln('   2) Artikel in Warenkorb legen');
        writeln('   3) Warenkorb anzeigen');
        writeln('   9) Anmelden');
        writeln();
        writeln('   0) Beenden');
        writeln();
        write('==> ');
        readln(eingabe);
        case eingabe of
            1 : begin
                    ArtikellisteAnzeigen();
                    write('Taste druecken...');
                    readkey();
                end;
            2 : ArtikelInWarenkorbLegen();
            3 : WarenkorbAnzeigen();
            9 : Anmelden();
            0 : Speichern();
        end;
        writeln();
        writeln();
    until eingabe = 0;
end.