:- use_module(library(clpfd)).

sudoku(Puzzle, Square) :-
    Size is Square*Square,
    length(Puzzle, Size),
    maplist(same_length(Puzzle), Puzzle),
    flatten(Puzzle, Elems),
    Elems ins 1..Size,
    maplist(all_distinct, Puzzle),
    transpose(Puzzle, Columns),
    maplist(all_distinct, Columns),

    chunks(Square, Puzzle, RowChunks),
    maplist(blocks(Square), RowChunks).


chunks(_, [], []).
chunks(Size, List, [Chunk|Chunks]) :-
    length(Chunk, Size),
    append(Chunk, Rest, List),
    chunks(Size, Rest, Chunks).

map(_Fun, [], []).
map(Fun, [H|T], [HO|TO]) :-
  call(Fun, H, HO),
  map(Fun, T, TO).

blocks(Square, Rows) :-
  map(chunks(Square), Rows, Cols),
  transpose(Cols, Almost),
  map(append, Almost, Blocks),
  maplist(all_distinct, Blocks).