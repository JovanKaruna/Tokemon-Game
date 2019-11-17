fusion(froyomon, jellymon, nougatmon, betamon).
fusion(donutmon, eclairmon, honeymon, alphamon).

availableFusion :-
	write('Available Fusions: '),
    findall(Fusion,(inventory(A,_,_,_),inventory(B,_,_,_),inventory(C,_,_,_),fusion(A,B,C,Fusion)),LFusion),
	printAvailableFusion(LFusion),!.

printAvailableFusion([]):- nl,!.
printAvailableFusion([H|T]):-
    fusion(A,B,C,H),
	nl,write('['),
    write(A), write(' + '),
    write(B), write(' + '),
    write(C), write(' ==> '),
    write(H), write(']'), printAvailable(T),!.
