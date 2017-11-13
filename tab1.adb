with Ada.Text_IO,Ada.Float_Text_IO;
use Ada.Text_IO,Ada.Float_Text_IO;
-- gnatmake tab1.adb
procedure Tab1 is
  T1 : array(1..10) of Float := (1|3|5|7 => 1.2, 8..10 =>2.4, others =>7.6);   -- agregat - wartosci wypisane w odpowiedniej formie
  																			--Moze byc na podstwaie kolejnosci lub 
																			-- for I in 1..10 loop
																				--      A'Range
																			-- for I in A'First + 1 .. A'Lost
  Sum : Float := 0.0;
begin
  for I in T1'First..T1'Last loop -- lub T1'Range
   Put("Tab(" & I'Img & ")="); -- z pakietu Ada.Text_IO
   Put( T1(I),3,4,0 ); -- z pakietu Ada.Float_Text_IO   Znaki przed, po, jaka jest exponenta
   New_Line;
  end loop; 
  for E of T1 loop
    Sum := Sum + E;	-- Brak +=
  end loop;
  Put_Line("Suma = " & Sum'Img); 
end Tab1;