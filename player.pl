:- include('tokemon.pl').
:- dynamic(player/2).
:- dynamic(inventory/4).
:- dynamic(legendary/2).
:- dynamic(choose/1).

maxInventory(6).

init_player:-
    tinggi(T),
    lebar(L),
    random(1,L,X),
    random(1,T,Y),
    asserta(player(X,Y)),
    asserta(choose(1)),
    health(oreomon,MaxHealth),
    asserta(legendary(oreomon,MaxHealth)),
    health(icemon,MaxHealth1),
    asserta(legendary(icemon,MaxHealth1)),
    health(icemon,MaxHealth2),
    asserta(legendary(betamon,MaxHealth2)).



tokemon1 :-
    \+choose(_),
    write('Command ini hanya bisa dipakai sekali saja saat memilih tokemon.'), nl,!.

tokemon1 :-
    choose(_),
    addTokemon(alphamon,50,50,1),
    retract(wild(alphamon)),
    write('Congratulations partnermu adalah alphamon.'),nl,
    retract(choose(1)),!.

tokemon2 :-
    \+choose(_),
    write('Command ini hanya bisa dipakai sekali saja saat memilih tokemon.'), nl,!.

tokemon2 :-
    choose(_),
    addTokemon(kitmon,100,100,1),
    retract(wild(kitmon)),
    write('Congratulations partnermu adalah kitmon.'),nl,
    retract(choose(1)),!.

tokemon3 :-
    \+choose(_),
    write('Command ini hanya bisa dipakai sekali saja saat memilih tokemon.'), nl,!.

tokemon3 :-
    choose(_),
    addTokemon(froyomon,75,75,1),
    retract(wild(froyomon)),
    write('Congratulations partnermu adalah froyomon.'),nl,
    retract(choose(1)),!.

banyakInv(Banyak) :-
	findall(T, inventory(T,_,_,_),LBanyak),
	length(LBanyak,Banyak).

addTokemon(_,_,_,_) :-
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak >= Max,!,fail.

addTokemon(Tokemon,Health,MaxHealth,Level) :-
	assertz(inventory(Tokemon,Health,MaxHealth,Level)),!.

delTokemon(Tokemon) :-
	\+inventory(Tokemon,_,_,_),!,fail.

delTokemon(Tokemon) :-
	inventory(Tokemon,_,_,_),
	retract(inventory(Tokemon,_,_,_)),!.

printStatus([]):-!.
printStatus([H|T]):-
	nl,write(H),nl,inventory(H,Health,_,Level), write('Level: '),
	write(Level),nl,write('Health: '),write(Health),nl,
    write('Type: '),tipe(H,Type), write(Type),nl,printStatus(T),!.

printLegendary([]):-!.
printLegendary([H|T]):-
    nl,write(H),nl,
	write('Health: '),legendary(H,Health),write(Health),nl,
    write('Type: '),tipe(H,Type), write(Type) ,nl,printLegendary(T),!.

healing([]):-!.
healing([H|T]):-
    inventory(H,Health,MaxHealth,Level), retract(inventory(H,Health,_,Level)),
    asserta(inventory(H,MaxHealth,MaxHealth,Level)), healing(T),!.

retractinventory([]):-!.
retractinventory([H|T]):-
    retract(inventory(H,_,_,_)),retractinventory(T),!.

retractlegendary([]):- !.
retractlegendary([H|T]):-
    retract(legendary(H,_)),retractlegendary(T),!.

/* inverse(A,B) : A dan B merupakan sebuah list yang berisi beberapa angka nilai rules
        akan bernilai yes jika A merupakan kebalikan dari list B dan no jika tidak. */
        rev([], B, B, []).
        rev([AH|AT], NewA, B, [_|BT]) :- rev(AT, [AH|NewA], B, BT).
        inverse(A, B) :- rev(A, [], B, B).
