 %% @author Mateusz
%% @doc @todo Add description to learn1.
-module(tut).
-compile([export_all]).
%http://www.newthinktank.com/2017/04/learn-erlang-one-video/
%http://erlang.org/doc/getting_started/conc_prog.html
-import(math,[pi/0]).

-export([add/2, head/1, sum/1, maps/0, main/0, lmalejaca/1,lros/1, parzyste/1, parzyste2/1, parzyste3/1, list_index/2] ).


add(A1,A2) -> 
	A1+A2.
hello_world() -> io:fwrite("hello, world\n").
head([H|_]) -> 
	{glowa,H}.

sum([]) -> 0;
sum([H|T]) -> H + sum(T).

preschool() ->
	'Go to preschool'.
kindergarten() ->
	'Go to kindergarten'.
grade_school() ->
	'Go to grade school'.
 
what_grade(X) ->				%WARUNKI IF
	if X < 5 -> preschool();
	X == 5 -> kindergarten();
	X > 5 -> grade_school()
	end.

say_hello(X) ->
	case X of
		french -> 'Bonjour';
		german -> 'Guten Tag';
		english -> 'Hello'
	end.

take_elem(List, N) ->
	Next = N - 1,
	[Head|Tail] = List,
	if Next == 0 -> Head;
	   Next > 0 -> take_elem(Tail, Next)
	end.
take_elem2([H|_], N) when N == 1 -> H;	%REKURSJA
take_elem2([_|T], N) when N > 1 -> take_elem2(T,N-1).

error_stuff(N) ->
	try
		Ans = 2 / N,
		Ans
	catch
		error:badarith ->
			"Can't divide by zero"
	end.

-define(subs(X,Y),{X-Y}).	%MACRO

ping(0) ->
    pong ! finished,
    io:format("ping~p finished~n", [self()]);

ping(N) ->
    pong ! {ping, self()},
    receive
        pong ->
            io:format("Ping~p received pong~n", [self()])
    end,
    ping(N - 1).

pong() ->
    receive
        finished ->
            io:format("Pong~p finished~n", [self()]);
        {ping, Ping_PID} ->
            io:format("Pong~p received ping~p~n", [self(),Ping_PID]),
            Ping_PID ! pong,
            pong()
    end.

concurrent() ->
	%register(pong, spawn(tut, pong, [])),
	register(pong, spawn(fun() -> pong() end)),
 	%spawn(tut, ping, [3]),
	spawn(fun() -> ping(3) end),
	ok.


map_append(K,V,M) ->
	M#{K => V}.
map_update(K,V,M) ->
	M#{K := V}.
map_disp(M) ->
	list_disp(maps:to_list(M)).
list_disp([]) -> 
	io:fwrite("Ended\n");
list_disp([{K,V}|T]) -> 
	io:fwrite("~p points to ~p\n",[K,V]),
	list_disp(T).

maps() ->
	A = map_append(first,1,#{}),
	B = map_append(second,2,A),
	C = map_append(third,3,B),
	map_disp(C),
	M = map_update(third,5,C),
	map_disp(M),
	% Get value assigned to a key
	io:fwrite("1st  : ~p\n",[maps:get(third, M)]),
	
	% Get all keys
	io:fwrite("~p\n", [maps:keys(M)]),
	
	% Get all values
	io:fwrite("~p\n", [maps:values(M)]),
	
	% Return everything except the key designated
	io:fwrite("~p\n", [maps:remove(first, M)]),
	
	% Check if a key exists
	io:fwrite("Check if a key exists ~p\n",[maps:find(second, M)]),
	
	% Add a key value to the map
	H = maps:put(fourth, 4, M),
	map_disp(H).


main() ->
	rand:uniform(20),
	what_grade(5),
	Tuple = {test, 55},
	List = tuple_to_list(Tuple),
	List,
	io:fwrite("Out - ~p\n",[take_elem([1,2,3,4,5],4)]),
	io:fwrite("Out - ~p\n",[take_elem2([1,2,3,4,5],3)]),
	error_stuff(0),
	io:fwrite("Out - ~p\n",[hd(tuple_to_list(?subs(2,3)))]),
	concurrent().


lmalejaca(0) -> [];
lmalejaca(N) when N > 0 -> [N] ++ lmalejaca(N-1).
lros(0) -> [];
lros(N) -> lros(N-1) ++ [N].

parzyste(1) -> [];
parzyste(N) when N rem 2 == 0 -> parzyste(N-1) ++ [N];
parzyste(N) when N rem 2 /= 0 -> parzyste(N-1).

parzyste2(1) -> [];
parzyste2(N) ->
	if
		N rem 2 == 0 -> parzyste(N-1) ++ [N];
		N rem 2 /= 0 -> parzyste(N-1)
	end.

parzyste3(1) -> [];
parzyste3(N) ->
	case N rem 2 == 0 of
		true -> parzyste(N-1) ++ [N];
		false  -> parzyste(N-1)
	end.
reverse([]) -> [];
reverse([H|T]) -> reverse(T) ++ [H].

list_index([],_) -> [];
list_index([H|T],N) ->
	case N == 1 of
		true -> [H*2] ++ list_index(T, N - 1);
		false -> [H] ++ list_index(T, N - 1)
	end.


sum(N, M) when N > M -> exit(self(), kill);
sum(M, M) -> M;
sum(N, M) -> N + sum(N+1, M).

%Napisz funkcję, któradla danego N zwróci listę postaci [1,2,...,N-1,N].
f1(1) -> [1];
f1(N) -> f1(N-1) ++ [N].

%. Napisz funkcję, która wyświetli liczby naturalne pomiędzy 1 a N. Każda liczba ma zostać wyświetlona w nowym wierszu.

f2(1) -> io:fwrite("Liczba: 1\n");
f2(N) -> 
	f2(N-1),
	io:fwrite("Liczba: ~p\n",[N]).

f2p(2) -> io:fwrite("Liczba: 2\n");
f2p(N) when N < 2 -> io:fwrite("Brak");
f2p(N) when N rem 2 == 0 ->
	f2p(N-1),
	io:fwrite("Liczba: ~p\n",[N]);
f2p(N) when N rem 2 /= 0 ->
	f2p(N-1).

%Wypisz N kolejnychliczb trójkątnych
ft(1) -> [];
ft(N) -> ft(N-1) ++ [(N*(N+1))/2].

pitagorejskie(L) -> [[X, Y, Z] || X <-L, Y <-L, Z <- L, X*X + Y*Y == Z*Z].

% Napisz funkcję, która dla podanej listy L i indeksu Index zwróci nową listę, gdzieelement pod wskazanym
% indeksem podwoi swoją wartość.
f4([],_) -> [];
f4([H|T],Index) when H == Index -> [H*2] ++ f4(T,Index);
f4([H|T],Index) -> [H] ++ f4(T,Index).

solution(L)->
	A = [X||X<-L,X rem 2 == 1],
	lists:reverse(A).


%io:fwrite("Liczba: ~p\n",[N]).
%	lists:reverse(List1)
%	lists:seq(From, To)
%   is_integer(H)
%   timer:sleep(250),
%   lists:nth(N, List)
%   lists:delete(Elem, List1)
%   rand:uniform(5)
%	maps:put(Key, Value, Map1)
%	erlang:send(Dest, Msg)
%	lists:min(List)


%	lists:seq(1, 7) -- lists:seq(7, 9).  ODEJMOWANIE LIST --
%my_func() -> [rand:uniform() || _ <- lists:seq(1,10)].

%(learning@Lenovo-PC)2> [1 || _ <- lists:seq(1, 5)].
%[1,1,1,1,1]

% FORK BOMB
start() ->
	[spawn(?MODULE,parent,[]) || _ <- lists:seq(1,3)].

parent() ->
	ListChild = [spawn(?MODULE,child,[]) || _ <- lists:seq(1, 3)],
	loop(ListChild).

loop(L) -> lists:foreach(fun(Pid) -> Pid!{self(), message} end, L).

child() ->
	receive
		{Pid, message} -> io:fwrite("wiad od ~p\n", [Pid])				  
	end.

%map wielowątkowo, moja wersja

thread(X,Fun,ParrentPID) -> ParrentPID ! {wiad,Fun(X)}.
 
mapPIDS([],_) -> [];
mapPIDS([H|T],Fun) -> [spawn(?MODULE, thread, [H, Fun, self()])] ++ mapPIDS(T,Fun).
 
mainMap(List, Fun) -> 
    PIDs = mapPIDS(List,Fun),
    gather_all2(length(PIDs)).
 
gather_all2(0) -> [];
gather_all2(N) ->
	mygather() ++ gather_all2(N-1).

mygather() ->
	receive
		{wiad, W} -> [W]
	after
		3000 -> error
	end.

% inna
%erlang:register(RegName, spawn()).
%erlang:whereis(RegName).
%exit(RegName, kill).

fibo_reku(0) -> 0;
fibo_reku(1) -> 1;
fibo_reku(N) -> fibo_reku(N-1) + fibo_reku(N-2).


