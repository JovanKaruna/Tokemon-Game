save(_) :-
    \+game(_),
    write('Command ini hanya bisa dipakai setelah game dimulai.'), nl,
    write('Ketik command "start." untuk menuju ke game.'), nl, !.

save(_) :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

save(_) :-
    battle(_),
    write('Command ini tidak bisa dipakai saat melakukan battle.'),nl,!.
    
save(FileName) :-
    tell(FileName),
    writeInventory,
    writeLegendary,
    writeLebarTinggi,
    writePlayer,
    writeHeal,
    writeExp,
    told, 
    write('Save berhasil dilakukan !'),nl,!.

writeExp :-
    exp(X),
    write('exp('), write(X), write(').'), nl,!.

writeLegendary :-
    forall(legendary(Name,MaxHealth),(write('legendary('),write(Name),
    write(','),write(MaxHealth),write(').'),nl)),!.

writeLebarTinggi :-
    lebar(L),
    tinggi(T),
    write('lebar('), write(L), write(').'), nl,
    write('tinggi('), write(T), write(').'), nl, !.

writePlayer :-
    player(X,Y),
    write('player('), write(X),write(','),write(Y), write(').'),nl,!.

writeHeal :-
    \+heal(_), !.

writeHeal :-
    write('heal('), write(1), write(').'), nl, !.

writeInventory:-
    \+inventory(_,_,_,_),!.

writeInventory:-
    forall(inventory(Tokemon, Health, MaxHealth, Level),
    (write('inventory('), write(Tokemon), write(','), write(Health), write(','),
    write(MaxHealth), write(','), write(Level), write(').'), nl)), !.

loadFile(_) :-
    game(_),
    write('Kamu tidak bisa memulai game lainnya ketika sudah start.'),nl,!.

loadFile(FileName):-
    \+exists_file(FileName),
    write('File yang anda masukkan tidak ada...'),nl, 
    write('Mohon tulis ulang filename yang benar atau "start." untuk memulai game.'),nl,!.

loadFile(FileName):-
    open(FileName, read, Stream),
    read_File_Lines(Stream,L),
    close(Stream),
    addline(L), 
    asserta(game(1)), 
    write('Load ke dalam file '), write(FileName),write(' berhasil dilakukan !'),nl,!.

read_File_Lines(Stream,[]) :-
    at_end_of_stream(Stream).

read_File_Lines(Stream,[H|T]) :-
    \+ at_end_of_stream(Stream),
    read(Stream,H),
    read_File_Lines(Stream,T).

addline([]) :- !.
addline([H|T]):-
    assertz(H),
    addline(T), !.