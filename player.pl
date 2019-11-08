:- dynamic(player/2).
:- dynamic(maxInventory/1).

init_player:-
    tinggi(T),
    lebar(L),
    random(1,L,X),
    random(1,T,Y),
    asserta(player(X,Y)),
    asserta(maxInventory(6)).