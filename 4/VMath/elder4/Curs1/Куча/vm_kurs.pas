{��pᮢ�� p���� �� ���᫨⥫쭮� ��⥬�⨪�}
uses Runge,GraphOut,Crt,Graph,Newton,LNewt;
  const
    H=0.05;
  var
    I:Integer;
    NewtonKoef,X:Real;
    Data:TData;
begin
  clrscr;
  NewtonKoef:=MetodNewtona;
  clrscr;
  DobleReCalculate(NewtonKoef, Data);
  clrscr;
  PGraphOut(Data);
  clrscr;
  WriteLn('���� ⮪�:');
  X:=0.05;
  repeat
    WriteLn(PowerOfI(X,0.09,Data):6:5,' - �� X = ',X:3:2);
    X:=X+H;
  until X>=1;
  readLn;
end.