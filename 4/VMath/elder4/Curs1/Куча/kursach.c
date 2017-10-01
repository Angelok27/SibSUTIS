#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <dos.h>

#define READ 10
#define WRITE 11
#define LOAD 20
#define STORE 21
#define ADD 30
#define SUBTRACT 31
#define DIVIDE 32
#define MULTIPLY 33
#define BRANCH 40
#define BRANCHNEG 41
#define BRANCHZERO 42
#define HALT 43
#define SHR 50

char memory[100][5], c[5], path[255];
short i, n, k, InstructionCounter, OperationCode, accumulator, InstructionRegister, operand;
FILE *f, *f1;

/*�㭪�� �८�ࠧ������ ⨯�� �� int � char*/
int int2char (int i)
{
    if (i<0)
    {
       c[0]='-';
       i=-i;
    }
    else
        c[0]='+';
    c[1]=i/1000+48;
    c[2]=(i%1000)/100+48;
    c[3]=(i%100)/10+48;
    c[4]=i%10+48;
    return(NULL);
}

/* �㭪�� ����� ������ � ����������*/
input (int i)
{
int k;
char c[5];

    if (i<10)
       printf ("0%d ?>", i);
    else
    printf ("%d ?>", i);
    scanf ("%s", c);

    for (k=1; k<5; k++)
        while ((c[0]!='+' && c[0]!='-') || c[k]<'0' || c[k]>'9' || strlen(c)!=5)
        {
              printf ("������ �ଠ� ������ \n");
              if (i<10)
                 printf ("0%d ?>",i);
              else
                  printf ("%d ?>",i);
              scanf ("%s", c);
        }
    for (k=0; k<5; k++)
        memory[i][k]=c[k];
return(NULL);
}

/*�㭪�� �८�ࠧ������ ⨯�� �� char � int*/
int char2int (int i)
{
    OperationCode=operand=0;
    InstructionRegister=(memory[i][1]*1000+memory[i][2]*100+memory[i][3]*10+memory[i][4])-53328;
    if (memory[i][0]=='-')
       InstructionRegister=-InstructionRegister;
    if (memory[i][0]=='+')
    {
        OperationCode=InstructionRegister/100;
        operand=InstructionRegister%100;
    }
return (InstructionRegister);
}

/* �㭪�� ����� ������ �� 䠩��*/
int fileread (int i)
{
int k, n;
char c[5];
    n=0;
    fscanf (f, "%s", &c);
    for (k=1; k<5; k++)
        if ((c[0]!='+' && c[0]!='-') || c[k]<'0' || c[k]>'9' || strlen(c)!=5)
           n++;
    if (n==0)
       for (k=0; k<5; k++)
           memory[i][k]=c[k];
    else
        printf ("������ �ଠ� ������ � ��ப� %d \n", i);
return(NULL);
}

/*����� �ணࠬ��*/
int main(void)
{

OperationCode=accumulator=InstructionRegister=operand=0;
for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
{
    memory[InstructionCounter][0]='+';
    for (i=1; i<5; i++)
    memory[InstructionCounter][i]='0';
}
n=0;
while (n!=5)
{
printf ("      \n�ணࠬ���� ������ �������� SC, �믮����饣� �ணࠬ�� �� �몥 SA \n\n");
printf ("\t\t\t   �믮����: ���类� �.�. \n");
printf ("\t\t\t   ��㯯� �-01, ��ன ���� \n");
printf ("\t\t\t   ����� p01s11 \n\n\n");
printf ("[1] - ���� ������ � ����������\n");
printf ("[2] - ���� ������ �� 䠩��\n");
printf ("[3] - �뢮� ����� ����� �� �࠭\n");
printf ("[4] - �뢮� ����� ����� � 䠩�\n");
printf ("[5] - ��室\n");
scanf ("%d", &n);

/*���� ������ � ����������*/
if (n==1)
{

   printf ("������ ���祭��: \n");
   for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
   {
       input (InstructionCounter);
       if (memory[InstructionCounter][0]=='-' && memory[InstructionCounter][1]=='9' && memory[InstructionCounter][2]=='9' && memory[InstructionCounter][3]=='9' && memory[InstructionCounter][3]=='9')
       {
          printf ("����� ����� �����襭 \n");
          break;
       }
   }
}

/*���� ������ �� 䠩��*/
if (n==2)
{
   printf ("������ ��� 䠩�� \n");
   scanf ("%s", &path);
   if ((f=fopen(path, "r"))==NULL)
    printf ("%s","Can't open file");
 else
 {
     for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
     {
         fileread (InstructionCounter);
         if (memory[InstructionCounter][0]=='-' && memory[InstructionCounter][1]=='9' && memory[InstructionCounter][2]=='9' && memory[InstructionCounter][3]=='9' && memory[InstructionCounter][3]=='9')
         {
            printf ("����� ����� �����襭 \n");
            break;
         }
     }
 }
}

/*�뢮� ����� �����*/
if (n==3)
{
   printf ("\n���� �����:\n");
   for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
   {

        if (InstructionCounter%10==0)
           printf ("\n");
        for (i=0; i<5; i++)
            printf ("%c", memory[InstructionCounter][i]);
        printf (" ");
   }
}

/*�뢮� ����� ����� � 䠩�*/
if (n==4)
{
   printf ("������ ��� 䠩�� \n");
   scanf ("%s", &path);
   f1=fopen(path, "w");
   for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
   {

        if (InstructionCounter%10==0)
           fprintf (f1,"\n");
        for (i=0; i<5; i++)
            fprintf (f1,"%c", memory[InstructionCounter][i]);
        fprintf (f1," ");
   }
   printf ("��⮢�! \n");
}
/*��室 �� �ணࠬ�*/
if (n==5)
{
   fcloseall();
   exit(0);
}

/*��ࠡ�⪠ ��������� ������*/
if (n==1 || n==2)
{
InstructionCounter=0;
while (InstructionCounter<100)
{
    char2int (InstructionCounter);
        if (OperationCode==READ)
        {
           printf ("\n������ ���祭��: \n");
           input (operand);
        }
        else
            if (OperationCode==WRITE)
            {
               printf ("\n����� �祩�� %d: ", operand);
               for (i=0; i<5; i++)
                   printf ("%c",memory[operand][i]);
            }
            else
                if (OperationCode==LOAD)
                   accumulator=char2int(operand);
                else
                    if (OperationCode==STORE)
                    {  int2char(accumulator);
                       for (i=0; i<5; i++)
                           memory[operand][i]=c[i];
                     }
                     else
                         if (OperationCode==ADD)
                            accumulator+=char2int(operand);
                         else
                             if (OperationCode==SUBTRACT)
                                accumulator-=char2int(operand);
                             else
                                 if (OperationCode==DIVIDE)
                                 {
                                     if (char2int(operand)==0)
                                     {
                                        printf ("\n�訡��: ������� �� 0\n");
                                        break;
                                     }
                                     else
                                         accumulator/=char2int(operand);
                                 }
                                 else
                                     if (OperationCode==MULTIPLY)
                                        accumulator*=char2int(operand);
                                     else
                                         if (OperationCode==BRANCH)
                                            InstructionCounter=operand-1;
                                         else
                                             if (OperationCode==BRANCHNEG)
                                             {
                                                if (accumulator<0)
                                                   InstructionCounter=operand-1;
                                             }
                                             else
                                                 if (OperationCode==BRANCHZERO)
                                                 {
                                                    if (accumulator==0)
                                                       InstructionCounter=operand-1;
                                                 }
                                                 else
                                                     if (OperationCode==HALT)
                                                        break;
                                                     else
                                                         if (OperationCode==SHR)
                                                         {
                                                            accumulator=char2int(operand);
                                                            accumulator=accumulator%1000*10;
                                                         }
                                                         else
                                                             if (char2int(InstructionCounter)>0)
                                                                printf ("\n�������⭠� ������� � ��ப� %d, �������� ����� �ணࠬ�� \n", InstructionCounter);
    InstructionCounter++;
}

/*�뢮� ����� ����� �� �࠭*/
printf ("\n���� �����:\n");
for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
{
    if (InstructionCounter%10==0)
       printf ("\n");
    for (i=0; i<5; i++)
        printf ("%c", memory[InstructionCounter][i]);
    printf (" ");
}

}
delay(2000);
}
return (0);
}