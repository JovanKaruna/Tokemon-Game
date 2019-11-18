:- include('map.pl').
:- include('check.pl').
:- include('saveload.pl').
:- initialization(nl).
:- initialization(write('                                      ,\'\\')).
:- initialization(nl).
:- initialization(write('                       ____         ,\'  _\\   ___    ___     ____')).
:- initialization(nl).
:- initialization(write('________________      |    |  /`.   \\,-\'    |   \\  /   |   |    \\  |`.')).
:- initialization(nl).
:- initialization(write('\\               \\     \'-.  | /   `.  ___    |    \\/    |   \'-.   \\ |  |')).
:- initialization(nl).
:- initialization(write(' \\____.    ._____\\      |  |/    ,\',\'_  `.  |          | __  |    \\|  |')).
:- initialization(nl).
:- initialization(write('       \\    \\     ,\' _`.|      ,\' / / / /   |          ,\' _`.|     |  |')).
:- initialization(nl).
:- initialization(write('        \\    \\   /  / \\ \\    ,\'   | \\/ / ,`.|         /  / \\ \\  |     |')).
:- initialization(nl).
:- initialization(write('         \\    \\ |   \\_/  |   `-.  \\    `\'  /|  |    ||   \\_/  | |\\    |')).
:- initialization(nl).
:- initialization(write('          \\    \\ \\      /       `-.`.___,-\' |  |\\  /| \\      /  | |   |')).
:- initialization(nl).
:- initialization(write('           \\    \\ `.__,\'|  |`-._    `|      |__| \\/ |  `.__,\'|  | |   |')).
:- initialization(nl).
:- initialization(write('            \\_.-\'       |__|    `-._ |              \'-.|     \'-.| |   |')).
:- initialization(nl).
:- initialization(write('                                    `\'                            \'-._|')).
:- initialization(nl).
:- initialization(nl).
:- initialization(write('To Start the game use command "start."')).
:- initialization(nl).
:- initialization(write('To load use command "loadFile(Filename)."')).
:- initialization(nl).



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
	init_map, help,init_player ,nl,
    write('Legends:'),nl,
    write('    - X = Pagar'),nl,
    write('    - P = Player'),nl,
    write('    - G = Gym'),nl,
	write('    - M = Meteorite'),nl,nl,
	write('Pilih salah satu Tokemon dibawah ini untuk menjadi partnermu:'),nl,
    write('   1. alphamon  : fire'),nl,
    write('   2. kitmon    : water'),nl,
    write('   3. froyomon  : grass'),nl,
    write('Ketik nomor tokemon seperti "tokemon1." jika memilih alphamon.'),nl,
	asserta(wild(alphamon)),
    asserta(wild(cupmon)),
    asserta(wild(donutmon)),
    asserta(wild(eclairmon)),
    asserta(wild(froyomon)),
    asserta(wild(gingermon)),
    asserta(wild(honeymon)),
    asserta(wild(jellymon)),
    asserta(wild(kitmon)),
    asserta(wild(lollimon)),
    asserta(wild(marshmon)),
    asserta(wild(nougatmon)),
    asserta(wild(piemon)),
	asserta(multiplier(0)),
	asserta(enemy(fictional,0,0,0)),!.


help :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

help :-
	choose(_),
	write('Untuk memilih tokemon yang akan menjadi partnermu,'),nl,
	write('ketik "tokemon1." jika memilih alphamon.'),nl,
	write('ketik "tokemon2." jika memilih kitmon.'),nl,
	write('ketik "tokemon3." jika memilih froyomon.'),nl,!.

help :-
	battle(3),
	write('"capture." untuk menangkap tokemon, "drop." jika inventory sudah full'),nl,
	write('"w.","a.","s.","d." jika tidak ingin menangkap tokemon.'),nl,nl,!.


help :-
	battle(2),
	write('Ketik "attack." untuk menyerang musuh, "specialattack." untuk menggunakan serangan special.'),nl,!.

help  :-
	battle(0),
	write('Ketik "pick(X).", X diganti dengan AvailableTokemon yang ada di atas.'),nl,
	write('untuk mengetahui Available Tokemon ketik "availableTokemon.".'),nl,!.

help :-
	battle(1),
	write('Ketik "fight." untuk bertarung atau "run." untuk kabur.'),nl,!.

help :-
    write('Available commands:'),nl,
    write('    start. -- start the game!'),nl,
    write('    help. -- show available commands'),nl,
    write('    quit. -- quit the game'),nl,
    write('    w. a. s. d. -- move'),nl,
    write('    map. -- look at the map'),nl,
    write('    heal. -- heal Tokemon in inventory if in gym center'),nl,
    write('    status. -- show your status'),nl,
	write('    upgrade(Tokemon). -- Level up Tokemon'),nl,
	write('    fuse(Tokemon). -- Fusion your Tokemon'),nl,
    write('    save(Filename). -- save your game'),nl,
    write('    loadFile(Filename). -- load previously saved game'),nl,!.

/*Map*/
map :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

map :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

map :-
	(battle(1);battle(0);battle(2)),
	write('Command ini tidak dapat dilakukan ketika bertemu Tokemon. '),nl,!.

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
	)),nl,!.

/*quit*/
quit :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

quit :-
	retract(player(_,_)),
	retract(game(_)),
	retract(lebar(_)),
	retract(tinggi(_)),
	retract(exp(_)),
	findall(Tokemon,inventory(Tokemon,_,_,_),LTokemon),
	(legendary(_) -> (findall(Legend,legendary(Legend),Llegend),retractlegendary(Llegend));!),
	retractinventory(LTokemon),
	(choose(_) -> retract(choose(_));!),
	(inbattle(_,_,_,_) -> retract(inbattle(_,_,_,_));!),
	(enemy(_,_,_,_) -> retract(enemy(_,_,_,_));!),
	(battle(_) -> retract(battle(_));!),
	(special(_) -> retract(special(_));!),
	(specialenemy(_) -> retract(specialenemy(_));!),
	write('Game selesai.'),nl,!.

/* Movement n,e,w,s*/
w :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

w :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

w:-
	battle(0),
	write('Command ini tidak dapat dilakukan setelah command di dalam battle.'),nl,!.

w :-
	battle(1),
	write('Command ini tidak dapat dilakukan ketika bertemu Tokemon. '),nl,!.


w :-
	battle(2),
	write('Command ini tidak dapat dilakukan ketika sedang dalam battle. '),nl,!.

w :-
	player(_,Y),
	Y =:= 1,
	write('Di sebelah utara, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl,
	(battle(3) -> retract(battle(3)),!;!).

w :-
	retract(player(X,Y)),
	Y > 1,
	NewY is Y-1,
	asserta(player(X,NewY)),
	random(1,100,Peluang),
	((Peluang >= 60 -> write('Uh Oh... A wild Tokemon appears!'),nl,write('Fight or Run?'),init_battle,nl,!);
	write('Anda bergerak ke utara, kamu berada pada '),printPlace),
	(battle(3) -> retract(battle(3)),!;!).

d :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

d :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

d :-
	battle(0),
	write('Command ini tidak dapat dilakukan setelah command di dalam battle.'),nl,!.

d :-
	battle(1),
	write('Command ini tidak dapat dilakukan ketika bertemu Tokemon. '),nl,!.


d  :-
	battle(2),
	write('Command ini tidak dapat dilakukan ketika sedang dalam battle. '),nl,!.

d  :-
	player(X,_),
	lebar(L),
	X =:= L,
	write('Di sebelah timur, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl,
	(battle(3) -> retract(battle(3)),!;!).

d :-
	retract(player(X,Y)),
	lebar(L),
	X < L, NewX is X+1,
	asserta(player(NewX,Y)),
	random(1,100,Peluang),
	((Peluang >= 60 -> write('Uh Oh... A wild Tokemon appears!'),nl,write('Fight or Run?'),init_battle,nl,!);
	write('Anda bergerak ke timur, kamu berada pada '),printPlace),
	(battle(3) -> retract(battle(3)),!;!).

a :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

a :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
a :-
	battle(0),
	write('Command ini tidak dapat dilakukan setelah command di dalam battle.'),nl,!.

a :-
	battle(1),
	write('Command ini tidak dapat dilakukan ketika bertemu Tokemon. '),nl,!.

a  :-
	battle(2),
	write('Command ini tidak dapat dilakukan ketika sedang dalam battle. '),nl,!.

a :-
	player(X,_),
	X =:= 1,
	write('Di sebelah barat, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl,
	(battle(3) -> retract(battle(3)),!;!).
a :-
	retract(player(X,Y)),
	X > 1, NewX is X-1,
	asserta(player(NewX,Y)),
	random(1,100,Peluang),
	((Peluang >= 60 -> write('Uh Oh... A wild Tokemon appears!'),nl,write('Fight or Run?'),init_battle,nl,!);
	write('Anda bergerak ke barat, kamu berada pada '),printPlace),
	(battle(3) -> retract(battle(3)),!;!).

s :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

s :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
s :-
	battle(0),
	write('Command ini tidak dapat dilakukan setelah command di dalam battle.'),nl,!.

s :-
	battle(1),
	write('Command ini tidak dapat dilakukan ketika bertemu Tokemon. '),nl,!.

s  :-
	battle(2),
	write('Command ini tidak dapat dilakukan ketika sedang dalam battle. '),nl,!.

s :-
	player(_,Y),
	tinggi(T),
	Y =:= T,
	write('Di sebelah selatan, kamu melihat sebuah pagar yang tinggi, kamu tidak dapat melompatinya.'),nl,
	(battle(3) -> retract(battle(3)),!;!).

s :-
	retract(player(X,Y)),
	tinggi(T),
	Y < T,
	NewY is Y+1,
	asserta(player(X,NewY)),
	random(1,100,Peluang),
	((Peluang >= 60 -> write('Uh Oh... A wild Tokemon appears!'),nl,write('Fight or Run?'),init_battle,nl,!);
	write('Anda bergerak ke selatan, kamu berada pada '),printPlace),
	(battle(3) -> retract(battle(3)),!;!).


printPlace:-
	player(X,Y),
	(isGym(X,Y) -> write('Gym Center.');
	isMeteorite(X,Y) -> write('Meteorite'),nl,nl,levelUp; write('tanah kosong.')),nl,!.


/* status. */

status :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

status :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

status :-
	write('Your EXP: '),
	exp(E),
	write(E),nl,nl,
	findall(Tokemon,inventory(Tokemon,_,_,_),LTokemon),write('Your Tokemon:'),
	printStatus(LTokemon),nl,
	findall(Tokemon,legendary(Tokemon),Llegendary),nl,
	write('Your Enemy:'),printLegendary(Llegendary),!.

/* heal */

heal :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

heal :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
heal :-
	(battle(1);battle(0);battle(2)),
	write('Command ini tidak dapat dilakukan ketika bertemu Tokemon.'),nl,!.

heal :-
	player(X,Y), \+isGym(X,Y),
	write('Command "heal" hanya bisa dilakukan saat berada di Gym Center.'), nl,!.

heal :-
	player(X,Y), isGym(X,Y), \+heal(_),
	write('Penggunaan heal hanya bisa dilakukan sekali saja dalam satu game.'),nl,!.

heal :-
	player(X,Y), isGym(X,Y), heal(1), findall(Tokemon,inventory(Tokemon,_,_,_),LTokemon),
	inverse(LTokemon,ListInv),write('Tokemon di inventory telah di heal sampai penuh.'),
	healing(ListInv),nl,
	retract(heal(1)),!.

/* fight or run */
fight :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

fight :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

fight :-
	\+battle(1),
	write('Command ini hanya dapat dilakukan ketika bertemu Tokemon. '),nl,!.

fight :-
	battle(1), write('Choose your Tokemon !'),nl,nl,
	availableTokemon,
	retract(battle(1)),
	asserta(battle(0)),
	random(1,6,RandLegend),
	( % start if-else
		( % peluang legendary
			RandLegend =:= 1,
			legendary(_)
		) ->
		( % legendary enemy
			write('You feel a strong aura... It is a legendary Tokemon !!'),nl,
			aggregate_all(count, legendary(_), CountL),
			IL is random(CountL)+1, nth_clause(legendary(_),IL,RL), clause(HL,_,RL),
			HL = legendary(Legend), health(Legend, HealthL),
			(enemy(Et,Eh,Em,El) -> retract(enemy(Et,Eh,Em,El)),!;!),
			asserta(enemy(Legend,HealthL,HealthL,5))
		);
		( % normal enemy
			aggregate_all(count, wild(_), Count),
			I is random(Count)+1, nth_clause(wild(_),I,R), clause(H,_,R),
			H = wild(Tokemon), health(Tokemon, RealHealth),
			(enemy(Et,Eh,Em,El) -> retract(enemy(Et,Eh,Em,El)),!;!),
			% random level
			random(1,3,EnemyLevel),
			Health is RealHealth + (EnemyLevel-1)*10,
			asserta(enemy(Tokemon,Health,Health,EnemyLevel))
		)
	), % end if-else
	asserta(special(1)),
	asserta(specialenemy(1)),!.

run :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

run :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

run:-
	\+battle(1),
	write('Command ini hanya dapat dilakukan ketika bertemu Tokemon. '),nl,!.

run :-
	battle(1),
	random(1,10,Peluang),
	(Peluang >= 5 -> write('Kamu berhasil kabur...'),nl,retract(battle(_));
	write('Kamu gagal untuk kabur!'),nl,nl,	fight),!.

availableTokemon :-
	write('Available Tokemons: '),findall(Tokemon,inventory(Tokemon,_,_,_),LTokemon),
	printAvailable(LTokemon),!.

printAvailable([]):- nl,!.
printAvailable([H|T]):-
	nl,write('['), write(H), write(']'), printAvailable(T),!.
