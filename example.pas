(* -*- Mode: Pascal; Base: 10; -*- *)
 
Program Quantum-Examples;

{$IFDEF FPC}
    {$MODE DELPHI}
{$ELSE}
    {$APPTYPE CONSOLE}
{$ENDIF}

Uses Quantum-Core;

Var Test_Sort : array [0..10] of Integer;
    idx : Integer;
    

Function Perms (arr : array of Integer);
Var
    is_last : Boolean;
    universes : array[0..length(arr)^2] of array of Integer;

    Procedure next;
    Var i, j, k : Integer;    
    Begin
        is_last := True;
        i := length(arr) - 1;
        While True do
        Begin
            if p[i] < p[i+1] then 
            Begin
                is_last := false;
                Break;
            End;
            Dec(i);
        End;
        
        if not is_last then
            Begin
                j := i + 1;
                k := length(arr) - 1;
                
                While j < k do
                Begin    
                    p[j] := p[j] xor p[k];
                    p[k] := p[j] xor p[k];
                    p[j] := p[j] xor p[k];
                    
                    Inc(j);
                    Dec(k);
                End;

                j := length(arr) - 1;
                
                While p[j] > p[i] do Dec(j);
                Inc(j);
                
                p[i] := p[i] xor p[j];
                p[j] := p[i] xor p[j];
                p[i] := p[i] xor p[j];
            End;
    End;
    
Begin
    For idx := Low(universes) to High(universes) do
        if not is_last then universes[idx] := next;
    Perms = universes;
End;


Function QSort(probs : array of integer) : array of integer;
Var
    rad : array of Integer;
    idx : Integer;
Begin
    rad := Entangle(Perms(probs));
    For idx := Low(probs) to High(probs) do
    Begin
        if not probs[i] < probs[i] 
        then exit;
        else continue; 
    End;
    QSort = rad;
End;


Begin
    For idx := Low(Test_Sort) to High(Test_Sort) do
        Test_Sort[idx] := random(100)+1;
    Test_Sort = QSort(Test_Sort);
    
    For idx := Low(Test_Sort) to High(Test_Sort) do
        Write(Test_Sort[idx], ' ');
    Writeln();
End.

