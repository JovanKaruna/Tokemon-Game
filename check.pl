check_win :-
    \+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

check_win :-
    choose(_),
    write('Pilih Tokemon terlebih dahulu ketik "help.".'), nl,!.

check_win :-
    \+legendary(_),nl,nl,
    write('     Congratulation !!!!! You defeated all the legendary Tokemon. Without the'),nl,
    write('legendary Tokemon,  all the wild  Tokemon is in your  command, with  this you'),nl,
    write('finished your mission. You became the hero of the world, but you want to stay'),nl,
    write('in Tokeland to make a place for all the Tokemon.'),nl,
    write('In a few decades Tokeland will became the greatest city in history...'),nl,nl,
    write('          _____ _____ _____    _____ _____ ____  '),nl,
    write('         |_   _|  |  |   __|  |   __|   | |    \\ '),nl,
    write('           | | |     |   __|  |   __| | | |  |  |'),nl,
    write('           |_| |__|__|_____|  |_____|_|___|____/ '),nl,nl,nl,quit,!.

check_win :-
    !.


check_lose :-
    \+game(_),
	write('Command ini hanya bisa dipakai setelah command "start.".'), nl,!.

check_lose :-
    choose(_),
    write('Pilih Tokemon terlebih dahulu ketik "help.".'), nl,!.

check_lose :-
    \+inventory(_,_,_,_),nl,nl,
    write('    Oh nooo... You don`t have any Tokemon left, all the wild Tokemon is attacking'),nl,
    write('you. You got surrounded and then you died. You failed to save the world, Now  the'),nl,
    write('world is full of Tokemon and the humans hide in fears.'),nl,nl,
    write('          __ __ _____ _____    __    _____ _____ _____ '),nl,
    write('         |  |  |     |  |  |  |  |  |     |   __|   __|'),nl,
    write('         |_   _|  |  |  |  |  |  |__|  |  |__   |   __|'),nl,
    write('           |_| |_____|_____|  |_____|_____|_____|_____|'),nl,nl,nl,
    quit,!.

check_lose :-
    !.

loselegendary :-
    findall(Legend,legendary(Legend),Llegend),
	retractlegendary(Llegend),!.
