# js-chess-engine QBJS API

This API provides a simplified, Basic syntax interface to the [js-chess-engine](https://github.com/josefjadrny/js-chess-engine) API. 

Spaces are represented by their rank and file identifiers (e.g. "E1", "c2").  Space identifiers are case-insensitive.  
||1|2|3|4|5|6|7|8|
|--|--|--|--|--|--|--|--|--|
|**A**|A1|A2|A3|A4|A5|A6|A7|A8|
|**B**|B1|B2|B3|B4|B5|B6|B7|B8|
|**C**|C1|C2|C3|C4|C5|C6|C7|C8|
|**D**|D1|D2|D3|D4|E5|E6|E7|E8|
|**E**|E1|E2|E3|E4|E5|E6|E7|E8|
|**F**|F1|F2|F3|F4|F5|F6|F7|F8|
|**G**|G1|G2|G3|G4|G5|G6|G7|G8|
|**H**|H1|H2|H3|H4|H5|H6|H7|H8|

Pieces are represented by single letter identifiers:
| |White Pieces| |Black Pieces|
|-|------------|-|------------|
|K|White King  |k|Black King  |
|Q|White Queen |q|Black Queen |
|B|White Bishop|b|Black Bishop|
|N|White Knight|n|Black Knight|
|R|White Rook  |r|Black Rook  |
|P|White Pawn  |p|Black Pawn  |

## Samples
[Simple Chess Game with Text UI](https://qbjs.org#src=https://boxgaming.github.io/qbjs-lib/chess/samples/simple-chess-tui.zip)

# API Reference
Use the QBJS Import statement to include the library:
```basic
Import Chess From "https://boxgaming.github.io/qbjs-lib/chess/js-chess-engine.bas"
```

This will load the API and make available the following methods to interact with the engine:

## AIMove 
Let the engine make the next move using the specified difficulty level.
```basic
Chess.AIMove 3
```

## BoardPieces
Returns a map containing the board locations with pieces present.
```basic
Dim pieces() As String
pieces = Chess.BoardPieces
Print "B1: "; pieces("B1")
Print "E8: "; pieces("E8")
Print "G5: "; pieces("G5")
```
In the standard beginning positions the above would output:
```
B1: N
E8: k
G5: 
```

## FEN
Returns an string representation of the game in Forsyth–Edwards Notation.
```basic
Print Chess.FEN
```
Example output:
```
5Qk1/p3B2p/2pqbp2/3np1p1/1b6/N2P4/PPQ1PPPP/2KR1BNR b - - 0 13
```

## History
Returns a listing of all moves from the current game.
```basic
ReDim hist(0) As Object
hist = Chess.History
For i = 1 To UBound(hist)
    Print i; hist(i).turn; " "; hist.from; " -> "; hist.to
Next i
```

## IsCheck
Returns boolean value (-1, 0) indicating whether the current turn is in check.
```basic
If Chess.IsCheck Then Print "Check!"
```

## IsCheckMate
Returns boolean value (-1, 0) indicating whether the current turn is in check.
```basic
If Chess.IsCheckMate Then Print "Check Mate!"
```

## IsFinished
Returns boolean value (-1, 0) indicating whether the current game has reached an end state.
```basic
If Chess.IsFinished Then Print "Game Over!"
```

## LastErrorMessage
Returns a text description of the last error.  
__See Move code sample below for usage.__

## Move  
Move the piece at a given board location to the specified new location.
```basic
If Chess.Move("C2", "C3") Then
    ' The move was successful
Else
    ' An error occurred, probably an invalid move
    Print Chess.LastErrorMessage
End If
```

## Moves
Returns the list of available moves for the piece at the specified board location.
```basic
ReDim results(0) As String
results = Chess.Moves("C3")
For i = 1 To UBound(results)
    Print results(i)
Next i
```

## NewGame
Resets the board for a new game with standard chess piece placement.
```basic
Chess.NewGame
```

## RemovePiece
Removes a piece from the board at the specified location.
```basic
Chess.RemovePiece "C2"
```
## Turn
Returns "white" or "black" to indicate the current turn.
```basic
Print Chess.Turn
```

## SetPiece
Sets a piece at the specified board location.
```basic
Chess.SetPiece "F1", "k"
```
