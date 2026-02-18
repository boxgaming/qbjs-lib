Export Create, Add, AddFolder, Title, Destroy, Hide, Show, Close, Open
Export Name, Options, Disable, Enable, UpdateDisplay
Option Explicit

Init

Function Create
$If Javascript Then
    var c = { container: document.getElementById("gx-container") };
    var gui = new window.__GUI(c);
    gui.domElement.style.position = "absolute";
    gui.domElement.style.top = "0";
    gui.domElement.style.right = "0";
    window.__lilguis.push(gui);
    return gui;
$End If
End Function

Sub Title (gui, ttext)
$If Javascript Then
    gui.title(ttext);
$End If
End Sub

Function Add (gui, obj, element, min, max, value)
$If Javascript Then
    return gui.add(obj, element, min, max, value);
$End If
End Function

Sub Add (gui, obj, element, min, max, value)
    Dim controller
    controller = Add(gui, obj, element, min, max, value)
End Sub

Function AddFolder (gui, folderName)
$If Javascript Then
    return gui.addFolder(folderName);
$End If
End Function

Sub Destroy (gui)
$If Javascript Then
    gui.destroy();
$End If
End Sub

Sub Close (gui)
$If Javascript Then
    gui.close();
$End If
End Sub

Sub Open (gui)
$If Javascript Then
    gui.open();
$End If
End Sub

Sub Show (element)
$If Javascript Then
    element.show();
$End If
End Sub

Sub Hide (element)
$If Javascript Then
    element.hide();
$End If
End Sub

Sub Name (controller, newName)
$If Javascript Then
    controller.name(newName);
$End If
End Sub

Sub Enable (controller)
$If Javascript Then
    controller.enable();
$End If
End Sub

Sub Disable (controller)
$If Javascript Then
    controller.disable();
$End If
End Sub

Sub UpdateDisplay (controller)
$If Javascript Then
    controller.updateDisplay();
$End If
End Sub

Sub Options (controller, optArray())
    If UBound(optArray) < 1 Then Exit Sub
    Dim o As Object
    o = optArray(1)
$If Javascript Then
    if (typeof o == "string") { var opts = []; }
    else { var opts = {}; }
$End If
    Dim i As Integer
    For i = 1 To UBound(optArray)
        o = optArray(i)
$If Javascript Then
        if (typeof o == "string") {
            opts.push(o);
        }
        else {
            opts[o.name] = o.value;
        }
$End If
    Next i
$If Javascript Then
    controller.options(opts);
$End If
End Sub

Sub Init
    ' Destroy any previous guis created in this window
$If Javascript Then
    if (window.__lilguis) {
        for (var i=0; i < window.__lilguis.length; i++) {
            window.__lilguis[i].destroy();
        }
    }
    window.__lilguis = [];
$End If

    ' If the library is already loaded, exit now
    If window.__GUI Then Exit Sub

    Dim s As Object
$If Javascript Then
    s = document.createElement("script");
    document.head.appendChild(s);
$End If
    s.type = "module"
    s.innerText = _
        "import GUI from 'https://cdn.jsdelivr.net/npm/lil-gui@0.21/+esm';" + _
        "window.__GUI = GUI;"
        
    Dim wtimer As Integer
    While !window.__GUI And wtimer < 100
        Delay .1
        wtimer = wtimer + 1
    WEnd
End Sub