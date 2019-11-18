:- include('battle.pl').
:- include('fusion.pl').
:- dynamic(player/2).
:- dynamic(lebar/1).
:- dynamic(tinggi/1).
:- dynamic(game/1).
:- dynamic(heal/1).
:- dynamic(wild/1).

init_map:-
    random(15,30,L),
    random(10,25,T),
    asserta(lebar(L)),
    asserta(tinggi(T)),
    asserta(game(1)),
    asserta(heal(1)).

isGym(X,Y):-
    ((Y =:= 2),(X =:= 7) -> !);((Y =:= 18),(X =:= 20) -> !)
    ;((Y =:= 12),(X =:= 18) -> !);((Y =:= 9),(X =:= 3) -> !).

isMeteorite(X,Y):-
    ((Y =:= 4),(X =:= 19) -> !);((Y =:= 7),(X =:= 10) -> !)
    ;((Y =:= 14),(X =:= 5) -> !).

mapAtas(_,Y) :-
    Y =:= 0,
    !.

mapKiri(X,_) :-
    X =:=0,
    !.

mapBawah(_,Y) :-
    tinggi(T),
    TinggiMax is T+1,
    Y =:= TinggiMax,
    !.
mapKanan(X,_) :-
    lebar(L),
    LebarMax is L+1,
    X =:= LebarMax,
    !.

showMap(X,Y) :-
    mapKanan(X,Y), write('X'), !.
showMap(X,Y) :-
    mapKiri(X,Y), write('X'), !.
showMap(X,Y) :-
    mapAtas(X,Y), write('X'), !.
showMap(X,Y) :-
    mapBawah(X,Y), write('X'), !.
showMap(X,Y) :-
    player(X,Y), write('P'), !.
showMap(X,Y) :-
    isGym(X,Y), write('G'), !.
showMap(X,Y) :-
    isMeteorite(X,Y), write('M'), !.
showMap(_,_) :-
	write('-'), !.
