-- pak3.adb

with Ada.Text_IO,Ada.Float_Text_IO,Ada.Numerics.Float_Random, Ada.Calendar;
use Ada.Text_IO,Ada.Float_Text_IO, Ada.Numerics.Float_Random, Ada.Calendar;

package body pak3 is

   --type Wektor is array (Integer range <>) of Float;  -- indeksowanie i typ

   procedure pisz(Elem: Wektor) is
   begin
      for I in Elem'First..Elem'Last loop
         Put("Tab(" & I'Img & ")=");
         Put(Elem(I),3,2,0); -- z pakietu Ada.Float_Text_IO   Znaki przed, po
         New_Line;
      end loop;
   end pisz;

   procedure losowanie(Elem:in out Wektor) is
      Gen : Generator; -- z pakietu Ada.Numerics.Float_Random
   begin
      Reset(Gen);
      for  I in Elem'Range loop
         Elem(I) := 100.0 * Float(Random(Gen));  -- losowanie elementow z zapisem do tablicy
         Put_Line("Tab(" & I'Img & ")=" & Elem(I)'Img);
      end loop;
   end losowanie;

   procedure sort_wst(E: in out Wektor) is
      bigger: Float;
      J: Integer;
   begin
      for I in 2..E'Last loop
         bigger:= E(I);
         J:= I -1;
         while E(J) > bigger loop
            E(J+1) := E(J);
            J:= J-1;
            if J = 0 then exit;
            end if;
         end loop;
        E(J+1) := bigger;
      end loop;
   end sort_wst;


   function sprawdz(Elem: Wektor) return boolean is (for all I in Elem'First..(Elem'Last-1) => Elem(I)<Elem(I+1) );

   procedure save_tofile(E: in out Wektor) is
      Pl : File_Type;
      Nazwa: String := "plik.txt";
     -- Element: String;
   begin
      Create(Pl, Out_File, Nazwa); -- Open
      Put_Line("Tworze plik: " & Nazwa);
      Put_Line(Pl, "Poczatek pliku");
      for I in E'Range loop

         Put_Line(Pl,"Element(" & I'Img &")-"&E(I)'Image);
      end loop;
      Put_Line(Pl, "Koniec pliku testowego");
      Close(Pl);

   end save_tofile;

    procedure read_fromfile(E: String) is
      Log : FILE_TYPE;
      One_Char: CHARACTER;
   begin
      Put_Line("Czytanie...");
      Open(Log,In_File,E);
      loop
     	exit when End_Of_File(Log);
      Get(Log, One_Char);
      Put(One_Char);
      --		exception
      --			when ADA.IO_EXCEPTIONS.END_ERROR => null;
      --		end;
      end loop;
      Close(Log);

   end read_fromfile;

end pak3;
