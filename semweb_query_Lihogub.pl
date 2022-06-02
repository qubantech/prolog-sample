/*
Example #1:
load.
parse([Кто, производит, девятку, ?], Answer).

Example #2:
load.
parse([Кто, выпускает, семерку, ?], Answer).

Example #3:
load.
parse([Кто, делает, ВАЗ-2101, ?], Answer).
*/

:-use_module(library(semweb/rdf_db)).
:-use_module(library(semweb/turtle)).


rdf_assert_data([rdf(X,Y,Z)|T]) :-
  rdf_assert(X,Y,Z), rdf_assert_data(T).
rdf_assert_data([_|T]) :- rdf_assert_data(T).
rdf_assert_data([]).

load_data :-
  rdf_read_turtle('mappingbased-objects_lang=ru.ttl', T, []),
  rdf_assert_data(T).

load :-
  load_data.

модель('http://ru.dbpedia.org/resource/ВАЗ-2121') --> ([ниву] | [ВАЗ-2121]) .
модель('http://ru.dbpedia.org/resource/ВАЗ-2106') --> ([копейку] | [ВАЗ-2101]) .
модель('http://ru.dbpedia.org/resource/ВАЗ-2106') --> ([шестерку] | [ВАЗ-2106]) .
модель('http://ru.dbpedia.org/resource/ВАЗ-2107') --> ([семерку] | [ВАЗ-2107]) .
модель('http://ru.dbpedia.org/resource/ВАЗ-2109') --> ([девятку] | [ВАЗ-2109]) .

действие('http://dbpedia.org/ontology/manufactory') --> ([делает] | [производит] | [выпускает]) .

поиск_производителя(Модель, Действие) --> [Кто], действие(Действие), модель(Модель), ['?'] .

parse(Tokens, Answer) :- phrase(поиск_производителя(Модель, Действие), Tokens, _), rdf(Модель, Действие, Answer).

parse(_).
