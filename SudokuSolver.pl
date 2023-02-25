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

example([[_, 1, _, _],
         [_, _, 2, _],
         [_, 2, _, _],
         [_, _, 3, _]], 2). 

example([[5,3,_,_,7,_,_,_,_],
         [6,_,_,1,9,5,_,_,_],
         [_,9,8,_,_,_,_,6,_],
         [8,_,_,_,6,_,_,_,3],
         [4,_,_,8,_,3,_,_,1],
         [7,_,_,_,2,_,_,_,6],
         [_,6,_,_,_,_,2,8,_],
         [_,_,_,4,1,9,_,_,5],
         [_,_,_,_,8,_,_,7,9]], 3).

example([[2,14,12, _, _, _, 1, 7, _, _, 8, 9,15, _, _, _],
         [8, _, _, _, _, 2, 6, _,14, 5, _, _, _, _, 3,16],
         [4, 6, _, _,14,11, _, 3, _, _,13, 7, _, _, 8, _],
         [_, 3, _, _, 9, 8, _,13,15,11, 1, _, 6,14, _, _],
         [1,10,14, _, 5, 4, _, 6, _, _, _,11, _, 7, _,15],
         [_,16, 4, _, 2, _, _,10, 1, _, _, _, 9, _,11,13],
         [_, _, _, 5,13, _, 7, _, _, 4, 3,14, _, _, 1, _],
         [_, _, _, _, _, _, _, _, _, _,16, _, _, 4, _, _],
         [_, _,11, 8, 7,12, 5, 1, _, _,14, 2, _,10, _, _],
         [6, _, 1, _, _, _, 2, _,16, _,12, _, 4,15, _, _],
         [15,_, 7,12,11,13,14, _, _, _, 4, 6, _, 8, _, 3],
         [_, _, _, _, _,10, _, _, _, 3, _, 5, _, 9,12, 1],
         [_, _, 2,11, _, 6, _, _, _, 9, _, _, _, _, _, 4],
         [5,13, _, _,15, 1,16, 9, _, _, 6, _,11, _, 7, 2],
         [7, 8, _, _, _, _,12, _, _, _, _, _, _,13,15,14],
         [_, _, _,15,10, _, _, _, _, _, 2, _, _, _, 9, _]], 4).
        