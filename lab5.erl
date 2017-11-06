-compile([export_all]).
-module(lab5).

-export([main/0 ]).

-record(node, {val, left = nil, right = nil}).


insert(Value, nil) -> #node{val = Value};
insert(Value, Node) when Value == Node#node.val -> #node{val = Value};
insert(Value, Node) when Value < Node#node.val -> insert(Value, Node#node.left);
insert(Value, Node) when Value > Node#node.val -> insert(Value, Node#node.right).



generateTree(Nodes, Tree) when Nodes > 0 ->
  RandVal = rand:uniform(20),
  NewTree = insert(RandVal, Tree),
  io:fwrite("pyk\n"),
  generateTree(Nodes-1,NewTree);

generateTree(0, Tree) -> Tree.

show(nil,V,nil) ->
  io:fwrite("~p\n nil nil",[V]);

show(LNode,V, nil) ->
  io:fwrite(" "),
  show(nil,V,nil),
  io:fwrite("\n"),
  show(LNode,V,nil),
  io:fwrite(" nil");

show(nil,V,RNode) ->
  io:fwrite(" "),
  show(nil,V,nil),
  io:fwrite("\nnil"),
  show(nil,V,Rnode);

show(LNode,V,RNode) ->
  io:fwrite(" "),
  show(nil,V,nil),
  io:fwrite("\n"),
  show(LNode,),
  io:fwrite(" "),
  show(Rnode).

main() ->
  T = generateTree(3,nil),
  show(T#node.left,T#node.val,T#node.right).
