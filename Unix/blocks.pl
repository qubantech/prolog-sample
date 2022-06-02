%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Планирование в мире блоков
%% Сергей Синица, 2014, sin@kubsu.ru
%% Адаптировано с J.R. Fisher, 
%% 
%% Блоки лежат на столе или друг на друге
%% Блоки не могут висеть в воздухе
%% На один блок можно поставить не более одного блока
%% 
%% Поиск и выполнение плана:
%% plan([on(b,c), on(a,b), on(c,table)]).
%%
%% Просмотр результата:
%% listing(on).
%% listing(move).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- dynamic on/2.

% начальное состояние
%  __
% |c_|    __
% |a |   |b |
% -----------

on(a, table).
on(c, a).
on(b, table).

% помещаем блок A на B (элементарное действие)
put_on(A, B) :-
  A \== table,
  A \== B,
  on(A, X),
  clear(A),
  clear(B),
  retract(on(A, X)),
  assert(on(A, B)),
  assert(move(A, X, B)).

% проверка что сверху свободно и можно что-то поставить
clear(table).
clear(B) :- 
  not(on(_X, B)).

% помещаем блок A на B (рекурсивное действие)
r_put_on(A, B) :-
  on(A, B).
r_put_on(A, B) :-
  not(on(A, B)),
  A \== table,
  A \== B,
  clear_off(A),
  clear_off(B),
  on(A, X),
  retract(on(A, X)),
  assert(on(A, B)),
  assert(move(A, X, B)).

% очищаем сверху
clear_off(table).
clear_off(A) :-
  not(on(_X, A)).
clear_off(A) :-
  A \== table,
  on(X,A),
  clear_off(X), %рекурсия
  retract(on(X, A)),
  assert(on(X, table)),
  assert(move(X, A, table)).

% выполнение списка целей
plan(Goals) :-
   valid(Goals),
   plan(Goals, Goals).

% TODO: проверка корректности цели
valid(_).

plan([G|R], Allgoals) :-
  call(G), %если цель достигнута
  plan(R, Allgoals), !.

plan([G|_], Allgoals) :-
  achieve(G),
  plan(Allgoals, Allgoals). %заново проверяем все цели
plan([], _Allgoals).

achieve(on(A,B)) :-
  r_put_on(A,B).