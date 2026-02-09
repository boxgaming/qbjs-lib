Option Explicit
Export NewGame, Move, AIMove, Moves, SetPiece, RemovePiece, BoardPieces
Export Turn, IsCheck, IsCheckMate, IsFinished, LastErrorMessage
Export FEN, History

Dim Shared sloaded As Integer
Dim Shared As Object jsChessEngine, game, state
Dim Shared lastError As String

Dim s As Object
's = Dom.Create("script", document.head)
$If Javascript Then
    s = document.createElement("script");
    document.head.appendChild(s);
$End If
s.async = true
s.src = "https://cdn.jsdelivr.net/npm/js-chess-engine@1.0.3/dist/js-chess-engine.min.js"
s.onload = @OnLoad

Dim ltimer
While sloaded = 0 And ltimer < 12
    _Delay .1
    ltimer = ltimer + 1
WEnd

$If Javascript Then
    jsChessEngine = window["js-chess-engine"];
$End If
NewGame

Sub OnLoad
    sloaded = -1
End Sub

Sub NewGame
$If Javascript Then
    game = new jsChessEngine.Game();
    state = game.exportJson();
$End If
End Sub

Function Moves(pos As String)
    ReDim As String m(0), move 
    Dim mc As Integer
$If Javascript Then
    var moves = game.moves(pos);
    for (var i=0; i < moves.length; i++) {
        move = moves[i];
$End If
        mc = UBound(m) + 1
        Redim Preserve m(mc) As String
        m(mc) = move
$If Javascript Then
    }
$End If
    Moves = m
End Function

Function BoardPieces
    Dim key, value As String
    Dim board() As String
$If Javascript Then
    for (key in state.pieces) {
        value = state.pieces[key];
$End If
        board(key) = value
$If Javascript Then
    }
$End If
    BoardPieces = board
End Function

Function Move (mstart As String, mend As String)
$If Javascript Then
    try {
        game.move(mstart, mend);
        state = game.exportJson();
        return -1;
    }
    catch (e) {
        lastError = e.message;
        return 0;
    }
$End If
End Function

Sub Move (mstart As String, mend As String)
    Dim result As Integer
    result = Move(mstart, mend)
End Sub

Sub AIMove (level As Integer)
$If Javascript Then
    game.aiMove(level);
    state = game.exportJson();
$End If
End Sub

Function SetPiece (square As String, piece As String)
$If Javascript Then
    try {
        game.setPiece(square, piece);
        state = game.exportJson();
        return -1;
    }
    catch (e) {
        lastError = e.message;
        return 0;
    }
$End If
End Function

Sub SetPiece (square As String, piece As String)
    Dim result As Integer
    result = SetPiece(square, piece)
End Sub

Function RemovePiece (square As String)
$If Javascript Then
    try {
        game.removePiece(square);
        state = game.exportJson();
        return -1;
    }
    catch (e) {
        lastError = e.message;
        return 0;
    }
$End If
End Function

Sub RemovePiece (square As String)
    Dim result As Integer
    result = RemovePiece(square)
End Sub

Function FEN
$If Javascript Then
    FEN = game.exportFEN();
$End If
End Function

Function LastErrorMessage
    LastErrorMessage = lastError
End Function

Function Turn
    Turn = state.turn
End Function

Function IsCheck
$If Javascript Then
    IsCheck = QB.toBoolean(state.check);
$End If
End Function

Function IsCheckMate
$If Javascript Then
    IsCheckMate = QB.toBoolean(state.checkMate);
$End If
End Function

Function IsFinished
$If Javascript Then
     IsFinished = QB.toBoolean(state.isFinished);
$End If
End Function

Function History
    Dim harray As Object
$If Javascript Then
    var harray = game.getHistory();
$End If   
    Dim hist(harray.length) As Object
    Dim hobj As Object
    Dim i As Integer
$If Javascript Then
    for (i=0; i < harray.length; i++) {
        hobj = harray[i];
$End If
        hist(i+1).from = hobj.from
        hist(i+1).to = hobj.to
        hist(i+1).turn = hobj.configuration.turn
$If Javascript Then
    }
$End If
    History = hist
End Function