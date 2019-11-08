:- include('map.pl').

start :-
	game(_),
	write('Kamu tidak bisa melakukan "start." ketika game sudah dimulai.'), nl, !.

start :-
    write(' _______    _                              '),nl,
    write('|__   __|  | |                             '),nl,
    write('   | | ___ | | _____ _ __ ___   ___  _ __  '),nl,
    write('   | |/ _ \\| |/ / _ \\ `_ ` _ \\ / _ \\| `_ \\ '),nl,
    write('   | | (_) |   <  __/ | | | | | (_) | | | |'),nl,
    write(' __|_|\\___/|_|\\_\\___|_| |_| |_|\\___/|_| |_|'),nl,
    write('|  __ \\             ___    | |             '),nl,
    write('| |__) | __ ___    ( _ )   | | ___   __ _  '),nl,
    write('|  ___/ `__/ _ \\   / _ \\/\\ | |/ _ \\ / _` | '),nl,
    write('| |   | | | (_) | | (_>  < | | (_) | (_| | '),nl,
    write('|_|   |_|  \\___/   \\___/\\/ |_|\\___/ \\__, | '),nl,
    write('                                     __/ | '),nl,
    write('                                    |___/  '),nl,
    write('       Pada suatu hari, bumi tiba-tiba dihujani meteor. Serangan terakhir meteor'),nl,
    write('jatuh  di salah  satu pulau di  bumi yang bernama  Tokeland. Setelah  itu muncul'),nl,
    write('sekawanan monster yang berasal dari pecahan meteor tersebut. Tiba - tiba monster'),nl,
    write('tersebut  bersifat  liar  dan  menyerang manusia  di  sekitarnya. Monster  yang'),nl,
    write('menyerang para manusia kemudian dikenal dengan  nama Tokemon.'),nl,
    write('       Anda memiliki kekuatan untuk  menjinakan tokemon  setelah  mengalahkannya.'),nl,
    write('Pemerintah mengetahui hal ini dan memanggil anda untuk diberi tugas menyelamatkan'),nl,
    write('dunia. Anda  diberikan  pilihan  oleh Presiden  untuk  menggunakan  tokemon  yang'),nl,
    write('sudah ditangkap pemerintah. Pemain  akan diterjunkan  langsung ke  pulau Tokeland'),nl,
    write('yang sekarang  sudah menjadi sarang para tokemon untuk mengungkapkan misteri para'),nl,
    write('Tokemon.'),nl,nl,
    help,nl,
    write('Legends:'),nl,
    write('    - X = Pagar'),nl,
    write('    - P = Player'),nl,
    write('    - G = Gym'),
    init_map, init_player,!.

help :-
    write('Available commands:'),nl,
    write('    start. -- start the game!'),nl,
    write('    help. -- show available commands'),nl,
    write('    quit. -- quit the game'),nl,
    write('    n. s. e. w. -- move'),nl,
    write('    map. -- look at the map'),nl,
    write('    heal -- cure Tokemon in inventory if in gym center'),nl,
    write('    status. -- show your status'),nl,
    write('    save(Filename). -- save your game'),nl,
    write('    load(Filename). -- load previously saved game'),nl,!.

/*Map*/
map :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

map :-
	tinggi(T),
	lebar(L),
	X1 is 0, X2 is L+1,
	Y1 is 0, Y2 is T+1,
	forall(between(Y1,Y2,Y), (
		forall(between(X1,X2,X), (
			 showMap(X,Y)
		)),
		nl
	)),nl, !.

/*quit*/
quit :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

quit :-
	retract(player(_,_)),
	retract(game(_)),
	retract(lebar(_)),
	retract(tinggi(_)),
	write('Game selesai.'),nl,!.

/* Movement n,e,w,s*/
n :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
n :-
	player(_,Y),
	Y =:= 1,
	write('Di sebelah utara, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl, !.
n :-
	retract(player(X,Y)),
	Y > 1,
	NewY is Y-1,
	write('Anda bergerak ke utara, kamu berada pada '),
	(isGym(X,NewY) -> write('Gym Center.'); isMeteorite(X,NewY) -> write('Meteorite');write('tanah kosong.')),nl,
	asserta(player(X,NewY)), !.
e :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
e  :-
	player(X,_),
	lebar(L),
	X =:= L,
	write('Di sebelah timur, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl, !.
e :-
	retract(player(X,Y)),
	lebar(L),
	X < L, NewX is X+1,
	write('Anda bergerak ke timur, kamu berada pada '),
	(isGym(NewX,Y) -> write('Gym Center.'); isMeteorite(NewX,Y) -> write('Meteorite');write('tanah kosong.')),nl,
	asserta(player(NewX,Y)), !.
w :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

w :-
	player(X,_),
	X =:= 1,
	write('Di sebelah barat, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl, !.
w :-
	retract(player(X,Y)),
	X > 1, NewX is X-1,
	write('Anda bergerak ke barat, kamu berada pada '),
	(isGym(NewX,Y) -> write('Gym Center.'); isMeteorite(NewX,Y) -> write('Meteorite');write('tanah kosong.')),nl,
	asserta(player(NewX,Y)), !.
s :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
s :-
	player(_,Y),
	tinggi(T),
	Y =:= T,
	write('Di sebelah selatan, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl, !.
s :-
	retract(player(X,Y)),
	tinggi(T),
	Y < T,
	NewY is Y+1,
	write('Anda bergerak ke selatan, kamu berada pada '),
	(isGym(X,NewY) -> write('Gym Center.'); isMeteorite(X,NewY) -> write('Meteorite');write('tanah kosong.')),nl,
	asserta(player(X,NewY)), !.