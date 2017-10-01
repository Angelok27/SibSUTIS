program job_kurs;
{������祭�� ,������⥪ }
uses   crt, graph;
{ ��।������ ⨯�� }
type  vectorY = array [0..1] of real;
{ ��।������ ����⠭�}
const
     BGI = 'd:\bp\bgi';
     h = 0.01;
     e = 1e-4;
     { H�砫�� �᫮���  }
     nachY = 1;
     konY  = 0;
     nachX = 0;
     konX  = 0.5;
var
   { ��६���� ��� ���. �ࠢ����� }
     masY : array [0..100] of VectorY;
{opisanie peremennix }

{ �襭�� ���. �ࠢ����� }
procedure resh_Dif;
var
   x, k : real;
   i : integer;
   Y, ResY : VectorY;
   a, b : real;

  { ���᫥��� ResY �� ������� y,y' � x }
  procedure FunF(x : real; Y : VectorY; var ResY : VectorY);
    { yravnenie for reshenia ���. ��-�� }
    function dY2(y2 : real) : real;
    begin
      dY2 := y2 - sin(y2) -  cos(Y[0]) - k*Y[1] - exp(-x);
    end;

    { ���� ���ࢠ�� ᬥ�� ����� ��� �㭪樨 dY2 }
    procedure searchInt(var a, b : real);
    const
         shift = 0.1; { 蠣 }
    begin
      while (true) do
        begin
          { �᫨ �-�� ����� ���� �� ���ࢠ�� a;b - ���뢠�� 横� }
          if dY2(a)*dY2(b) < 0 then break;
          a := b;
          b := b + shift;
        end;
    end;

    { ���� y'' ��⮤�� �� }
    function CountY2 : real;
    var
       lB, rB, C, C2 : real;
    begin
      lB := - 15;
      rB := - 14;

      { ���� ���ࢠ�� }
      searchInt(lB,rB);

      repeat
        C := (dY2(rB)*rb - dY2(lB)*lb) / (dY2(rB) - dY2(lB));
        if (dY2(lB)*dY2(C) > 0)
          then lB := C
          else rB := C;
        C2 := (dY2(rB)*lB - dY2(lB)*rB) / (dY2(rB) - dY2(lB));
      until (abs(C2 - C) < e);

      CountY2 := C;
    end;

  begin
    ResY[0] := Y[1];
    ResY[1] := CountY2;
  end;

  { ���᫥��� �����-�襭�� �� ������� x, Y � h }
  procedure kungerut4(x : real; Y : VectorY; var ResY : VectorY; h : real);
  var
     k : array [1..4] of VectorY;
     tmp : VectorY;
  begin
    { ����塞 ����-� k }
    FunF(x,Y,k[1]); { k1 }
    tmp[0] := Y[0] + h/2 * k[1][0];

    tmp[1] := Y[1] + h/2 * k[1][1];
    FunF(x+h/2,tmp,k[2]); { k2 }
    tmp[0] := Y[0] + h/2 * k[2][0];
    tmp[1] := Y[1] + h/2 * k[2][1];
    FunF(x+h/2,tmp,k[3]); { k3 }
    tmp[0] := Y[0] + h * k[3][0];
    tmp[1] := Y[1] + h * k[3][1];
    FunF(x+h,tmp,k[4]); { k4 }

    { ����塞 १���� }
    ResY[0] := Y[0] + h/6 * (k[1][0] + 2*k[2][0] + 2*k[3][0] + k[4][0]);
    ResY[1] := Y[1] + h/6 * (k[1][1] + 2*k[2][1] + 2*k[3][1] + k[4][1]);
  end;

  { ���᫥��� �����-�襭�� �� ������� x, Y � h � ������ �����⮬ }
  procedure CountY(x : real; Y : VectorY; var ResY : VectorY; h : real);
  var
     Res1, Res2 : VectorY;
     step : real; { 蠣 }
     i, count : integer;
     aY : array [1..100] of VectorY;
     IsHalt : boolean; { 䫠� ��室� �� ������� ������ }
  begin
    step := h;
    count := 1;
    IsHalt := false;

    while (IsHalt = false) do
      begin
        {WriteLn('h = ',step:4:4,'; ');}
        ResY := Y;
        { ���᫥��� � 蠣�� h � ����ᥭ��� १���⮢ � ���ᨢ }
        for i := 1 to count do
          begin
            kungerut4(x+(step)*(i-1),ResY,ResY,step);
            aY[i] := ResY;
          end;
        Res1 := ResY;
        ResY := Y;
        IsHalt := true;
        { ���᫥��� � 蠣�� h/2 � �஢�મ� �� �筮��� ���᫥���� ���祭�� }
        for i := 1 to count*2 do
          begin
            kungerut4(x+(step/2)*(i-1),ResY,ResY,step/2);
            if ((i mod 2) = 0) then
              begin
                if (abs(aY[i div 2][0] - ResY[0]) > 15*e) or
                   (abs(aY[i div 2][1] - ResY[1]) > 15*e)
                  then IsHalt := false;
              end;
          end;
        Res2 := ResY;
        { �᫨ �� ���⨣�� �筮�� - ����� 蠣 ������� }
        if (IsHalt = false) then
          begin
            {Write('y(',(x+h):6:6,') = ',ResY[0]:6:6,'; ');
            WriteLn('y''(',(x+h):6:6,') = ',ResY[1]:6:6);}
            step := step / 2;
            count := count * 2;
          end;
      end;
  end;

  { ���᫥��� ����-� k (�� y' � ���. ��-��) }
  function Kaf : real;
    { �-�� �પ�ᨭ�� }
    function arccos(x : real) : real;
    begin
      if (x = 1) then arccos := 0
        else if (x = -1) then arccos := Pi
          else arccos := ArcTan(x / sqrt(1 - x*x));
    end;

    { �ࠢ����� }
    function FunK(x : real) : real;
    begin
      FunK := 4*x*x*x*x*x - arccos(x) - 1;
    end;

    { ���� ���ࢠ�� ᬥ�� ����� ��� FunK }
    procedure FindInterval(var a, b : real);
    const
         shift = 0.1;
    begin
      while (true) do
        begin
          if FunK(a)*FunK(b) < 0 then break;
          a := b;
          b := b + shift;
        end;
    end;

  var
     lB, rB, olB, orB, C, C2 : real;
  begin
    lB := -1;
    rB := 0;

    repeat
      { ���� ���ࢠ�� }
      FindInterval(lB,rB);

      { ��⮤ �� }
      repeat
        if ((FunK(rB) - FunK(lB)) = 0) then begin C := -9999; break; end;
        C := (FunK(rB)*lB - FunK(lB)*rB) / (FunK(rB) - FunK(lB));
        if (FunK(lB)*FunK(C) > 0)
          then lB := C
          else rB := C;
        C2 := (FunK(rB)*lB - FunK(lB)*rB) / (FunK(rB) - FunK(lB));
      until (abs(C2 - C) < e);
    until (C > 3);

    { �����頥� १���� - ���᫥��� ����-� k }
    kaf := C;
  end;

  { �-�� ���᫥��� �����-�襭�� � ����筮� �窥 (��� �-�� ��५�) }
  procedure CountEndY(y1 : real; var rY : VectorY);
  var
     tY, trY : VectorY;
     i : integer;
     x : real;
  begin
    x := nachX;
    tY[0] := nachY;
    tY[1] := y1;

    { ������ 10 蠣�� ��� ��宦����� �����-�襭�� � ����筮� �窥 }
    for i := 1 to 10 do
      begin
        CountY(x,tY,trY,h*5);
        x := x + h*5;
        tY := trY;
      end;

    rY := tY;
  end;

  { �-�� ���᪠ ���ࢠ�� � ��⮤� ��५� }
  procedure FindInterval(var a, b : real);
  const
       shift = 0.5;
  var
     rYa, rYb : VectorY;
  begin
    a := -3;
    b := a + shift;

    WriteLn('���� ���p���� ��� k:');

    while (true) do
      begin
        WriteLn('[',a:5:5,';',b:5:5,']');
        CountEndY(a,rYa);
        CountEndY(b,rYb);
        if ((rYa[1] <= konY) and (rYb[1] >= konY)) then break;
        a := b;
        b := a + shift;
      end;
  end;

  { ��宦����� k � ��⮤� ��५� � �������� �筮���� }
  function FindY1(a, b : real) : real;
  var
     rYa, rYt : VectorY;
     c : real;
  begin
    repeat
      { ��⮤ ����������� ������� }
      c := (a + b) / 2;

      Writeln('[ ',a:5:5,';',c:5:5,' ]');
      CountEndY(a,rYa);
      CountEndY(c,rYt);
      {WriteLn(' - Y[',rYa[0]:5:5,';',rYt[0]:5:5,']');}
      if ((rYa[1] >= konY) and (rYt[1] <= konY))
        then b := c
        else a := c;
    until (abs(rYt[1]-konY)  < e);
    writeln('Y''(0) = ',c:3:5);
    FindY1 := c;
  end;


begin
  ClrScr;
  WriteLn(' P�襭�� ���. �p� ');

  k := kaf;
  WriteLn('k = ',k:4:5);
  WriteLn('��⮤ ��p���');
  FindInterval(a,b);

  x := nachX;
  Y[0] := nachY;
  WriteLn('H�宦�����   Y''(0))');
  Y[1] := FindY1(a,b);
  masY[0] := Y;
  readln;
  WriteLn('��襭�� ���.�� � 100 �窠�');
  for i := 1 to 100 do
    begin
      CountY(x,Y,ResY,h);
      x := x + h;
      Y := ResY;
      masY[i] := Y;
      if i mod 10 = 0 then
      Writeln('X = ',x:3:2,'  Y = ',Y[0]:3:3,'; ');
    end;
  WriteLn;
  readln;
end;
{************************************}


{  ���௮���� ᯫ�����}
procedure splaina;
const
     STEP = 0.2; { 蠣 ���௮��樨 }
     kN = 6; { ������⢮ �祪 ���௮��樨 }
var
   { ��६���� ��� ��䨣� }
   grDriver, grMode, result : integer;
   { ��६���� ��� ���᫥��� ���祭�� }
   x, y : real;
   i, j, k : integer;
   aY : array [0..kN-1] of real;
   aX : array [0..kN-1] of real;
   { ������ ���᫥��� ��� ᯫ���� }
   C  : array [1..kN-2,1..kN-1] of real;
   M  : array [0..kN-1] of real;
   { �६���� ��६���� }
   ch : char;
   tmpStr, tmpStr2, tmpStr3 : string;

  { ���᫥��� ������ C (��� ᯫ����) }
  procedure CountM;
  var
     i, j, k : integer;
     t : real;
  begin
    { ᮧ���� ����� d }
    for i := 1 to kN-2 do
      begin
        C[i,kN-1] := (aY[i+1]-aY[i])/(aX[i+1]-aX[i]) -
          (aY[i]-aY[i-1])/(aX[i]-aX[i-1]);
      end;

    { ᮧ���� ������ C }
    for i := 1 to kN-2 do
      for j := 1 to kN-2 do
        begin
          if (i = j) then C[i,j] := (aX[i]-aX[i-1]+aX[i+1]-aX[i])/3;
          if (j = (i+1)) then C[i,j] := (aX[i+1]-aX[i])/6;
          if (j = (i-1)) then C[i,j] := (aX[i]-aX[i-1])/6;
          if (abs(j-i) > 1) then C[i,j] := 0;
        end;

    { ����塞 ����� M }
    for k := 1 to kN-2-1 do
      begin
        for i := 1+k to kN-2 do
          begin
            t := C[i,k]/C[k,k];
            for j := k to kN-1 do
              begin
                C[i,j] := C[i,j] - C[k,j]*t;
              end;
          end;
      end;
    for k := 1 to kN-2 do
      begin
        t := 0;
          for i := 1 to k-1 do
            begin
              t := t + M[kN-2+1-i]*C[kN-2+1-k,kN-2+1-i];
            end;
        M[kN-2+1-k] := (C[kN-2+1-k,kN-1] - t) /
                          C[kN-2+1-k,kN-2+1-k];
      end;

    M[0] := 0;
    M[kN-1] := 0;
  end;

  { �-�� ���௮��樨 ᯫ����� }
  function G(x : real) : real;
  var
     i, j, k : integer;
     Res : real;
  begin
    { �롨ࠥ� i }
    i := 1;
    for j := 1 to kN-1 do
      if (x >= aX[i-1]) and (x <= aX[i])
        then break
        else if (i < (kN-1)) then inc(i);

    { ����塞 Si(x) }
    Res := M[i-1]*(aX[i]-x)*(aX[i]-x)*(aX[i]-x)/(6*(aX[i]-aX[i-1]));
    Res := Res + M[i]*(x-aX[i-1])*(x-aX[i-1])*(x-aX[i-1])/(6*(aX[i]-aX[i-1]));
    Res := Res + (aY[i-1]-M[i-1]*(aX[i]-aX[i-1])*(aX[i]-aX[i-1])/6)*
           (aX[i]-x)/(aX[i]-aX[i-1]);
    G := Res + (aY[i]-M[i]*(aX[i]-aX[i-1])*(aX[i]-aX[i-1])/6)*
           (x-aX[i-1])/(aX[i]-aX[i-1]);
  end;

begin
  { ���ᨢ �祪 ���௮��樨 }
  aX[0] := 0.0; aY[0] := masY[0][0];
  aX[1] := 0.2; aY[1] := masY[20][0];
  aX[2] := 0.4; aY[2] := masY[40][0];
  aX[3] := 0.6; aY[3] := masY[60][0];
  aX[4] := 0.8; aY[4] := masY[80][0];
  aX[5] := 1.0; aY[5] := masY[100][0];

  { ���樠������ ���. ०��� }
  grDriver := Detect;
  InitGraph(grDriver,grMode,bgi);
  SetBkColor(0);

  { �஢�ઠ १���� }
  result := GraphResult;
  if result = grOk then
    begin
        Line(40,40,40,440);
        Line(40,440,600,440);


            OutTextXY(0,0,' Spline');
            { ���� � �뢮� ᯫ���� }
            CountM;
            x := 0;
            y := G(x);
            MoveTo(round(40+x*500),round(440-y*300));
            for i := 1 to 100 do
              begin
                x := x + 0.01;
                y := G(x);
                LineTo(round(x*500+40),round(440-y*300));
              end;



            x := 0;
            y := masY[0][0];
            MoveTo(round(40+x*500),round(440-y*300));
            for i := 1 to 100 do
              begin
                x := x + h;
                y := masY[i][0];
                LineTo(round(40+x*500),round(440-y*300));
              end;
              repeat until keypressed;
        ClearDevice;
        CloseGraph;

      ClrScr;
      WriteLn('����� x, y � G :');
        x := 0;
        i := 0;
        while (x <= (konX+h)) do
          begin
            Str(masY[i][0]:5:5,tmpStr);
            Str(G(x):5:5,tmpStr3);
            Str(x:2:2,tmpStr2);
            WriteLn('x=',tmpStr2,' y=',tmpStr,' G=',tmpStr3);
            x := x + h*5;
            inc(i,5);
          end;

      repeat until KeyPressed;
    end
    else
    begin
      { �᫨ �訡�� }
      WriteLn('Graphics error:',GraphErrorMsg(result));
      ReadLn;
    end;
end;
{************************************}


{���᫥��� ��⥣ࠫ� �� �. ����ᮭ�}
  function IntegralSimpson:real;
  const
       a = 0;
       b = 0.5;
       k = 100;
       h = 0.01;
  var
     s:real;
     i:integer;
  begin
    s := a+b;
    { ���᫥��� �㬬� }
    for i := 1 to 100 do
      if i mod 2 = 0 then  s:= s + 2*sqr(masY[i,0])
      else s:= s + 4*sqr(masY[i,0]);
    { 㬭������ �� ����. }
    s:=s*h/3;
    IntegralSimpson := s;
  end;
{************************************}

{==============������� �ணࠬ�� ================}
BEGIN
clrscr;
resh_Dif;
splaina;
clrscr;
writeLn('��⥣ࠫ = ',IntegralSimpson:8:8,#10#13);
readln;
END.
{================================================}