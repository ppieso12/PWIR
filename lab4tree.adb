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
begin
  Insert(Tree,10);
  Insert(Tree,5);
   Insert(Tree,15);
   Put_Line(Tree.Left.Data'Image);
   --Print(Tree);

end Lab4tree;
