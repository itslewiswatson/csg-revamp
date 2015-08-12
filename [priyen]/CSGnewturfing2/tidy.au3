$section = IniRead(@ScriptDir&"\tidy.ini", "tidy", "Section", "")
$backup = IniRead(@ScriptDir&"\tidy.ini", "tidy", "CreateBackUp", "")
$TabAdd = StringSplit(IniRead(@ScriptDir&"\tidy.ini", $section, "TabAdd", ""), ";")
$TabRem = StringSplit(IniRead(@ScriptDir&"\tidy.ini", $section, "TabRemove", ""), ";")
$TabSpec = StringSplit(IniRead(@ScriptDir&"\tidy.ini", $section, "TabSpecial", ""), ";")



If $CMDLine[0] > 0 Then
    $file = ""
    For $i = 1 To $CMDLine[0]
        $file &= $CMDLine[$i] & " "
    Next
    $file = StringTrimRight($file, 1)
Else
    $file = FileOpenDialog("Open File",@ScriptDir,$section&" (*."&$section&")"&"|All Files (*.*)")
    If @error Then
        exit
    EndIf
EndIf

$TabLevels = 0
$SpecialLine = 0

;~ $file = @ScriptDir & "\lol.txt"

$data = StringSplit(StringReplace(FileRead($file), @TAB, " "), @CRLF, 1)

If $backup = 1 Then
    DirCreate("backup")
    FileMove($file,@WorkingDir&"\backup\",1)
EndIf

$New = ""
For $i = 1 To $data[0]
    $data[$i] = _RemoveSpacesAndTabs($data[$i])
    $data[$i] = _AddRemoveTabLevels($data[$i])
    $New &= $data[$i] & @CRLF
Next

FileDelete($file)
FileWrite($file,$New)

;~ ClipPut($New)

Func _RemoveSpacesAndTabs($sLine)
    While StringLeft($sLine, 1) = @TAB Or StringLeft($sLine, 1) = " "
        $sLine = StringTrimLeft($sLine, 1)
    WEnd
    Return $sLine
EndFunc   ;==>_RemoveSpacesAndTabs

Func _AddRemoveTabLevels($sLine)
    ;==> Add spaces
    For $i = 1 To $TabAdd[0]
        $sLine = StringReplace($sLine, $TabAdd[$i] & "f(", $TabAdd[$i] & "f (")
    Next
    For $i = 1 To $TabRem[0]
        $sLine = StringReplace($sLine, $TabRem[$i] & "f(", $TabRem[$i] & "f (")
    Next
    For $i = 1 To $TabAdd[0]
        $sLine = StringReplace($sLine, $TabAdd[$i] & "r(", $TabAdd[$i] & "r (")
    Next
    For $i = 1 To $TabRem[0]
        $sLine = StringReplace($sLine, $TabRem[$i] & "r (", $TabRem[$i] & "r (")
    Next
        For $i = 1 To $TabAdd[0]
        $sLine = StringReplace($sLine, $TabAdd[$i] & "e(", $TabAdd[$i] & "e (")
    Next
    For $i = 1 To $TabRem[0]
        $sLine = StringReplace($sLine, $TabRem[$i] & "e(", $TabRem[$i] & "e (")
    Next
        For $i = 1 To $TabAdd[0]
        $sLine = StringReplace($sLine, $TabAdd[$i] & "o(", $TabAdd[$i] & "o (")
    Next
    For $i = 1 To $TabRem[0]
        $sLine = StringReplace($sLine, $TabRem[$i] & "o(", $TabRem[$i] & "o (")
    Next
    ;RemoveDopuble spaces
    $sLine = StringReplace($sLine, "  ", " ")
    $Tabs = ""
    For $i = 1 To $TabLevels
        $Tabs &= @TAB
    Next
    $TabLevelsCurrent = $TabLevels
    _SetTabLevels($sLine)
    If $TabLevelsCurrent > $TabLevels Then
        $Tabs = ""
        For $i = 1 To $TabLevels
            $Tabs &= @TAB
        Next
    EndIf
    If $SpecialLine = 1 Then
        $SpecialLine = 0
        Return StringTrimLeft($Tabs & $sLine, 1)
    Else
        Return $Tabs & $sLine
    EndIf
EndFunc   ;==>_AddRemoveTabLevels

Func _SetTabLevels($sLine)
    $Words = StringSplit($sLine, " ")
    For $i = 1 To $TabAdd[0]
        If $Words[1] = $TabAdd[$i] Then
            For $n = 1 To $TabRem[0]
                If $Words[0] > 1 Then
                    If $Words[$Words[0]] = $TabRem[$n] Then
                        $TabLevels -= 1
                    EndIf
                EndIf
            Next
            $TabLevels += 1
        EndIf
    Next

    For $i = 1 To $TabRem[0]
        If $Words[1] = $TabRem[$i] Then
            If $SpecialLine = 1 Then
                $TabLevels -= 2
                $SpecialLine = 0
            Else
                $TabLevels -= 1
            EndIf
        EndIf
    Next

    For $i = 1 To $TabSpec[0]
        If $Words[1] = $TabSpec[$i] Then
            $SpecialLine = 1
        EndIf
    Next
    If $TabLevels < 0 Then
        $TabLevels = 0
    EndIf
EndFunc   ;==>_SetTabLevels