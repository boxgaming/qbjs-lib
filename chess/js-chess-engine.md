
First just use the QBJS Import statement to include the library:
```basic
Import Chess From "https://boxgaming.github.io/qbjs-lib/chess/js-chess-engine.bas"
```

This will load the API and we can use the following methods to interact with the engine:

## Move  
Move the piece at a given board location to the specified new location
```basic
If Chess.Move("C2", "C3") Then
    ' The move was successful
Else
    ' An error occurred, probably an invalid move
    Print Chess.LastErrorMessage
End If
```

## AIMove 
Let the engine make the next move using the specified difficulty level
```basic
Chess.AIMove 3
```

## Moves
Returns the list of available moves for the piece at the specified board location
```basic
ReDim results(0) As String
results = Chess.Moves("C3")
For i = 1 To UBound(results)
    Print results(i)
Next i
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

The only other methods are **NewGame**, to reset the board for a new game and a few additional functions that return current game state information (**IsCheck**, **IsCheckMate**, **IsFinished**).
