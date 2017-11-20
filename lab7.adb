-- prot3.adb
-- komunikacja asynchroniczna przez bufor
-- kolejka FIFO

with Ada.Text_IO, lab7_2;
use Ada.Text_IO, lab7_2;

procedure lab7 is

-- obiekt chroniony

type TBuf is array(Integer range <>) of Character;
V: array(1..10) of Character := ('a','b','c','d', others => 'h');
protected type Buf(Size: Integer) is
  entry Wstaw(C : Character);
  entry Pobierz(C : out Character);
  private
   B : TBuf(1..Size);
   LiczElem  : Integer:=0;
   PozPob   : Integer:=1;
   PozWstaw : Integer:=1;
end Buf;

protected body Buf is
  entry Wstaw(C : in Character) when LiczElem < Size is
  begin
    LiczElem:= LiczElem + 1;
    B(PozWstaw):= C;
    PozWstaw:= PozWstaw + 1;
    if PozWstaw > Size then
      PozWstaw:=1;
    end if;
  end Wstaw;
  entry Pobierz(C : out Character) when LiczElem > 0 is
  begin
    LiczElem:= LiczElem - 1;
    C := B(PozPob);
    PozPob:= PozPob + 1;
    if PozPob > Size then
      PozPob:=1;
    end if;
  end Pobierz;
end Buf;

Buf1: Buf(20, Character);
task Producent;


task body Producent is
  --Cl : Character := 's';
begin
  for I in V'First..V'Last loop
  Put_Line("$ wstawiam: znak = '" & V(I)'Img & "'");
  Buf1.Wstaw(V(I));
  Put_Line("$ wstawiłem...");
  end loop;
end Producent;

task Konsument;

task body Konsument is
  Cl : Character := ' ';
begin
  for I in V'First..V'Last loop
  Put_Line("# pobiorę...");
  Buf1.Pobierz(Cl);
  Put_Line("# pobrałem: znak = '" & Cl & "'");
  end loop;
end Konsument;

begin
  Put_Line("@ jestem w procedurze glownej");
end lab7;
