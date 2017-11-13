
with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random, Ada.Numerics.Discrete_Random;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Numerics.Float_Random;

procedure lab6 is

--Instrukcja terminate nie jest komenda konczaca, daje szanse zakonczenia zadania

type Kolory is (Czerwony, Zielony, Niebieski, Czarny, Fioletowy);
type Dni_tyg is (Poniedzialek, Wtorek, Sroda, Czwartek, Piatek, Sobota, Niedziela);
package Los_Kolor is new Ada.Numerics.Discrete_Random(Kolory);
 use Los_Kolor;
package Los_Dni is new Ada.Numerics.Discrete_Random(Dni_tyg);
 use Los_Dni;


task Klient is
  entry Start;
end Klient;

task Serwer is
  entry Start;
  entry Koniec;
  entry Los5(I: out Float);
  entry Loskolor(K: out Kolory);
  entry Losdni(D: out Dni_tyg);
  entry Los49(I: out Integer);
end Serwer;

task body Klient is
  Los: Float;
  Liczba: Integer;
  Kolor : Kolory;
  Dzien: Dni_tyg;
begin
  accept Start;
  --for K in 1..10 loop
	  Serwer.Los5(Los);
    Serwer.Loskolor(Kolor);
    Serwer.Losdni(Dzien);
    Serwer.Los49(Liczba);
    Put_Line("Losowanie=" & Los'Img);
    Put_Line("Losowanie=" & Kolor'Img);
    Put_Line("Losowanie=" & Dzien'Img);
    Put_Line("Losowanie=" & Liczba'Img);
  --end loop;
  Serwer.Koniec;
end Klient;

task body Serwer is
  GenK : Los_Kolor.Generator;
  GenD : Los_Dni.Generator;
  GenF : Float_Random.Generator;
  Gen : Generator;
begin
  accept Start;
  loop
    select
     accept Los5(I: out Float) do
	     I :=  5.0 * (Random(GenF));
     end Los5;
     accept Loskolor(K: out Kolory) do
	     K :=  Los_Kolor.Random(GenK);
     end Loskolor;
     accept Losdni(D: out Dni_tyg) do
	     D :=  Los_Dni.Random(GenD);
     end Losdni;
     accept Los49(I: out Integer) do
	     I := 1 + Integer(48.0 * (Random(Gen)));
     end Los49;
	   --Put_Line("Lok=" & Lok'Img);
	  or --albo or delay albo else
	   accept Koniec;
 	   exit;
    end select;
  end loop;

  Put_Line("Koniec Serwer ");
end Serwer;

begin
  Klient.Start;
  Serwer.Start;
  Put_Line("Koniec_PG ");
end lab6;
