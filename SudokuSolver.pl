:- use_module(library(clpfd)).

sudoku(Puzzle, Square) :-
    Size is Square*Square,
    length(Puzzle, Size),
    maplist(same_length(Puzzle), Puzzle),
    flatten(Puzzle, Elems),
    Elems ins 1..Size,
    maplist(all_distinct, Puzzle),
    transpose(Puzzle, Colmns),
    maplist(all_distinct, Colmns),

    chunks(Square, Puzzle, RowChunks),
    maplist(blocks(Square), RowChunks),
    maplist(writeln, Puzzle).




chunks(_, [], []).
chunks(N, [X|Xs], [Chunk|Chunks]) :-
  split(N, [X|Xs], Chunk, Leftover),
  chunks(N, Leftover, Chunks).

split(N, Xs, Left, Right) :-
    N =< 0, !, N =:= 0, 
    Left = [], 
    Right = Xs.
split(_, [], [], []).
split(N, [X|Xs], [X|Ys], Right) :- 
    M is N-1, 
    split(M, Xs, Ys, Right).

map(_Fun, [], []).
map(Fun, [H|T], [HO|TO]) :-
  call(Fun, H, HO),
  map(Fun, T, TO).

blocks(ChunckSize, RowChunk) :-
  map(chunks(ChunckSize), RowChunk, ColChunks),
  transpose(ColChunks, Almost),
  map(append, Almost, Blocks),
  maplist(all_distinct, Blocks).




checkSquares(_, []).
checkSquares(ChunckSize, Puzzle) :-
    split_at(ChunckSize, Puzzle, [Split, Rest]),
    splitSquares(ChunckSize, Split, [X|Xs]),
    checkSquares(ChunckSize, Rest).

splitSquares(_, [], _).
splitSquares(ChunckSize, [Row|Rows], [Sqr|Sqrs]) :-
    split_at(ChunckSize, Row, [Split, Rest]),
    append(Split, Sqr),
    splitSquares().


% example([[_, 7, _, 5, _, 6, _, _, 2],
%          [8, _, _, _, _, _, _, _, 9],
%          [_, _, 3, _, 1, _, _, _, _],
%          [_, _, _, _, _, _, 7, 4, _],
%          [_, 6, _, _, 2, _, _, _, 5],
%          [_, 9, _, 8, _, _, _, _, _],
%          [_, _, _, _, _, 4, _, _, 6],
%          [_, _, _, _, 7, 5, 9, _, _],
%          [6, _, 4, _, _, _, 5, _, _]], 3).

example([[_, _, _, _, 8, 9, _, _, _],
         [5, _, _, _, _, _, 2, _, 8],
         [_, _, 4, 2, _, _, _, 1, _],
         [_, _, 7, 8, _, _, 3, _, _],
         [_, 6, _, 7, _, 1, _, 9, _],
         [_, _, 9, _, _, 6, 7, _, _],
         [_, 3, _, _, _, 7, 5, _, _],
         [2, _, 8, _, _, _, _, _, 3],
         [_, _, _, 3, 4, _, _, _, _]], 3). 
% no single solution

% example([[_,_,_,_,_,_,_,_,_],
% 	       [_,_,_,_,_,3,_,8,5],
%          [_,_,1,_,2,_,_,_,_],
%          [_,_,_,5,_,7,_,_,_],
%          [_,_,4,_,_,_,1,_,_],
%          [_,9,_,_,_,_,_,_,_],
%          [5,_,_,_,_,_,_,7,3],
%          [_,_,2,_,1,_,_,_,_],
%          [_,_,_,_,4,_,_,_,9]], 3).