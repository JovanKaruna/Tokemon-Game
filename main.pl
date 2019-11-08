:- include('map.pl').

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
    help,
    write('Legends:'),nl,
    write('    - X = Pagar'),nl,
    write('    - P = Player'),nl,
    write('    - G = Gym').

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
    write('    load(Filename). -- load previously saved game'),nl,nl.

map :-
    showMap(0,0,10,10).

