integer(I) -->
  digit(D0),
  digits(D),
  { number_chars(I, [D0|D]) }.

digits([D|T]) -->
        digit(D), !,
        digits(T).

digits([]) -->
  [].

digit(D) -->
  [D],
  { code_type(D, digit) }.