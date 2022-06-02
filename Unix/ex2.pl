s --> symbols(Sem,a),symbols(Sem,b),symbols(Sem,c).
symbols(end,_) --> [].
symbols(s(Sem),S) --> [S],symbols(Sem,S). 
