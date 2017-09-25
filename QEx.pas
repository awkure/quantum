(* -*- Mode: Pascal; Base: 10; -*- *)
 
Program QEx;

{$IFDEF FPC}
    {$MODE DELPHI}
{$ELSE}
    {$APPTYPE CONSOLE}
{$ENDIF}

{$IFDEF Linux}
    {$DEFINE Unix}
{$ENDIF}

Uses QCore;

Var Test_Sort : array [1..1000] of LongInt;
    idx : Integer;
   
Function QPerms(universes: PQArr) : PQArr;
    Var pos, dir, sz : Integer;
    Procedure swap(arr: array of Integer; f, t: Integer);
    Begin
        arr[f] := arr[f] xor arr[t];
        arr[t] := arr[t] xor arr[f];
        arr[f] := arr[f] xor arr[t];
    End;
Begin
    pos := 1; dir := 1; sz := length(universes);
    if pos >= sz 
    then 
        Begin
            dir := ((not dir) xor dir) * dir; (*?*)
            swap(universes, 1, 2);
        End
    else if pos < 1 
    then
        Begin
            dir := ((not dir) xor dir) * dir; (*?*)
            swap(universes, sz-1, sz);
        End
    else
        swap(universes, pos, pos+1);
    pos := pos + dir;
    QPerms := universes;
End;


Procedure QSort(probs : PQArr);
Var
    idx : Integer;
    prs : PQArr;
Begin
    prs := QPerms(probs);
    probs := Entangle(prs);
    For idx := Low(probs) to High(probs) do
    Begin
        if not probs[idx] < probs[idx+1] 
        then exit
        else continue; 
    End;
End;


Begin
    For idx := Low(Test_Sort) to High(Test_Sort) do
        Test_Sort[idx] := random(100)+1;
    Test_Sort := QSort(Test_Sort);
    
    For idx := Low(Test_Sort) to High(Test_Sort) do
        Write(Test_Sort[idx], ' ');
    Writeln();
End.

