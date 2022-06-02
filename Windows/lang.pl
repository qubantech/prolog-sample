%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  Sergey Sinitsa, 2014, sin@kubsu.ru.
%%%  �������������� ��������� ���� ������.
%%%  Based on J.R. Fisher.

:-[read_line].
:-[blocks].

s(L) --> lead_in, c(L), end.

end --> ['.'] | ['?'].

/*  ������� �������������� �����:
   Please place <put> a on <onto> b, c on d, and d on the table.
   I want <would like> a on b, c on d, and d on the table.
   I want <would like> you to put <place> ...
   Can <could> <would> you <please> put a on b, c on d, and d on the table?
*/

lead_in --> please, place.
lead_in --> [i], [want] | [i], [would], [like], you_to_put.
lead_in --> ([can] | [could] | [would]), [you], please, place.

you_to_put --> [] | [you], [to], place.

please --> [] | [please].

place --> [put] | [place].

c([ON]) --> on(ON).
c([ON|R]) --> on(ON), comma, c(R).

comma --> [','] | ['and'] | [','],[and].

on(on(X,Y)) --> [X], ([on] | [onto] | [on],[top],[of]), [Y].
on(on(X,table)) --> [X],([on] | [onto]), [the], [table].


test_parser :-
  repeat,
  write('?? '),
  read_line(X),
  s(F,X,[]),
  nl, write(X), nl, write(F), nl, fail.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ������: Which block is on top of X?

q(is_on_top_of('What', A)) --> [what],[is],[on],[top],[of],[A],end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ������: Which blocks are on the table?

q(on_the_table(_A)) --> [which], [blocks], [are], [on], [the], [table], end.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ����� � ����� ������ � ����� ������ �� ������

is_on_top_of(B, A) :- on(B, A), !.
is_on_top_of('Nothing', _A).

on_the_table(Blocks) :-
  bagof(A, on(A, table), Blocks), !.

answer(is_on_top_of('What', A)) :-
  call(is_on_top_of(X, A)),
  say([X,is,on,top,of,A]).
answer(on_the_table(A)) :-
  call(on_the_table(A)),
  say([A,is,on,the,table]).

say([X|R]) :- write(X), write(' '), say(R).
say([]).


% ������� ����, ��������� ���� ��������� ��
blocks :-
  write('Enter ''stop.'' to exit blocks world.'), nl,
  blocks_loop.

blocks_loop :-
  read_line(S),
  process(S),
  nl,
  !,
  blocks_loop.

process([stop,'.']) :- !, fail.
process(S) :- s(F,S,[]), !,  continue(F).
process(Q) :- q(F,Q,[]), !,  answer(F).
process(_) :- write('I do not understand!').

continue(Goal_List) :-
  valid(Goal_List),
  !,
  plan(Goal_List).
continue(_Goal_List) :- write('Cannot do that!').