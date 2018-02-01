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

pitagorejskie(N) -> 
	L = lists:seq(1,N),
	[{X, Y, Z} || X <-L, Y <-L, Z <- L,X<Y,Y<Z, X*X + Y*Y == Z*Z].

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
% 	erlang:is_integer(5).

	
%	lists:reverse(lists:seq(1, N)).

%	lists:seq(1, 7) -- lists:seq(7, 9).  ODEJMOWANIE LIST --
%my_func() -> [rand:uniform() || _ <- lists:seq(1,10)].

%(learning@Lenovo-PC)2> [1 || _ <- lists:seq(1, 5)].
%[1,1,1,1,1]

% FORK BOMB MÓJ
start() ->
	[spawn(?MODULE,parent,[]) || _ <- lists:seq(1,3)].

parent() ->
	ListChild = [spawn(?MODULE,child,[]) || _ <- lists:seq(1, 3)],
	loop(ListChild).      
	%[PID!{self(),message} || PID <- ListChild]

loop(L) -> lists:foreach(fun(Pid) -> Pid!{self(), message} end, L).

child() ->
	receive
		{Pid, message} -> io:fwrite("wiad od ~p\n", [Pid])				  
	end.

%MAP wielowątkowo, moja wersja  (fun(X) -> X*X end)

mojMap(List,Fun) ->
	try
	[spawn(?MODULE,thread,[X,Fun,self()])|| X <- List],
	zbierz(List)
	catch
		error:jest_problem -> io:fwrite("Nieodpowiednia funkcja!");
		error:zadlugo -> io:fwrite("F za dlugo dziala")
	end.


zbierz([]) -> io:fwrite("wynik\n"), [];
zbierz([_|T]) ->
	receive
		{wiad, W} -> [W] ++ zbierz(T);
		{error} -> erlang:error(jest_problem)
	after
		3000 -> erlang:error(zadlugo)
	end.


thread(X,Fun,ParrentPID) -> 
	try	
		Wartosc = Fun(X),
		%io:fwrite("~p\n",[Wartosc]),
		ParrentPID ! {wiad,Wartosc}
	catch
  		_:_ -> ParrentPID ! {error}
	end.
 
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
		{wiad, W} -> [W];
		{error} -> [error]
	after
		3000 -> erlang:error(zadlugo)
	end.

% inna
%erlang:register(RegName, spawn()).
%erlang:whereis(RegName).
%exit(RegName, kill).

fibo_reku(0) -> 0;
fibo_reku(1) -> 1;
fibo_reku(N) -> fibo_reku(N-1) + fibo_reku(N-2).


looop(P,D,I,I) -> P+D;
looop(P,D,I,N) -> 
	W = P+D,
	looop(D,W,I+1,N).

fibo_iter(N) when N == -100 -> erlang:error(inny);
fibo_iter(N) when N < 0 -> erlang:error(mniejsza);
fibo_iter(N) ->
	if 
		N == 0  -> 0;
	    N == 1  -> 1;
		N > 1 -> 
		Pierwsza = 0,
		Druga = 1,
		Wynik = looop(Pierwsza,Druga,2,N),
		Wynik
	end.

blad(N) -> 
	try 
		fibo_iter(N) 

	catch
		error:mniejsza -> "jest mniejsza";
		_:_ -> "mamy minus setke"
	end.
	
%Napisz w Erlangu funkcje o nazwie map_update która przyjmuje Mapę, 
%Klucz i Wartość i zwraca mapę z uaktualnioną wartością pod wskazanym kluczem. 
%Jeśli klucz nie istnieje funkcja zgłasza wyjątek.
map_update_catch(M,K,W) -> 
  try
    M#{K:=W}
  catch
    _:_ -> "Nie ma takiego klucza"
  end.

%Napisz funkcję dzielącą liczby całkowite. Jeśli dzielnik będzie równy 0 to ma 
%być zgłaszany wyjątek Zero z wiadomością "Nie dziel przez zero" 
dziel(A,B)->
	try
		dziell(A,B)
	catch
		error:'Zero' -> 'nie dziel przez zero'
	end.
dziell(_, 0) -> erlang:error('Zero');
dziell(Liczba, Dzielnik) -> Liczba/Dzielnik.


%Napisz kod w języku Erlang, który uruchomi 3 procesy A,B i C. Proces A będzie wysyłał do B wiadomości co 1sek, B po otrzymaniu wiadomości od A będzie ją przesyłał natychmiast do C,
% C będzie ją natychmiast przesyłał do A. Jeśli A nie otrzyma odpowiedzi od C w max 500ms to wyświetli komunikat i zakończy działanie wszystkich procesów.

procesy() ->
	erlang:register(a, spawn(?MODULE,aa,[])),
	erlang:register(b, spawn(?MODULE,bb,[])),
	erlang:register(c, spawn(?MODULE,cc,[])).

aa() ->
	b ! {msg,a},
	receive
		{msg,c} -> io:fwrite("a odebral od c\n"),timer:sleep(3000),  aa()	
	after
		500 -> 
		io:fwrite("A nie otrzymal od C msg"),
		exit(b,kill),
		exit(c,kill),
		exit(a,kill)
	end.
	
bb() ->
	receive
		{msg,a} -> io:fwrite("b odebral od a\n"), c ! {msg,b}, bb()
	end.
cc() ->
	receive 
		{msg,b} -> io:fwrite("c odebral od b\n"),timer:sleep(1000), a ! {msg,c}, cc()
	end.

%Napisz w Erlangu program, który stworzy 100 procesów. Po stworzeniu wszystkich procesów program ma 
%wysłać do pierwszego wiadomość, pierwszy ma do drugiego itd. Ostatni ma wysłać wiadomość 
%do funkcji startującej. Po otrzymaniu wiadomości i wykonaniu akcji procesy mają się zakończyć.
procesy2(N) ->
	Lista = [spawn(?MODULE, pr, [Nr])|| Nr <- lists:seq(1, N)],
	Lista2 = Lista ++ [self()],
	[H|T] = Lista2,
	H ! {msgg,T},
	receive
		{msg_start} -> io:fwrite("koniec glownego\n")
	end.
	
pr(Nr) ->
	receive
		{msgg, [H]} ->io:fwrite("proces nr ~p",[Nr]), timer:sleep(500), H ! {msg_start};
		{msgg, [H|T]} ->io:fwrite("proces nr ~p",[Nr]), timer:sleep(500), H ! {msgg,T}	
	end.

% GWIAZDA N procesow M komunikatow
%Napisz program w jezyku erlang, który uruchomi N procesów w konfiguracji gwiazdy i 
%prześle do każdego z nich M komunikatów będących liczbami naturalnymi w zakresie 1-M.
% Procesy mają odsyłać podwojoną wartośc otrzymanego argumentu
gwiazda(N,M) ->
	Procesy = [spawn(?MODULE, podrzedny, [self(),0,M]) || _ <- lists:seq(1, N)],
	[Pid!{msggg, Komunikat} || Pid <- Procesy, Komunikat <- lists:seq(1, M)],
	odbior(0,N*M).

odbior(Nr, Nr) -> io:fwrite("parent odebral wszystko\n");
odbior(Nr, Calosc) ->
	receive
		{msggg, Komunikat, Child} -> io:fwrite("wiadomosc od dziecka ~p o tresci ~p\n",[Child,Komunikat]),
									 odbior(Nr+1, Calosc)
	end.

podrzedny(_,Liczba, Liczba)-> io:fwrite("koniec dziecka~p\n",[self()]);
podrzedny(Parent,Liczba, Wiadomosci) ->
receive
	{msggg, Komunikat} -> Parent ! {msggg, Komunikat *2, self()}, podrzedny(Parent, Liczba+1, Wiadomosci)
end.


feach()-> 
	M = lists:seq(1, 10),
	L = lists:map(fun(X) -> X*2 end, M),
	L.

lamport(N) ->
receive
{msg,T} when  T> N ->  lamport(T+1);
{msg,T} when  T =< N -> lamport(N+1)
end.
