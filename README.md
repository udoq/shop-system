# Grundlagen der Programmierung
## Einfaches Shopsystem in Pascal
Grundlagenprojekt zur Umsetzung der Datentypen RECORD und TYPE.
### Datenstrukturen
Ein Array vom Type **Sortiment** enthält jeweils den *Artikel* und den *Preis*.
Ein Array vom Type **Warenkorb** enthält verschiedene **Positionen**.
Eine **Position** enthält jeweils den *Artikel*, die *Menge*, den *Einzelpreis* und den *Gesamtpreis*

Das Sortiment ist in der Datei *sortiment.dat* gespeichert.
Der Kunde mit seinem zugehörigen Warenkorb ist in der Datei *kundenname.dat* gespeichert.

Im Hauptmenü besteht aus:
- Sortiment anzeigen
- Artikel in den Waren legen
- Warenkorb anzeigen
- Anmelden
- Beenden

### Erzeugen des ausführbaren Programms
Das Programm wurde compiliert mit dem **free pascal compiler** (www.freepascal.org)