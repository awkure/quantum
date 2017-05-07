(* -*- Mode: Pascal; Base: 10; -*- *)

Unit Quantum-Core;

interface

{$IFDEF FPC}
    {$MODE DELPHI}
{$ELSE}
    {$APPTYPE CONSOLE}
{$ENDIF}

Uses BaseUnix;


Function Collapse (ch : array of Integer) : Integer;
Function Entangle (un : array of Integer) : Integer;


Implementation 

Function Collapse (ch : array of Integer) : Integer;
Var 
    idx : Integer;
    phi : Real;
    pid : TPid;
    hour, min, sec, hsec : Word;
Begin
    GetTime(hour, min, sec, hsec);

    pid := fpgetpid;
    if pid = -1 then exit;
    
    phi := 0;
    For idx := Low(ch) to High(ch) do
        phi += sqrt(100 / ch[idx]);

    Collapse = pid div sqrt(pid / phi + hsec * phi / log2(sec)) 
End;

Function Entangle (un : array of Integer) : Integer;
Var 
    idx : Integer;
    pid : TPid;
Begin
    For idx := Low(un) to High(un) do
    Begin
        pid := FpFork();
        if pid = 0 
        then Entangle = un[idx];
        else exit(fpWaitPid(pid, WNOHANG) >> 8);
    End;
End;

End.
