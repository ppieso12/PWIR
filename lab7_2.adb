Generic
    Rozmiar: Natural;
    type Typ_Elementu is (<>);
package Buf_Gen is

type TBuf is array(Integer range 1..Rozmiar) of Typ_Elementu;
protected type Buf(Rozmiar: Integer) is
  entry Wstaw(C : Typ_Elementu);
  entry Pobierz(C : out Typ_Elementu);
  private
   B : TBuf(1..Rozmiar);
   LiczElem  : Integer:=0;
   PozPob   : Integer:=1;
   PozWstaw : Integer:=1;
end Buf;
end Buf_Gen;

package body Buf_Gen  is
protected body Buf is
  entry Wstaw(C : in Typ_Elementu) when LiczElem < Rozmiar is
  begin
    LiczElem:= LiczElem + 1;
    B(PozWstaw):= C;
    PozWstaw:= PozWstaw + 1;
    if PozWstaw > Size then
      PozWstaw:=1;
    end if;
  end Wstaw;
  entry Pobierz(C : out Typ_Elementu) when LiczElem > 0 is
  begin
    LiczElem:= LiczElem - 1;
    C := B(PozPob);
    PozPob:= PozPob + 1;
    if PozPob > Size then
      PozPob:=1;
    end if;
  end Pobierz;
end Buf;
end Buf_Gen;
