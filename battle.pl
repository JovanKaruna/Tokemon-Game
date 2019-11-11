:- include('player.pl').
:- dynamic(battle/1).
:- dynamic(inbattle/4).
:- dynamic(enemy/4).
:- dynamic(special/1).

init_battle:-
    asserta(battle(1)).

pick(_) :-
	choose(_),
	write('Pilih dulu tokemon yang akan menjadi partnermu, ketik "help." untuk mengetahui caranya.'),nl,!.

pick(_) :-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.
pick(_):-
	\+battle(0),
	write('Command ini hanya dapat dilakukan setelah command "fight.".'),nl,!.

pick(X):-
	battle(0),
	\+inventory(X,_,_,_),
	write('"You don`t have that Tokemon!"'),!.

pick(X):-
	battle(0),
	inventory(X,Health,MaxHealth,Level),
	delTokemon(X),
	write('You :    "'), write(X),write(' I choose you!"'),nl,nl,
	asserta(inbattle(X,Health,MaxHealth,Level)),
	retract(battle(0)),
	asserta(battle(2)),
	writeBattle,!.

writeBattle:-
	\+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'),nl,!.

writeBattle:-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.

writeBattle:-
	battle(2),
	inbattle(X,Health,_,Level),
	enemy(Y,EnemyHealth,_,LevelEnemy),
	write('Wild Tokemon :'),nl,write(Y),nl,write('Level : '), write(LevelEnemy),nl,
	write('Health : '),write(EnemyHealth),nl,
	write('Type : '),tipe(Y,TypeEnemy), write(TypeEnemy),nl,nl,
	write('Your Tokemon :'), nl, write(X),nl,write('Level : '), write(Level),nl,
	write('Health : '), write(Health),nl,
	write('Type : '),tipe(X,Type), write(Type),nl,nl,!.

attack :-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.

attack :-
	battle(2),
	inbattle(X,_,_,_),
	damage(X,DamageToEnemy),
	enemy(Y,EnemyHealth,_,_),
	DamageToEnemy >= EnemyHealth,
	write(Y),write(' faints! Do you want to capture '),write(Y),
	write('?  (capture/0 to capture, otherwise move away.)'),nl,
	retract(inbattle(X,Health,MaxHealth,Level)),
	addTokemon(X,Health,MaxHealth,Level),
	retract(battle(2)),
	asserta(battle(3)),
	(special(1) -> retract(special(1)),!;!).

attack :-
	battle(2),
	inbattle(X,Health,MaxHealth,Level),
	damage(X,DamageToEnemy),
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	damage(Y,DamagetoUs),
    retract(inbattle(X,Health,MaxHealth,Level)),
	write(Y),write(' attacks!'),nl,
	write('It deals '),write(DamagetoUs),write(' damage to '), write(X),nl,nl,
	NewHealth is Health - DamagetoUs, write(NewHealth),nl,
	(NewHealth > 0 -> asserta(inbattle(X,NewHealth,MaxHealth,Level)),writeBattle;
    asserta(inbattle(X,0,MaxHealth,Level)),writeBattle,faints),!.

faints :-
    \+battle(2),
    write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.

faints :-
    battle(2),
    \+inbattle(X,0,_,_),
    write('Your '),write(X),write(' is still strong to fight!'),nl,!.

faints :-
    battle(2),
    retract(inbattle(X,_,_,_)),
    write('Your '),write(X),write(' fainted, choose another tokemon!'),
    retract(battle(2)),
    asserta(battle(0)),nl,!.


specialattack :-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.


specialattack :-
	battle(2),
	\+special(1),
	write('Special attacks can only be used once per battle!'),nl,!.

specialattack :-
	battle(2),
	special(1),
	retract(special(1)),
	inbattle(X,_,_,_),
	specialmove(X,Move,DamageToEnemy),
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	(DamageToEnemy < EnemyHealth -> asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy));
	DamageToEnemy >= EnemyHealth -> asserta(enemy(Y,0,MaxHealthEnemy,LevelEnemy))),
	writeBattle,!.


capture :-
	\+battle(3),
	write('Command ini hanya bisa digunakan saat tokemon musuh dikalahkan.'),!.

capture :-
	battle(3),
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak >= Max,
	write('You cannot capture another Tokemon! You have to drop one first.'),nl,!.

capture:-
	battle(3),
	enemy(Y,Health,MaxHealth,Level),
	addTokemon(Y,MaxHealth,MaxHealth,Level),
	retract(enemy(Y,Health,MaxHealth,Level)),
	write(Y),
	write(' is captured!'),nl,
	retract(battle(_)),!.

drop(_):-
	\+battle(3),
	write('Command ini hanya bisa digunakan saat tokemon musuh dikalahkan.'),!.

drop(_) :-
	battle(3),
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak < Max,
	write('Your inventory is not full'),!.

drop(X) :-
	battle(3),
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak >= Max,
	\+inventory(X,_,_,_),
	write('You don`t have that Tokemon!'),!.

drop(X) :-
	battle(3),
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak >= Max,
	inventory(X,_,_,_),
	write('You dropped '), write(X),nl,nl,
	delTokemon(X),
	capture,!.
