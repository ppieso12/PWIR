-- lab4.adb
-- Materiały dydaktyczne
-- J.P. 2017
--`podprogramy - funkcje lub procedury

-- DOT (graph description langugae) - gravis, tworzenie grafow

with Ada.Text_IO, Ada.Integer_Text_IO,Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Integer_Text_IO,Ada.Numerics.Float_Random;

procedure Lab4List is
	
   type Element is
      record 
         Data : Integer := 0;
         Next : access Element := Null;
      end record;    
  
   type info_search is
      record
         amount:Integer;
         pos:Integer;
         is_alive:Boolean;
      end record;
   
   type Elem_Ptr is access all Element;

procedure Print(List : access Element) is
  L : access Element := List;
   begin
      
  if List = Null then
    Put_Line("List EMPTY!");
  else
    Put_Line("List:");  
  end if;  
  while L /= Null loop
    Put(L.Data, 4); -- z pakietu Ada.Integer_Text_IO
    New_Line;
    L := L.Next;
  end loop; 
end Print;  

procedure Insert(List : in out Elem_Ptr; D : in Integer) is --Wstawianie na pocz
  E : Elem_Ptr := new Element; 
begin
  E.Data := D;
  E.Next := List;
  -- lub E.all := (D, List); do calosci rekordu
  List := E;
end Insert; 

-- wstawianie jako funkcja - wersja krótka Wstawianie na pocz
function Insert(List : access Element; D : in Integer) return access Element is 
  ( new Element'(D,List) );  
  
procedure Insert_Sort(List : in out Elem_Ptr; D : in Integer) is 
	tmp: Elem_Ptr := new Element; 
	head: Elem_Ptr := new Element; -- wsk na poczatek listy
	 
begin
	head:= List;

	if List = null or else D <= List.Data then --pocz lub 1 elem
         tmp.Data := D;
         tmp.Next := List;
         List := tmp;
         return;
	end if;

	while D > List.Next.Data loop 
         List:= List.Next;
         if List.Next = null then exit;
         end if;
	end loop;
	
      tmp.Data:= D;
      tmp.Next:= List.Next;
      List.Next:= tmp;
      List := head;
  -- napisz procedurę wstawiającą element zachowując posortowanie (rosnące) listy
end Insert_Sort;  
   
procedure gen(List : in out Elem_Ptr; N_liczb :in Integer; M_zakres : in Integer) is
   Gen : Generator; -- z pakietu Ada.Numerics.Float_Random
   Los: Integer;
begin
   Reset(Gen);
   for I in 1..N_liczb loop
	  Los:= Integer(Float(M_zakres) * (Random(Gen)));
	  Insert_Sort(List, Los);
	  --Put_Line("ddddd" & Los'Img & "dddd" & N_liczb'Img);
   end loop;
   end gen;  
   
   function search(List : in out Elem_Ptr; Amount :in Integer) return info_search is
      tmp: Elem_Ptr := new Element; 
      pos: Integer:= 1;
      outt: info_search;
   begin
      tmp:=List;
      outt:=(Amount,-1,False);
      if tmp = null then
         return outt;
      end if;
      while tmp.Next /= null loop
         if tmp.Data = Amount then
            outt:=(Amount,pos,True);
            return outt;
         end if;
         pos:= pos +1;
         tmp:= tmp.Next;
      end loop;
      return outt;
   end search;
      
   Lista : Elem_Ptr := Null;
   pos: info_search;
   
   procedure delete(List : in out Elem_Ptr; Amount :in Integer) is

      tmp: Elem_Ptr := new Element; 
   begin
      tmp:= List;

      if tmp = null then --pocz lub 1 elem
         return;
      end if;
      if Amount = tmp.Data then 
         List:= tmp.Next;
         return;
      end if;
      
      while Amount /= tmp.Next.Data loop 
         tmp:= tmp.Next;
         if tmp.Next = null then exit;
         end if;
      end loop;
      tmp.Next:= tmp.Next.Next;
    ---  List.Next:= tmp;
     -- List := head;
      -- napisz procedurę wstawiającą element zachowując posortowanie (rosnące) listy
   end delete;  
   
begin
  --Print(Lista);
 -- Lista := Insert(Lista, 21);
 -- Print(Lista);
 -- Insert(Lista, 20);  
 -- Print(Lista);
  for I in reverse 1..12 loop
    Insert(Lista, (I*2));
  end loop;
  Insert_Sort(Lista, 0);
  gen(Lista, 5, 10);
  pos:= search(Lista,100);
 
  delete(Lista,24);
  Print(Lista);
 -- Put_Line(pos.amount'Image & "on "& pos.pos'Image &"="& pos.is_alive'Image);
   
end Lab4List;
