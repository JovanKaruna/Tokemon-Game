:- dynamic(notop/1).

writeNotOP :-
    write('Whoops.. something\'s not right here. (You can\'t do that!)'),nl,nl.

op :-
    \+notop(1),!.

op :-
    retract(notop(1)).

deop :-
    notop(1),!.

deop :-
    asserta(notop(1)).

/* Template command OP
command :-
    notop(1),
    writeNotOP,!.
*/
