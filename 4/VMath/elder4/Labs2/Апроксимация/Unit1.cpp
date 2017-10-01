//---------------------------------------------------------------------------

#include <vcl.h>
#pragma hdrstop
#include <stdio.h>

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------
double g(int x, int act){
	switch(act){
		case 0: return 1;
		case 1: return x;
		case 2: return x*x;
	}
	return -1;
}
//---------------------------------------------------------------------------
double fnc(double x, double a0,double a1, double a2){
	return a0+a1*x+x*x*a2;
}
//---------------------------------------------------------------------------
void __fastcall TForm1::Button1Click(TObject *Sender)
{
	double x[30], y[30], mat[3][3], b[3], a[3], y2[30], koof, bo, max,min;
	int i, j, k, n, s=3;
	FILE *f;

	memset(mat, 0, sizeof(double)*s*s);//��������� �������
	memset(b, 0, sizeof(double)*s);//��������� �������
	memset(y2, 0, sizeof(double)*30);//��������� �������

	Memo1->Clear();

	if((f=fopen("table.txt", "r"))==NULL)Abort();
	//������ �� �����
	fscanf(f, "%d", &n);
	for(i=0; i<n; i++){
		fscanf(f, "%lf", &x[i]);
		fscanf(f, "%lf", &y[i]);
		Chart1->Series[1]->AddXY(x[i], y[i]);
	}
	fclose(f);

	//����� ��������� ��������
	Memo1->Lines->Add("X    Y");
	for(i=0; i<n; i++)Memo1->Lines->Add(FloatToStr(x[i])+"   "+FloatToStr(y[i]));

	//������ b
	for(i=0; i<s; i++)
		for(j=0; j<n; j++)b[i]+=g(x[j], i)*y[j];

	//���������� �������
	Memo1->Lines->Add("");
	Memo1->Lines->Add("�������� �������");
	for(i=0; i<s; i++){
		for(j=0; j<s; j++)
			for(k=0; k<n; k++)mat[i][j]+=g(x[k], i)*g(x[k], j);
		Memo1->Lines->Add(FloatToStr(mat[i][0])+"  "+FloatToStr(mat[i][1])+"  "+FloatToStr(mat[i][2])+" | "+FloatToStr(b[i]));
	}

	//������� ������� ������� �����
	/*������ ��� ������� �������*/
	for(i=0; i<s-1; i++)
		for(j=i+1; j<s; j++){
			koof=mat[j][i]/mat[i][i];/*������ �����������*/
			for(k=i;k<s;k++)mat[j][k]-=mat[i][k]*koof;
			b[j]-=b[i]*koof;
	}

	/*����� ������� ��c�� �������*/
	Memo1->Lines->Add("");
	Memo1->Lines->Add("�������� �������");
	for(i=0;i<s;i++)
		Memo1->Lines->Add(FloatToStr(mat[i][0])+"  "+FloatToStr(mat[i][1])+"  "+FloatToStr(mat[i][2])+" | "+FloatToStr(b[i]));

	/*�������� ���. ������ �����*/
	for(i=s-1;i>=0;i--){
		for(j=i+1;j<s;j++)b[i]=b[i]-a[j]*mat[i][j];
		a[i]=b[i]/mat[i][i];/*������ ����*/
	}

	Memo1->Lines->Add("");
	for(i=0;i<s;i++)Memo1->Lines->Add("a"+IntToStr(i)+"="+FloatToStr(a[i]));
        min=x[0];
        max=x[0];
        for(i=0; i<n; i++){
                if(min>x[i])min=x[i];
                if(max<x[i])max=x[i];
        }
        Memo1->Lines->Add("min="+FloatToStr(min)+" max="+FloatToStr(max));
	bo=min;
	do{
		Chart1->Series[0]->AddXY(bo, fnc(bo, a[0], a[1], a[2]));
		bo+=0.1;
	}while(max+0.1>=bo);
}
//---------------------------------------------------------------------------
