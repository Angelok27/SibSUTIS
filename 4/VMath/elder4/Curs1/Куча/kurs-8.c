#include <stdlib.h>
#include <stdio.h>

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

char memory[100][5],  c[5];
int i, j, n, k, InstructionCounter, OperationCode, accumulator, InstructionRegister, operand;
FILE *f, *f1;

/*������� �������������� ����� �� int � char*/
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

/* ������� ����� ������ � ����������*/
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
              printf ("�������� ������ ������ \n");
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

/*������� �������������� ����� �� char � int*/
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

/* ������� ����� ������ �� �����*/
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
        printf ("�������� ������ ������ � ������ %d \n", i);
return(NULL);
}

/*����� ���������*/
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
printf ("      \n����������� ������ ���������� SC, ������������ ��������� �� ����� SA \n\n");
printf ("\t\t\t   ��������: ��������� �.�. \n");
printf ("\t\t\t   ������ �-01, ������ ���� \n");
printf ("\t\t\t   ����� p01s11 \n\n\n");
printf ("[1] - ���� ������ � ����������\n");
printf ("[2] - ���� ������ �� �����\n");
printf ("[3] - ����� ����� ������ �� �����\n");
printf ("[4] - ����� ����� ������ � ����\n");
printf ("[5] - �����\n");
scanf ("%d", &n);
/*���� ������ � ����������*/
if (n==1)
{

   printf ("������� ��������: \n");
   for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
   {
       input (InstructionCounter);
       if (memory[InstructionCounter][0]=='-' && memory[InstructionCounter][1]=='9' && memory[InstructionCounter][2]=='9' &&
memory[InstructionCounter][3]=='9' && memory[InstructionCounter][3]=='9')
       {
          printf ("������� ����� �������� \n");
          break;
       }
   }
}

/*���� ������ �� �����*/
if (n==2)
{
   if ((f=fopen("d:\\work\\kostya\\dat.txt", "r"))==NULL)
    fprintf (stderr, "Can't open file dat.txt");
 else
 {
     for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
     {
         fileread (InstructionCounter);
         if (memory[InstructionCounter][0]=='-' && memory[InstructionCounter][1]=='9' && memory[InstructionCounter][2]=='9' &&
memory[InstructionCounter][3]=='9' && memory[InstructionCounter][3]=='9')
         {
            printf ("������� ����� �������� \n");
            break;
         }
     }
 }
}

/*����� ����� ������*/
if (n==3)
{
   j=1;
   printf ("\n���� ������:\n");
   for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
   {

        if (InstructionCounter==(j*10))
        {
           printf ("\n");
           j++;
        }
        for (i=0; i<5; i++)
            printf ("%c", memory[InstructionCounter][i]);
        printf (" ");
   }
}

/*����� ����� ������ � ����*/
if (n==4)
{
   f1=fopen("d:\\work\\kostya\\dump.txt", "w");
   j=1;
   for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
   {

        if (InstructionCounter==(j*10))
        {
           fprintf (f1,"\n");
           j++;
        }
        for (i=0; i<5; i++)
            fprintf (f1,"%c", memory[InstructionCounter][i]);
        fprintf (f1," ");
   }
}
/*����� �� ��������*/
if (n==5)
{
   fcloseall();
   exit(n==5);
}

/*��������� ��������� ������*/
if (n==1 || n==2)
{
InstructionCounter=0;
while (InstructionCounter<100)
{
    char2int (InstructionCounter);
        if (OperationCode==READ)
        {
           printf ("\n������� ��������: \n");
           input (operand);
        }
        else
            if (OperationCode==WRITE)
            {
               printf ("\n����� ������ %d: ", operand);
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
                                        printf ("\n������: ������� �� 0\n");
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
                                                                printf ("\n����������� ������� � ������ %d, �������� ������
��������� \n", InstructionCounter);
    InstructionCounter++;
}

/*����� ����� ������ �� �����*/
j=1;
printf ("\n���� ������:\n");
for (InstructionCounter=0; InstructionCounter<100; InstructionCounter++)
{
    if (InstructionCounter==(j*10))
    {
       printf ("\n");
       j++;
    }
    for (i=0; i<5; i++)
        printf ("%c", memory[InstructionCounter][i]);
    printf (" ");
}

}
delay(2000);
}
return (0);
}
