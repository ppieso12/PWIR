with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random, Ada.Calendar, pak3;
use Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random, Ada.Calendar, pak3;
	
procedure lab3 is
   
   Zmienna: pak3.Wektor(1 .. 5) := (1..2 => 9.45, 3=> 5.0, others=>1.0);
   check: boolean;
   T1, T2: Time; -- czasy bezwzgledne
   D: Duration;  -- czas względny, 
   
begin
   T1 := Clock; -- odczytanie aktualnego czasu
   pisz(Zmienna);
   losowanie(Zmienna);
   check:= sprawdz(Zmienna);
   Put_Line("sprawdzenie=" & check'Img);
   sort_wst(Zmienna);
   Put_Line("po sortowaniu");
   pisz(Zmienna);
   check:= sprawdz(Zmienna);
   Put_Line("sprawdzenie=" & check'Img);
   
   T2 := Clock;
   D := T2 - T1;
   Put_Line("Czas obliczen = " & D'Img & "[s]"); -- atrybut 'Img
   save_tofile(Zmienna);
   read_fromfile("plik.txt");
   
end lab3;
