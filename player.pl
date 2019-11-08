:- include('tokemon.pl').
:- dynamic(player/2).
:- dynamic(inventory/2).
:- dynamic(legendary/2).

maxInventory(6).

init_player:-
    tinggi(T),
    lebar(L),
    random(1,L,X),
    random(1,T,Y),
    asserta(player(X,Y)),
    health(oreomon,MaxHealth),
    asserta(legendary(oreomon,MaxHealth)),
    health(icemon,MaxHealth1),
    asserta(legendary(icemon,MaxHealth1)),
    health(icemon,MaxHealth2),
    asserta(legendary(betamon,MaxHealth2)).
    

banyakInv(Banyak) :-
	findall(T, inventory(T,_),LBanyak),
	length(LBanyak,Banyak).

addTokemon(_,_) :-
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak >= Max,!,fail.

addTokemon(Tokemon,Health) :-
	asserta(inventory(Tokemon,Health)),!.

delTokemon(Tokemon,Health) :-
	\+inventory(Tokemon,Health),!,fail.

delTokemon(Tokemon,Health) :-
	inventory(Tokemon,Health),
	retract(inventory(Tokemon,Health)),!.

printStatus([]):-!.
printStatus([H|T]):-
	nl,write(H),nl,
	write('Health: '),inventory(H,Health),write(Health),nl,
    write('Type: '),tipe(H,Type), write(Type) ,nl,printStatus(T),!.

printLegendary([]):-!.
printLegendary([H|T]):-
    nl,write(H),nl,
	write('Health: '),legendary(H,Health),write(Health),nl,
    write('Type: '),tipe(H,Type), write(Type) ,nl,printLegendary(T),!.

/* inverse(A,B) : A dan B merupakan sebuah list yang berisi beberapa angka nilai rules
akan bernilai yes jika A merupakan kebalikan dari list B dan no jika tidak. */
rev([], B, B, []).
rev([AH|AT], NewA, B, [_|BT]) :- rev(AT, [AH|NewA], B, BT).
inverse(A, B) :- rev(A, [], B, B).