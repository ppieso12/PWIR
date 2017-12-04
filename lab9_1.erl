-module(lab9_1).
-compile([export_all]).


map(_, []) -> [];
map(F, [H|T]) -> [spawn(lab9_1,F,[H])|map(F,T)].

incr(X) -> X + 1.
decr(X) -> X - 1.


print([]) ->   io:format("~n ended",[]);
print([H|T]) -> io:format("~p ",[H]),
  print(T).

fmain()->

L = [1,2,3,4,5],

L2 = map(incr,L),

print(L2).
