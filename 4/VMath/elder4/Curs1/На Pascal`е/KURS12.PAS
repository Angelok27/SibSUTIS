{$N+}
uses crt, graph;
const eps=0.01;
      y_0=1;
      y_1=0.5;
      rastx=400;
      rasty=200;
type
  typeY=array[1..2] of double;
  TypeC=array[1..4,1..4] of real;
  TypeD=array[1..4] of real;
  TypeMiX=array[0..5] of real;
  typeh=array[1..5] of real;
  TypeProizv=array[0..20] of real;
  typeCProizv=array[0..20,0..20] of real;
var kkk,k:real;
    yy:TypeY;
    EndH:double;
    c: Typec;
    d: typeD;
    m,x,uzels: typeMix;
    h: typeH;
    yp:TypeProizv;
    CCC:typeCProizv;

function FindK:real;
var a,b,k,kt,c,d,h:real;
    i:byte;

  Function f(x:real):real;
  begin
   f:=2*x*x*x-sin(x)-3;
  end;

  Function MPD(a,b:real): real;
  Var
     c:real;
  Begin
    c:=(a+b)/2;
    while abs((b-a)/2)>=eps do begin
      if (f(a)*f(c)<0) then b:=c else a:=c;
      c:=(a+b)/2;
    end;
    mpd:=c;
  end;
begin
  h:=1; c:=-1; d:=1;
  a:=c; b:=a+h;i:=0; k:=10000;
while i<1 do begin
 while b<=d+h do
  begin
    if f(a)*f(b)<0 then
      begin
         kt:=mpd(a,b);
         if (kt<k) and (kt>0) then k:=kt;
         inc(i);
      end;
    a:=b; b:=b+h;
  end;
c:=c-1; d:=d+1; h:=h/2;
end;
findK:=k;
end;


function func(x:double; y:real; y1:real; y2:real):real;
begin
func:=y1+sin(y2)+x*x+y-k*y2-sin(y1);
end;

procedure searchInt(var a:real; var b:real; x:double; y:real; y1:real);
var c,d,h,fa,fb: real;
    i: integer;
begin
c:=-1; d:=1 ;h:=1; a:=c; b:=a+h;
fa:=1; fb:=1;
 while fa*fb>0 do
   begin
   a:=c;b:=a+h;
   fa:=func(x,y,y1,a); fb:=func(x,y,y1,b);
   while b<d do
     begin a:=b;
            b:=b+h;
            fa:=fb;
            fb:=func(x,y,y1,b);
            if fa*fb<0 then break;
      end;
      c:=c-1; d:=d+1; h:=h/2;
   end;
end;


procedure Mh(x:double; y:real; y1:real; var kr:real);
var fa,fb,fc,c,cp,a,b:real;
begin
     searchInt(a,b,x,y,y1);
     fa:=func(x,y,y1,a);fb:=func(x,y,y1,b);
     c:=0; cp:=(fb*a-fa*b)/(fb-fa);
     While (abs(cp-c)>eps) do
      begin
        c:=cp;
        fc:=func(x,y,y1,c);
        if fa*fc<0 then begin b:=c; fb:=fc; end
        else begin a:=c; fa:=fc; end;
        cp:=(fb*a-fa*b)/(fb-fa);
      end;
        kr:=cp;
end;

function Difur(x:double; y:real; y1:real):real;
var a,b,kkk:real;
begin
Mh(x,y,y1,kkk);
difur:=kkk;
end;

procedure ronge_Kutt (x:real; var y:typeY; h:real);

  procedure largeF (x:real;lY:typey;var lF:typey);
  begin
    lF[1]:=lY[2];
    lF[2]:=difur(x,lY[1],lY[2]);
  end;
  procedure mul (a:real;b:typeY;var c:typey);
  begin
    c[1]:=a*b[1]; c[2]:=a*b[2];
  end;
  procedure add (a,b:typey;var c:typey);
  begin
    c[1]:=a[1]+b[1]; c[2]:=a[2]+b[2];
  end;

Var
  lF,lFnew,t,tt:typey;
begin

   largeF(x,Y,lF);
    mul(h,lF,t);
    add(Y,t,tt);
   largeF(x+h,tt,lFnew);
   add(lF,lFnew,t);
   mul(h/2,t,tt);
   add(Y,tt,t);
   y:=t;
end;



procedure DoublePereschet(var Yb:typeY; kr:real);
var hh, xi:double;
    Yh,Yh_2:TypeY;
    i: integer;
begin
hh:=0.05;
xi:=0;
yh[1]:=y_0;
yh[2]:=kr;
yh_2:=yh;
While (xi<1) do
  begin
  Ronge_Kutt(xi,Yh,hh);
  Ronge_Kutt(xi,Yh_2,hh/2);
  Ronge_Kutt(xi+hh/2,Yh_2,hh/2);

  if (abs(Yh[1]-Yh_2[1])>3*eps) then
     begin
       hh:=hh/2;
       xi:=0;
       yh[1]:=y_0;
       yh[2]:=kr;
       yh_2:=yh;
     end else xi:=xi+hh;
end;
endH:=hh/2;
yb:=yh_2;
writeln(' y(1)=', yh_2[1]:10:10,'     y1(1)=',yh_2[2]:10:10);
end;

procedure searchInt1(var a:real; var b:real);
var c,d,h:real;
    ya:TypeY; t:boolean;
begin
a:=-2; h:=0.5; b:=-1.5;
doublePereschet(ya,a);
if ya[1]<y_1 then t:=true else t:=false;
while (t=(ya[1]<y_1)) do
   begin
     if ya[1]<y_1 then begin t:=true; a:=b; b:=b+h; end else begin t:=false; b:=a; a:=a-h; end;
     doublePereschet(ya,a);
   end;
   b:=a; a:=a-h;
end;

procedure strelba;
var  a,b,c,t:real;
     ya,yb,yc:TypeY;
Begin
  writeln(' ���� ���ࢠ�� :');
  searchInt1(a,b);
  writeln(' a= ',a:2:2,' b= ',b:2:2);
  DoublePereschet(ya,a);DoublePereschet(yb,b);
  repeat
    c:=(a+b)/2;
    DoublePereschet(yc,c);
    if ((ya[1]-y_1)*(yc[1]-y_1))<0 then begin b:=c; yb:=yc;  end else begin a:=c; ya:=yc; end;
  until (abs(y_1-yc[1])<eps);
 kkk:=c;
 writeln('��襭�� �ࠥ��� ����� k=y1(0)===',kkk:10:10);
end;

Procedure ZapolnX;
var i:integer;
begin
 for i:=0 to 5 do x[i]:=0.2*i;
end;

procedure podschet_H;
 var i :integer;
   begin
      for i:=1 to 5 do
      h[i]:=abs(x[i]-x[i-1]);
   end;

procedure zapoln_C;
 var i: integer;
  begin
     for i:=1 to 4 do
       begin
          if (i-1)<>0 then c[i,i-1]:=h[i]/6;
          c[i,i]:=(h[i]+h[i+1])/3;
          if i<>(4) then c[i,i+1]:=h[i+1]/6;
       end;
  end;
procedure zapoln_D;
 var i: integer;
   begin
      for i:=1 to 4 do
       d[i]:=((uzels[i+1]-uzels[i])/h[i+1])-((uzels[i]-uzels[i-1])/h[i]);
   end;

function spline(xx:real):real;
 var i:integer;
     s: real;
  begin
     for i:=1 to 5 do
        if (xx>=x[i-1])and(xx<=x[i]) then break;

     s:=m[i-1]*(x[i]-xx)*(x[i]-xx)*(x[i]-xx)/(6*h[i])
        +m[i]*(xx-x[i-1])*(xx-x[i-1])*(xx-x[i-1])/(6*h[i])
        +(uzels[i-1]-(m[i-1]*h[i]*h[i]/6))*((x[i]-xx)/h[i])
        +(uzels[i]-(m[i]*h[i]*h[i]/6))*((xx-x[i-1])/h[i]);
     spline:=s;
  end;

procedure hod_pr(var c:TypeC; var d:typeD);
 var  b     :real;
      l,i,j :integer;
  begin
     for i:=1 to 3 do
         begin
              for j:=i+1 to 4 do
                  begin
                       b:=c[j,i]/c[i,i];
                       for l:=i to 4 do c[j,l]:=c[j,l]-c[i,l]*b;
                       d[j]:=d[j]-d[i]*b;
                  end;
         end
  end;

procedure back(c:typeC; d:typeD; var m:typeMiX);
 var i,j:integer;
  begin
    for i:=4 downto 1 do
        begin
             m[i]:=d[i];
             for j:=4 downto i+1 do m[i]:=m[i]-c[i, j]*m[j];
             m[i]:=m[i]/c[i, i];
        end;
    m[0]:=0; m[5]:=0;
    for i:=0 to 5 do
        writeln('m[',i,']= ',m[i]:8:4);
    writeln;
  end;

procedure graphik;
 var i:double; j,gm,gd: integer;
     yy:Typey;
     oy,ox:integer;
  begin
     gm:=0; gd:=0;
     initgraph(gm,gd,'c:\tp7\bgi');
     cleardevice;
     settextstyle(7,0,3);
     outtextxy(170,50,'�p�䨪 �㭪樨 �������� �� ��');
     setcolor(green);
     outtextxy(190,100,'� ���௮�����饩 �㭪樨');

     ox:=20;
     oy:=470;
     uzels[0]:=y_0;
     j:=1;
     yy[1]:=y_0;
     yy[2]:=kkk;

    setcolor(white);
    line(ox,0,ox,480);
    line(0,oy,640,oy);

    i:=0;
    moveto(round(i*rastx)+ox,oy-round(y_0*rasty));
    while i<=1 do
       begin
         ronge_Kutt(i,yy,endh);
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(yy[1]*rasty));
         if round(i*10000000)=round(2000000*j) then
           begin
              uzels[j]:=yy[1];
              inc(j);
           end;
       end;
    readkey;
    zapolnX;
    podschet_H;
    zapoln_C;
    zapoln_D;
    hod_pr(c,d);
    back(c,d,m);
    setcolor(2);
    i:=0;
    moveto(round(i*rastx)+ox,oy-round(Spline(i)*rasty));
    while i< 1.1 do
       begin
         i:=i+endh;
         lineto(round(i*rastx)+ox,oy-round(Spline(i)*rasty));
       end;

    setcolor(white);
    for j:=0 to 5 do
      circle(round((j/5)*rastx)+ox,oy-round(uzels[j]*rasty),3);
   readkey;
   closegraph;

  end;

procedure podschetCCC;
 var i,j:integer;
     x:real; yy:Typey;
 begin

 x:=0; i:=1;
 ccc[0,0]:=kkk;
 yy[1]:=y_0;
 yy[2]:=kkk;
  while x<1-endh do
     begin
        ronge_kutt(x,yy,endh);
        x:=x+endh;
        if round(x*10000)=round(500*i) then begin CCC[i,0]:=yy[2]; inc(i); end;
     end;

     for i:=1 to 20 do
       for j:=20-i downto 0 do
         CCC[j,i]:=ccc[j+1,i-1]-ccc[j,i-1];
 end;

function nuton(x:real; h:real):real;
 var  i,j   :integer;
     fuck   :double;
     q,qq,p :double;
  begin
      fuck:=1;
      q:=(x)/h;
      qq:=q;
      p:=ccc[0,0];

      for i:=1 to 20 do
        begin
          p:=p+(ccc[0,i]*qq)/fuck;
          qq:=qq*(q-i);
          fuck:=fuck*(i+1);
        end;
      nuton:=p;
  end;
procedure vivodSilaToka;
var x: real; i:byte;
begin
 clrscr;
 writeln('���� ⮪� � ������� �६���');
 x:=0.05;
 while x<1 do
   begin
    writeln('���� ⮪�(',x:1:2,')=  ',Nuton(x,0.05):10:10);
    x:=x+0.05;
   end;
end;

procedure print;
var i,j:integer;
begin
  for i:=0 to 20 do begin
   for j:=0 to 9 do write(ccc[i,j]:7:4);
   writeln;
   end;
end;
procedure vivod;
var i: integer;
    yy: typeY;
    x:double;
begin
  clrscr;
  x:=0;
  yy[1]:=y_0;
  yy[2]:=kkk;
  i:=1;
  writeln('y(',x:2:2,')= ',yy[1]:10:9,'   ','y1(',x:2:2,')= ',yy[2]:10:9,'   ','Spline(',x:2:2,')= ',Spline(x):10:9);
    while x<=1 do
       begin
         ronge_Kutt(x,yy,endh);
         x:=x+endh;
         if round(x*10000000)=round(500000*i) then
           begin
             writeln('y(',x:2:2,')= ',yy[1]:10:9,'   ','y1(',x:2:2,')= ',
             yy[2]:10:9,'   ','Spline(',x:2:2,')= ',Spline(x):10:9);
             inc(i);
           end;
       end;
    readkey;

end;

var i: integer;
begin
clrscr;
writeln;
k:=findk;
writeln('��襭�� ��������� �ࠢ����� k===== ',k:10:10);
writeln(' ���� ����� ��⮤� ��५�....');
strelba;
writeln('������ H ᮮ⢥�����騩 �筮�� = ',endh:10:10);
writeln('Press any key...');
readkey;
graphik;
clrscr;
PodschetCCC;
VivodSilaToka;
readkey;
vivod;
end.
Read:
��襭�� ����ਭ樠�쭮�� �ࠢ����� ��稭����� � �ࠥ��� �����.
�����⭮ : �㭪�� � �窥 0 � �㭪�� � �窥 1, ��� �㦭�
��� �襭�� ���. �ࠢ����� �ந������� ��ࢠ� � �窥 0.
��� ⮣� �⮡� �� ���� �ᯮ������ ��⮤ ��५�.
�� �� �㤨 � ���� ���ਬ�� ��⮤ ����������� �������. �㦭� ��������
⠪�� ����� �ந������� � �窥 0 �⮡� �� ����⠭���� � ��� �ࠢ�����
�㭪�� � �窥 1 �뫠 = 0.2. �� � ������ ��⮤ ��५�.
��⮤ ��५� ����⠢��� ����� �ந������� � �窥 0 � Doublepereschet
����� �����頥� ���祭�� �㭪樨 � ���祭�� �ந������� � �窥 1 �
�ࠢ������ � 0.2 �.� � ��砫�묨 �᫮��ﬨ.

������� ������ ��⠥� ���祭�� �㭪樨 � �ந������� � 蠣�� h � h/2
�� 0 �� 1 � �ࠢ�������� �� �筮��. ���� ���祭�� � �窠�
������� ������ ��뢠�� ��⮤ Ronge_kutt � ���������� ������ 蠣 �
���஬ ���⨣����� �筮���.
��⮤ ஭�� ���� �뤠�� y y1 � �窥 x+h � ����⠢����묨 ��ࠬ��ࠬ�
x y y1,
��⮤ ஭��-���� �ᯮ���� ���祭�� ��ன �ந�������, ���஥ �뤠��
Difur, �� ���� �ந������� ������ �� �
���⮬� �㭪�� Difur �蠥� ��⮤�� �� �ࠢ�����, ��� �������⭮� ����
���� �ந�������.
� �⮣� ������� ���祭�� �ந������� � �窥 0 � ���஥ �㦭�;
����⠢��� �� ���祭��, ⮥��� ��砫�� ��ࠬ���� � Ronge-Kutt
����砥��� ���祭�� �㭪樨 � ࠧ����� �窠�. ���祭�� �
�窠� i*0.2 ��� i=0..5 ������������ � ���ᨢ� � ����� �ᯮ������
���筠� ���௮���� ᯫ�����.

��� ��宦����� ���� ⮪� ���������� ����� ��� ⠪�� ��� � � ���௮��樨
���⮭��, �� ���祭�ﬨ �ந������� � �窠� � 蠣�� 0.05.
������ ᤥ���� ⠪ �� ���௮������� �ந������� �� ���⮭� � ���
����� �������� ���祭�� �ந������� � �� �窥.
�� ���� ᯮᮡ ���᫥��� �ந������� : ��᫥��� ����ਭ�஢���.
������ ���� ���祭�� �㭪樨 � �᫥��� ����ਭ�஢���.
�� �� ����⭮ ����� ᯮᮡ�� �㦭� ������.
�� ᤥ��� �뢮� ���祭�� �㭪樨, �ந�������, � ������� � 蠣�� 0.05.
�� ᤠ� ���ᮢ��� �� ���筮 �ॡ����.
