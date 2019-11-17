:- include('player.pl').
:- dynamic(battle/1).
:- dynamic(inbattle/4).
:- dynamic(enemy/4).
:- dynamic(special/1).
:- dynamic(specialenemy/1).
:- dynamic(multiplier/1).

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
	effective,
	retract(battle(0)),
	asserta(battle(2)),
	writeBattle,!.

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

writeBattle:-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.

writeBattle:-
    \+game(_),
    write('Command ini hanya bisa dipakai setelah command "start.".'),nl,!.

attack :-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.

% player attack dan lawan mati
attack :-
	battle(2),
    multiplier(0),
	inbattle(X,_,_,_),
	damage(X,DamageToEnemy),
	enemy(Y,EnemyHealth,_,_),
	DamageToEnemy >= EnemyHealth,
	write(Y),write(' faints! Do you want to capture '),write(Y),
	write('?  (capture/0 to capture, otherwise move away.)'),nl,
	retract(inbattle(X,Health,MaxHealth,Level)),
	addTokemon(X,Health,MaxHealth,Level),check_win,
	retract(battle(2)),
	asserta(battle(3)),
	(special(1) -> retract(special(1)),!;!),
	(specialenemy(1) -> retract(specialenemy(1)),!;!).

% player attack 3 / 2 dan lawan mati
attack :-
	battle(2),
	multiplier(1),
	inbattle(X,_,_,_),
	damage(X,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy * 3 / 2,
	enemy(Y,EnemyHealth,_,_),
	DamageToEnemy >= EnemyHealth,
	write(Y),write(' faints! Do you want to capture '),write(Y),
	write('?  (capture/0 to capture, otherwise move away.)'),nl,
	retract(inbattle(X,Health,MaxHealth,Level)),
	addTokemon(X,Health,MaxHealth,Level),check_win,
	retract(battle(2)),
	asserta(battle(3)),
	(special(1) -> retract(special(1)),!;!),
	(specialenemy(1) -> retract(specialenemy(1)),!;!).

% player attack 0.5 dan lawan mati
attack :-
	battle(2),
	multiplier(2),
	inbattle(X,_,_,_),
	damage(X,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy / 2,
	enemy(Y,EnemyHealth,_,_),
	DamageToEnemy >= EnemyHealth,
	write(Y),write(' faints! Do you want to capture '),write(Y),
	write('?  (capture/0 to capture, otherwise move away.)'),nl,
	retract(inbattle(X,Health,MaxHealth,Level)),
	addTokemon(X,Health,MaxHealth,Level),check_win,
	retract(battle(2)),
	asserta(battle(3)),
	(special(1) -> retract(special(1)),!;!),
	(specialenemy(1) -> retract(specialenemy(1)),!;!).

% player attack dan lawan special atack
attack :-
	specialenemy(1),
	battle(2),
	multiplier(0),
	inbattle(X,_,_,_),
	damage(X,DamageToEnemy),
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	random(1,8,Specialenemy),
	(Specialenemy >= 1 -> specialattack_enemy;
	enemyattack),!.

% player attack 3 / 2 dan lawan special attack 0.5
attack :-
	specialenemy(1),
	multiplier(1),
	battle(2),
	inbattle(X,_,_,_),
	damage(X,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy * 3 / 2,
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	random(1,8,Specialenemy),
	(Specialenemy >= 1 -> specialattack_enemy;
	enemyattack),!.

% player attack 0.5 dan lawan special attack 3 / 2
attack :-
	specialenemy(1),
	multiplier(2),
	battle(2),
	inbattle(X,_,_,_),
	damage(X,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy / 2,
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	random(1,8,Specialenemy),
	(Specialenemy >= 1 -> specialattack_enemy;
	enemyattack),!.

% player attack dan lawan attack
attack :-
	battle(2),
	multiplier(0),
	inbattle(X,_,_,_),
	damage(X,DamageToEnemy),
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	enemyattack,!.

% player attack 3 / 2 dan lawan attack 0.5
attack :-
	battle(2),
	multiplier(1),
	battle(2),
	inbattle(X,_,_,_),
	damage(X,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy * 3 / 2,
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	enemyattack,!.

%  player attack 0.5 dan lawan attack 3 / 2
attack :-
	battle(2),
	multiplier(2),
	battle(2),
	inbattle(X,_,_,_),
	damage(X,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy /  2,
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	DamageToEnemy<EnemyHealth,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),
	writeBattle,
	enemyattack,!.

% enemy attack biasa
enemyattack :-
	battle(2),
	multiplier(0),
	enemy(Y,_,_,_),
	inbattle(X,Health,MaxHealth,Level),
	damage(Y,DamagetoUs),
    retract(inbattle(X,Health,MaxHealth,Level)),
	write(Y),write(' attacks!'),nl,
	write('It deals '),write(DamagetoUs),write(' damage to '), write(X),nl,nl,
	NewHealth is Health - DamagetoUs,
	(NewHealth > 0 -> asserta(inbattle(X,NewHealth,MaxHealth,Level)),writeBattle;
    asserta(inbattle(X,0,MaxHealth,Level)),writeBattle,faints),!.

% enemy attack 0.5
enemyattack :-
	battle(2),
	multiplier(1),
	enemy(Y,_,_,_),
	inbattle(X,Health,MaxHealth,Level),
	damage(Y,RealDamagetoUs),
	DamagetoUs is RealDamagetoUs /  2,
    retract(inbattle(X,Health,MaxHealth,Level)),
	write(Y),write(' attacks!'),nl,
	write('It deals '),write(DamagetoUs),write(' damage to '), write(X),nl,nl,
	NewHealth is Health - DamagetoUs,
	(NewHealth > 0 -> asserta(inbattle(X,NewHealth,MaxHealth,Level)),writeBattle;
    asserta(inbattle(X,0,MaxHealth,Level)),writeBattle,faints),!.

% enemy attack 3 / 2
enemyattack :-
	battle(2),
	multiplier(2),
	enemy(Y,_,_,_),
	inbattle(X,Health,MaxHealth,Level),
	damage(Y,RealDamagetoUs),
	DamagetoUs is RealDamagetoUs * 3 / 2,
    retract(inbattle(X,Health,MaxHealth,Level)),
	write(Y),write(' attacks!'),nl,
	write('It deals '),write(DamagetoUs),write(' damage to '), write(X),nl,nl,
	NewHealth is Health - DamagetoUs,
	(NewHealth > 0 -> asserta(inbattle(X,NewHealth,MaxHealth,Level)),writeBattle;
    asserta(inbattle(X,0,MaxHealth,Level)),writeBattle,faints),!.

faints :-
    \+battle(2),
    write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.

faints :-
    battle(2),
    inbattle(X,Health,_,_),
    Health > 0,
    write('Your '),write(X),write(' is still strong to fight!'),nl,!.

faints :-
    battle(2),
    retract(inbattle(X,_,_,_)),
    write('Your '),write(X),write(' fainted, choose another tokemon!'),
    retract(battle(2)),
    asserta(battle(0)),check_lose,nl,!.


specialattack :-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.


specialattack :-
	battle(2),
	\+special(1),
	write('Special attacks can only be used once per battle!'),nl,!.

% player attack special attack
specialattack :-
	battle(2),
	multiplier(0),
	special(1),
	retract(special(1)),
	inbattle(X,_,_,_),
	specialmove(X,Move,DamageToEnemy),
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
    CurrentHealth is EnemyHealth - DamageToEnemy,
	(DamageToEnemy < EnemyHealth -> (asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),writeBattle,enemyattack);
	DamageToEnemy >= EnemyHealth -> (asserta(enemy(Y,0,MaxHealthEnemy,LevelEnemy)),attack)),
	!.

% player attack special attack * 1.5
specialattack :-
	battle(2),
	multiplier(1),
	special(1),
	retract(special(1)),
	inbattle(X,_,_,_),
	specialmove(X,Move,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy * 3 / 2,
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is EnemyHealth - DamageToEnemy,
	(DamageToEnemy < EnemyHealth -> (asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),writeBattle,enemyattack);
	DamageToEnemy >= EnemyHealth -> (asserta(enemy(Y,0,MaxHealthEnemy,LevelEnemy)),attack)),
	!.


% player attack special attack * 0.5

specialattack :-
	battle(2),
	multiplier(2),
	special(1),
	retract(special(1)),
	inbattle(X,_,_,_),
	specialmove(X,Move,RealDamageToEnemy),
	DamageToEnemy is RealDamageToEnemy / 2,
	enemy(Y,EnemyHealth,MaxHealthEnemy,LevelEnemy),
	retract(enemy(Y,EnemyHealth,_,LevelEnemy)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('You dealt '),write(DamageToEnemy),write(' damage to '), write(Y),nl,nl,
    CurrentHealth is EnemyHealth - DamageToEnemy,
	(DamageToEnemy < EnemyHealth -> (asserta(enemy(Y,CurrentHealth,MaxHealthEnemy,LevelEnemy)),writeBattle,enemyattack);
	DamageToEnemy >= EnemyHealth -> (asserta(enemy(Y,0,MaxHealthEnemy,LevelEnemy)),attack)),
	!.


specialattack_enemy :-
	\+battle(2),
	write('Command ini tidak bisa digunakan jika tidak dalam battle'),nl,!.


specialattack_enemy :-
	battle(2),
	\+specialenemy(1),
	write('Special attacks can only be used once per battle!'),nl,!.

% enemy attack special attack
specialattack_enemy :-
	battle(2),
	multiplier(0),
	specialenemy(1),
	retract(specialenemy(1)),
	enemy(X,_,_,_),
	specialmove(X,Move,DamageToUs),
	inbattle(Y,Health,MaxHealth,Level),
	retract(inbattle(Y,Health,_,Level)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('It dealt '),write(DamageToUs),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is Health - DamageToUs,
	(DamageToUs < Health -> asserta(inbattle(Y,CurrentHealth,MaxHealth,Level)),writeBattle;
	DamageToUs >= Health -> asserta(inbattle(Y,0,MaxHealth,Level)),writeBattle,faints),!.

% enemy attack special attack /  2
specialattack_enemy :-
	battle(2),
	multiplier(1),
	specialenemy(1),
	retract(specialenemy(1)),
	enemy(X,_,_,_),
	specialmove(X,Move,RealDamageToUs),
	DamageToUs is RealDamageToUs /  2,
	inbattle(Y,Health,MaxHealth,Level),
	retract(inbattle(Y,Health,_,Level)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('It dealt '),write(DamageToUs),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is Health - DamageToUs,
	(DamageToUs < Health -> asserta(inbattle(Y,CurrentHealth,MaxHealth,Level)),writeBattle;
	DamageToUs >= Health -> asserta(inbattle(Y,0,MaxHealth,Level)),writeBattle,faints),!.

% enemy attack special attack * 3 / 2
specialattack_enemy :-
	battle(2),
	multiplier(2),
	specialenemy(1),
	retract(specialenemy(1)),
	enemy(X,_,_,_),
	specialmove(X,Move,RealDamageToUs),
	DamageToUs is RealDamageToUs * 3 / 2,
	inbattle(Y,Health,MaxHealth,Level),
	retract(inbattle(Y,Health,_,Level)),
	write(X), write(' uses '), write(Move),write('!'),nl,
	write('It dealt '),write(DamageToUs),write(' damage to '), write(Y),nl,nl,
	CurrentHealth is Health - DamageToUs,
	(DamageToUs < Health -> asserta(inbattle(Y,CurrentHealth,MaxHealth,Level)),writeBattle;
	DamageToUs >= Health -> asserta(inbattle(Y,0,MaxHealth,Level)),writeBattle,faints),!.

capture :-
	\+battle(3),
	write('Command ini hanya bisa digunakan saat tokemon musuh dikalahkan.'),!.

capture :-
	battle(3),
	banyakInv(Banyak),
	maxInventory(Max),
	Banyak >= Max,
	write('You cannot capture another Tokemon! You have to drop one first.'),nl,!.

capture :-
	battle(3),
	enemy(Y,_,MaxHealth,Level),
	addTokemon(Y,MaxHealth,MaxHealth,Level),
    retract(wild(Y)),
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

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'fire', Tipe_Y = 'leaves',
    retract(multiplier(_)),
	asserta(multiplier(1)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'leaves', Tipe_Y = 'water',
    retract(multiplier(_)),
	asserta(multiplier(1)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'water', Tipe_Y = 'fire',
    retract(multiplier(_)),
	asserta(multiplier(1)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'lightning', Tipe_Y = 'water',
    retract(multiplier(_)),
	asserta(multiplier(1)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'lightning', Tipe_Y = 'water',
    retract(multiplier(_)),
	asserta(multiplier(2)),!.

% kebalikan
effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'leaves', Tipe_Y = 'fire',
    retract(multiplier(_)),
	asserta(multiplier(2)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'water', Tipe_Y = 'leaves',
    retract(multiplier(_)),
	asserta(multiplier(2)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'fire', Tipe_Y = 'water',
    retract(multiplier(_)),
	asserta(multiplier(2)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'water', Tipe_Y = 'lightning',
    retract(multiplier(_)),
	asserta(multiplier(2)),!.

effective :-
	inbattle(X,_,_,_),
	enemy(Y,_,_,_),
	tipe(X,Tipe_X),tipe(Y,Tipe_Y),
	Tipe_X = 'water', Tipe_Y = 'lightning',
    retract(multiplier(_)),
	asserta(multiplier(1)),!.

effective :-
    retract(multiplier(_)),
	asserta(multiplier(0)),!.
