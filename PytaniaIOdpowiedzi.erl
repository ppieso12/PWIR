-module(pytania).
-compile(export_all).
%cd("C:/Users/sebac/Documents/Erlang/Programs/Erlang/Nacia").

%co zwroci ?? lists : any(fun(X)-> X > 3 end, [1, 2, 3, 4]). odp true

% lists : all(fun(X)-> X > 3 end, [1, 2, 3, 4]). odp false

% lists : append([[1,2],[3,4],[a,b,c]]). odp [1,2,3,4,a,b,c]

% lists : seq(1, 10). odp [1,2,3,4,5,6,7,8,9,10]

%lists:foldl(fun(X,Prod)-> X * -Prod end, 1, [1, 2, 3]). odp -6

%Napisz funkcje o nazwie my_fun kt�ra zwraca liczb� losow� typu float z przedzia�u 2 do 4.

my_fun() -> (rand:uniform() + 1)  * 2.

my_fun2() -> (rand:uniform() * 2) + 2.

%Napisz funkcje o nazwie my_func lub kod do konsoli kt�ry zwraca liste 10
%losowych liczb losowa typu float z przedzia�u 0 do 1.

my_func() -> [rand:uniform() || _ <- lists:seq(1,10)].

my_funcc() -> createList([],10).

createList(L,0) -> L;
createList(L, N) -> 
    NewElement = rand:uniform(),
    NewList = L ++ [NewElement],
    N2 = N - 1,
    createList(NewList,N2).


%Napisz funkcje mySort przyjmujaca jako argument liste i sortujaca j�.

mySort(List) -> lists:sort(List).

mySort2([]) -> [];
mySort2([H]) -> [H];
mySort2([H|T]) ->
    Smaller = [X || X <- T, X < H],
    Greater = [Y || Y <- T, Y >= H],
    mySort2(Smaller) ++ [H] ++ mySort2(Greater).

%Napisz funkcje o naziwe map_add kt�ra przyjmuje Mape, Klucz i Wartosc i
%zwraca mape z dodana wartoscia i kluczem

map_add(Map,Key,Value) -> maps:put(Key,Value,Map).

map_add2(Map,Key,Value)-> Map#{Key => Value}.

%Napisz funkcje o naziwe map_add kt�ra przyjmuje Mape, Klucz i Wartosc i
%zwraca mape z uaktualniona (updated) wartoscia i kluczem

map_update(Map,Key,Value) -> map_add(Map,Key,Value).
map_update2(Map,Key,Value) -> Map#{Key => Value}.
map_update3(Map,Key, Value)-> Map#{ Key := Value}.

%Napisz funkcje o nazwie solution kt�ra bedzie oczekiwa�a na wiadomosc message i zwr�ci ok gdy ja dostanie

solution() ->
    receive 
        message -> ok
    end.

%Napisz funkcje o nazwie solution kt�ra Otrymuje jako argument liste int�w i
%zwraca tylko parzyste z nich

solution2([]) -> [];
solution2([H|T]) ->
    case  H rem 2 == 0 of
        true -> [H] ++ solution2(T);
        false -> solution2(T)
    end.

solution3(List) -> [X ||X<- List, X rem 2 =:= 0].

% posumuj liczby od 1 do 100

sum() -> lists:foldr(fun(X,Prod) -> X + Prod end, 0, lists:seq(1,100)).
sum2() -> lists:sum(lists:seq(1,100)).

pomSum(0) -> 0;
pomSum(N)-> N + pomSum(N-1).

sum3()->pomSum(100).    

%Napisz funkcje o nazwie my_map kt�ra implementuje map wielowatkowo ( dla kazdego elementu listy osobny w�tek) dodatkowe punkty za obs�ug� b��du.
my_map([], _) -> [];
my_map([H|T], F) -> [F(H)] ++ my_map(T,F).

thread(X,Fun,ParrentPID) -> ParrentPID ! {self(),Fun(X)}.

mapPIDS([],_) -> [];
mapPIDS([H|T],Fun) -> [spawn(pytania, thread, [H, Fun, self()])] ++ mapPIDS(T,Fun).

mainMap(List, Fun) -> 
    PIDs = mapPIDS(List,Fun),
    gather_all(PIDs, []).

gather1(PID) -> 
    receive 
        {PID, Result} -> Result
    after 
        3000 -> error
    end.

gather_all([],Results) -> Results;
gather_all(PIDs,Results) -> 
    [H|T] = PIDs,
    NewResult = gather1(H),
    gather_all(T,Results ++ [NewResult]).

%Napisz kod kt�ry zwr�ci najmniejszy element listy.

smallest(List) -> lists:min(List).
%definicja odpowienika kropki w haskellu
% DOT = fun(A,B) -> fun(X) -> A(B(X)) end end.
    
%Stw�rz mape a => 1, b => 2, c => 3
map() -> #{a=>1,b=>2,c=>3}.

%lists:foldl(fun(X,Prod) -> {A,B} = X, Prod ++ [A,B] end, [],L5).

myFold([]) -> [];
myFold([{A,B}|T]) ->
    [A, B] ++ myFold(T). 

%<text>napisz funkcje my_receive kt�ra nie przyjmuje argumantu ale odbiera wioadomosc i jesli jest to atom pom to zwraca pom, jesli otrzyma cololwiek innego zwraca ok , jesli nie otrzyma nic przez 200 milisekund od uruchomienia zwraca atom timeout

my_receive() -> 
    receive 
        pom -> pom;
        _ -> ok
    after   
        200 -> timeout
    end.

% a < fun(X) -> X end. co sie wypisze ? true

% <text>napisz funkcje f kt�ra przyjmuje 1 argumant i zwraca a jesli argument jest mniejszy lub r�wny od 10, b jelsi argument jest w przedziale od 10 do 20,w kazdym inny przypadku zwrac c

myRet(A) when A =< 10 -> a;
myRet(A) when A < 20 -> b;
myRet(_) -> c.

%<text>napisz kod zwracaj�cy 2 elementowa krotk� sk��dajac� sie z atomu a i liczy 5.

myKrotka() -> {a,5}.

%podaj przyk�ad zachowania (behaviour) OTP 
%Odpowied� przyk�adowa 1:
			%gen_server
	%Odpowied� przyk�adowa 2:
			%gen_event
	%Odpowied� przyk�adowa 3:
	%	supervisor

%% max listy
myMax(L) -> lists:max(L).

maxx(A,B) when A>=B -> A;
maxx(_,B) -> B.


% foldl(funckja dwuarg X(z listy) i Prod(pocztakowy), Prod, Lista)
myMax2([H|T]) -> lists:foldl(fun maxx/2, H, T).

%<text>Napisz program zwracaj�cy krotk� 2-elementow� z najmniejszym i najwi�kszym elementem listy (tmin\_max/1).
minMax([]) -> erlang:error("List is empty");
minMax([H|T]) -> {lists:foldl(fun(X, Prod) -> 
    case X < Prod of
         true -> X;
         false -> Prod
    end end , H, T), lists:foldl(fun maxx/2, H, T)}.

    %<text>Napisz program, kt�ry dla danego N zwr�ci list� formatu [N,N-1,�,2,1]

myList(N) when N < 0 -> erlang:error("N is negative");
myList(0) -> [];
myList(N) -> [N] ++ myList(N-1).

%lists:reverse(lists:seq(1,N)).

%<text>Napisz program generuj�cy list� jedynek o zadanej d�ugo�ci.

generate(N) -> [1 || _ <- lists:seq(1,N)].

%<text>Napisz program generuj�cy list� o podanej d�ugo�ci sk�adaj�c� si� z podanego elementu.

generate2(Elem,N) -> [Elem || _ <- lists:seq(1,N)].

%<text>Zdefiniuj sta�� dla ca�ego modu�u TIMOUT na wartosc 200
-define(TIMEOUT, 200).

time() -> ?TIMEOUT.