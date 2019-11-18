fusion(cupmon,eclairmon,honeymon,marshmon).
fusion(honeymon,nougatmon,piemon,kitmon).
fusion(alphamon,cupmon,jellymon,lollimon).

availableFusion :-
	write('Available Fusions: '),
    findall(Fusion,(inventory(A,_,_,_),inventory(B,_,_,_),inventory(C,_,_,_),fusion(A,B,C,Fusion)),LFusion),
	printAvailableFusion(LFusion),!.

printAvailableFusion([]):- nl,!.
printAvailableFusion([H|T]):-
    fusion(A,B,C,H),
    nl,
    write(A), write(' + '),
    write(B), write(' + '),
    write(C), write(' ==> '),
    write('['), write(H), write(']'), printAvailableFusion(T),!.


fuse(_) :-
    \+game(_),!.

fuse(_) :-
    player(X,Y),
    \+isMeteorite(X,Y),
    write('Kamu hanya bisa melakukan fusion di Meteorite!'),nl,!.

fuse(Tokemon) :-
    player(X,Y),
    isMeteorite(X,Y),
    \+fusion(_,_,_,Tokemon),
    write('Fusion tidak tersedia!'),nl,!.

fuse(Tokemon) :-
    player(X,Y),
    isMeteorite(X,Y),
    fusion(A,B,C,Tokemon),
    ((\+inventory(A,_,_,_));(\+inventory(B,_,_,_));(\+inventory(C,_,_,_))),
    write('Kamu tidak memiliki cukup Tokemon untuk melakukan fusion tersebut!'),nl,!.

fuse(Tokemon) :-
    player(X,Y),
    isMeteorite(X,Y),
    fusion(A,B,C,Tokemon),
    inventory(A,_,_,LevelA),
    inventory(B,_,_,LevelB),
    inventory(C,_,_,LevelC),
    op,delTokemon(A),
    delTokemon(B),
    delTokemon(C),deop,
    health(Tokemon,RealHealth),
    Level1 is max(LevelA,LevelB),
    Level is max(Level1,LevelC),
    Health is RealHealth + (Level-1)*10,
    (inventory(Tokemon,_,_,_) ->
        (retract(inventory(Tokemon,_,_,_)));
        (retract(wild(Tokemon)))
    ),
    op,addTokemon(Tokemon,Health,Health,Level),deop,
	(wild(Tokemon) -> retract(wild(Tokemon))),
    write('Tokemon berhasil di-fusion!'),nl,!.
