:- include('tokemon.pl').
:- dynamic(player/2).
:- dynamic(inventory/4).
:- dynamic(legendary/2).
:- dynamic(choose/1).
:- dynamic(exp/1).

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
    asserta(legendary(betamon,MaxHealth2)),
    asserta(exp(0)).



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

addExp(X) :-
    exp(Old),
    retract(exp(Old)),
    New is Old+X,
    asserta(exp(New)).

upgrade(_) :-
    player(X,Y),
    \+isMeteorite(X,Y),
    write('Kamu hanya bisa melakukan level up di Meteorite!'),nl,!.

upgrade(Tokemon) :-
    player(X,Y),
    isMeteorite(X,Y),
    \+inventory(Tokemon,_,_,_),
    write('Kamu tidak memiliki Tokemon tersebut!'),nl,!.
    
upgrade(Tokemon) :-
    player(X,Y),
    isMeteorite(X,Y),
    inventory(Tokemon,_,_,Level),
    (Level =:= 5),
    write('Tokemon tersebut sudah pada level maksimum!'),nl,!.
    

upgrade(Tokemon) :-
    player(X,Y),
    isMeteorite(X,Y),
    exp(E),
    inventory(Tokemon,Health,MaxHealth,Level),
    (Level < 5),
    NeededExp is 10 + (Level*10),
    (
        (E >= NeededExp) ->
        (
            retract(inventory(Tokemon,Health,MaxHealth,Level)),
            addExp(-NeededExp),
            NewHealth is Health + 10,
            NewMaxHealth is MaxHealth + 10,
            NewLevel is Level + 1,
            asserta(inventory(Tokemon,NewHealth,NewMaxHealth,NewLevel)),
            write(Tokemon),write(' naik ke level '),write(NewLevel),write('!'),nl
        );
        (write('EXP tidak cukup untuk melakukan level up!'),nl)
    ),!.

levelUp :-
    player(X,Y),
    isMeteorite(X,Y),
    write('Kamu bisa melakukan level up Tokemon di sini!'),nl,
    availableTokemon,
    write('Ketik "upgrade(X).", X diganti dengan AvailableTokemon yang ada di atas.'),nl,!.

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
