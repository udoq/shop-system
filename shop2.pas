program shop;

uses crt;

const maxArtikel = 3;


type
    tArtikel = (Apfel=1, Birne, Banane);

    tPosition = record
        Artikel : tArtikel;
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
    Kunde : tKunde;
    ArtikelPreise : array[1..maxArtikel] of single = (1.40, 1.60, 1.80);
    i : integer;
    x : tArtikel;
    eingabe : integer;
//-------------------------------------------
procedure init();
begin
    Kunde.Bankverbindung.iban := 'DE300700240123456789';
end;
//-------------------------------------------
procedure ArtikellisteAnzeigen();
var
    i : integer;
    p : single;
    x : tArtikel;
begin
    writeln();
    for i := ord(low(tArtikel)) to ord(high(tArtikel)) do
    begin
        x := tArtikel(i);
        p := ArtikelPreise[i];
        writeln(i, ') ', x, ' (', p:0:2, ' Euro pro Stueck)');
    end;
    writeln();
end;
//-------------------------------------------
procedure ArtikelInWarenkorbLegen();
var
    artikel, menge, anz : integer;
begin
    init();
    ArtikellisteAnzeigen();
    write('Waehlen Sie einen Artikel: ');
    readln(artikel);
    write('Menge: ');
    read(menge);
    Kunde.Einkaufskorb.anz_Artikel := Kunde.Einkaufskorb.anz_Artikel + 1;
    anz := Kunde.Einkaufskorb.anz_Artikel;
    Kunde.Einkaufskorb.Positionen[anz].artikel := tArtikel(artikel);
    Kunde.Einkaufskorb.Positionen[anz].menge := menge;
    Kunde.Einkaufskorb.Positionen[anz].einzelpreis := ArtikelPreise[artikel];
    Kunde.Einkaufskorb.Positionen[anz].gesamtpreis := ArtikelPreise[artikel] * menge;
    Kunde.Einkaufskorb.gesamtwert := Kunde.Einkaufskorb.gesamtwert + Kunde.Einkaufskorb.Positionen[anz].gesamtpreis;
end;
//-------------------------------------------
procedure WarenkorbAnzeigen();
var
    i : integer;
    artikel : tArtikel;
    EinzelPreis, PositionPreis, GesamtPreis : single;
    menge : integer; 
begin
    for i := 1 to Kunde.Einkaufskorb.anz_Artikel do
    begin
        artikel := Kunde.Einkaufskorb.Positionen[i].artikel;
        menge := Kunde.Einkaufskorb.Positionen[i].menge;
        EinzelPreis := Kunde.Einkaufskorb.Positionen[i].einzelpreis;
        PositionPreis := Kunde.Einkaufskorb.Positionen[i].gesamtpreis;
        GesamtPreis := Kunde.Einkaufskorb.gesamtwert;

        writeln(menge, ' x ', artikel, ' zum Preis von ', Einzelpreis:0:2, ' = ', PositionPreis:0:2, ' Euro');
        writeln();
        writeln('Gesamtsumme: ', GesamtPreis:0:2, ' Euro');
    end;
end;
//-------------------------------------------
begin //Hauptprogramm
    repeat
        clrscr();
        writeln();
        writeln();
        writeln('   1) Sortiment anzeigen');
        writeln('   2) Artikel in Warenkorb legen');
        writeln('   3) Warenkorb anzeigen');
        writeln();
        writeln('   0) Beenden');
        writeln();
        write('==> ');
        readln(eingabe);
        case eingabe of
            1 : begin
                    ArtikellisteAnzeigen();
                    readkey();
                end;
            2 : ArtikelInWarenkorbLegen();
            3 : begin
                    WarenkorbAnzeigen();
                    readkey();
                end;
        end;
        writeln();
        writeln();
    until eingabe = 0;
end.