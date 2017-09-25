(* -*- Mode: Pascal; Base: 10; -*- *)

Unit QCore;

Interface

{$IFDEF FPC}
    {$MODE DELPHI}
{$ELSE}
    {$APPTYPE CONSOLE}
{$ENDIF}

{$IFDEF Linux}
    {$DEFINE Unix}
{$ENDIF}

Uses BaseUnix, Dos, math;

Type PQArr = array of LongInt;


Function Collapse (ch : PQArr) : Integer;
Function Entangle (un : PQArr) : Integer;


Implementation 


Function Collapse (ch : PQArr) : Integer;
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

    Collapse := pid div trunc(sqrt(pid / phi + hsec * phi / log2(sec)))
End;

Function Entangle (un : PQArr) : Integer;
Var 
    idx : Integer;
    pid : TPid;
Begin
    For idx := Low(un) to High(un) do
    Begin
        pid := FpFork();
        if pid = 0 
        then Entangle := un[idx]
        else exit(fpWait(pid) >> 8);
            
    End;
End;

End.
