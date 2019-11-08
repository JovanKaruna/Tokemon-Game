mapAtas(X,_) :-
    X =:= 0,
    !.

mapKiri(_,Y) :-
    Y =:= 0,
    !.

mapKanan(_,Y,Lebar) :-
    NewL is Lebar + 1,
    NewL =:= Y,
    !.

mapBawah(X,_,Tinggi) :-
    NewT is Tinggi + 1,
    X =:= NewT,
    !.


showMap(X,Y,Tinggi,Lebar) :-
    mapAtas(X,Y),!, write('X'), NewY is Y + 1,((NewY =:= (Lebar + 2) -> nl, showMap(X+1,0,Tinggi,Lebar)); (showMap(X,NewY,Tinggi,Lebar))).
showMap(X,Y,Tinggi,Lebar) :-
    mapBawah(X,Y,Tinggi), !, write('X'),NewY is Y + 1,((NewY =:= (Lebar + 2) -> nl); (showMap(X,NewY,Tinggi,Lebar))).
showMap(X,Y,Tinggi,Lebar) :-
    mapKiri(X,Y), !, write('X'), NewY is Y + 1, showMap(X,NewY,Tinggi,Lebar).
showMap(X,Y,Tinggi,Lebar) :-
    mapKanan(X,Y,Lebar), !, write('X'),nl, showMap(X+1,0,Tinggi,Lebar).
showMap(X,Y,Tinggi,Lebar):-
        write('-'),!, showMap(X,Y+1,Tinggi,Lebar).