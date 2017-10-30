with Ada.Text_IO, Ada.Integer_Text_IO,Ada.Numerics.Float_Random;
use Ada.Text_IO, Ada.Integer_Text_IO,Ada.Numerics.Float_Random;

procedure Lab4tree is
   type Node is
      record
         Data : Integer := 0;
         Left : access Node := Null;
         Right : access Node := Null;
      end record;

   type Node_Ptr is access all Node;

   procedure Insert(Nod : in out Node_Ptr; D : in Integer) is --Wstawianie na pocz
      E : Node_Ptr := new Node;
   begin
      E.Data := D;
      if Nod = null then
         Nod:= E;
         return;
      end if;
      if D<Nod.Data then
         Insert(Nod.Left,D);
      else
         Insert(Nod.Right,D);
      end if;

   end Insert;
   
   type info_search is
         record
            Data:Integer;
            Lvl:Integer;
            Is_found:Boolean;
         end record;
   
   function search(Nod : in out Node_Ptr; D : in Integer; Lvl : in Integer) return info_search is
	   Next_lvl: Integer;
   begin
       if Nod = null then
          return (D, Lvl, False);
       end if;
	   if Nod.Data = D then
		  return (D, Lvl, True);
	   end if;
	   Next_lvl := Lvl + 1;
       if D<Nod.Data then
          return search(Nod.Left,D, Next_lvl );
       else
          return search(Nod.Right,D, Next_lvl);
       end if;
   end search;
	
   procedure delete(Nod : in out Node_Ptr; D : in Integer) is
	   --DOPISAC DELETE
   begin
       if Nod = null then
          return;
       end if;
	   if Nod.Data = D then
		  return (D, Lvl, True);
	   end if;
       if D<Nod.Data then
          Insert(Nod.Left,D);
       else
          Insert(Nod.Right,D);
       end if;
	   
   end delete; 
   
   procedure Print(Nod : access Node) is --Wstawianie na pocz
      N : access Node := Nod;
   begin

      if N = null then
         return;
      end if;
      if N.Left = null and N.Right = null then
         Put(N.Data, 4); --New_Line;  Put("null "); Put("null ");
      else if N.Left /= null and N.Right = null then
            Put(" ");  Put(N.Data, 4); New_Line; Print(N.Left); Put("null ");
         else if N.Left = null and N.Right /= null then
               Put(" ");  Put(N.Data, 4); New_Line;  Put("null "); Print(N.Right);
            else if N.Left/= null and N.Right /= null then
                  Put(" ");  Put(N.Data, 4); New_Line; Print(N.Left); Put(" "); Print(N.Right);
               end if;
            end if;
         end if;
      end if;

   end Print;
    Tree : Node_Ptr := Null;
	pos: info_search;
begin
  Insert(Tree,10);
  Insert(Tree,5);
  Insert(Tree,15);
  Insert(Tree,3);
  Insert(Tree,14);
  
  --Put_Line(Tree.Left.Data'Img);
  Print(Tree);
  pos := search(Tree, 15, 1);
  New_line;
  Put_Line(pos.Data'Img & " on Lvl "& pos.Lvl'Img & " is found " & pos.Is_found'Img);

end Lab4tree;
