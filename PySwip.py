from pyswip import Prolog

def Solve(size):
    prolog = Prolog()
    prolog.consult("SudokuSolver.pl") 
    result = list(prolog.query(f"example(Puzzle, {size}), sudoku(Puzzle, {size})", maxresult=1))
    if(result):
        print('Here is the solution to the puzzle:')
        print(*result[-1]['Puzzle'], sep='\n')

if __name__ == '__main__':
    Solve(4)