#include <stdio.h>
int main ()
{	
	FILE *f1,*f2=fopen("matr.txt","w");
	int i,o,p,k,cm;
	float koof, mat[30][30], vek[30], x[30];
	char en;
	
	printf("\nViberite sposob zapolnenia matrixi(f-chtenie is fila, m-vvod terminale): ");
	scanf("%c",&en);
	switch (en){
		case 'm':{
				/*�������� �������� �������� �������*/
				do{
					printf("Vvedite kol-vo peremennih: ");
					scanf("%d",&cm);
					if(cm<2)printf("\nPeremennih dolgnobit ne menee 2h.\n");
				}while(cm<2);

				/*���� ������ ��� ���������� �������*/
				printf("\nNeobhodimo vvesti %d chisla\n",cm*cm);
				for(o=0;o<cm;o++)
					for(p=0;p<cm;p++,i++){
						printf("Vvedite elem. matrixi %d: ",i);
						scanf("%f",&mat[p][o]);
					}
				/*���� ��. �������*/
				printf("\n");
				for(o=0;o<cm;o++){
					printf("Vvedite elem. vektora %d: ",o+1);
					scanf("%f",&vek[o]);
				}
			}break;
		case 'f':{
				/*�������� ����� � ��������*/
				if((f1=fopen("mat.txt","r"))==NULL){
					printf("\nNe udalos otkrit file: mat.txt");
					scanf("%c",&en);
					return -1;
				}

				/*������ ������� �� �����*/
				fscanf(f1,"%d",&cm);
				for(o=0;o<cm;o++){
					for(p=0;p<cm;p++)
						fscanf(f1,"%f",&mat[p][o]);
				/*������ �������*/
					fscanf(f1,"%f",&vek[o]);
				}
			}break;
	}

	/*����� �������� �������*/
	printf("\nVvedennaia matrixa\n");
	for(o=0;o<cm;o++){
		for(p=0;p<cm;p++)
			printf("%9.3f",mat[p][o]);

		printf("|%9.3f",vek[o]);
		printf("\n");
	}

	/*������ ��� ������� �������*/
	for(i=0;i<cm-1;i++)
		for(o=i+1;o<cm;o++){
			koof=mat[i][o]/mat[i][i];
			for(p=i;p<cm;p++)mat[p][o]-=mat[p][i]*koof;
			vek[o]-=vek[i]*koof;/*������ �����������*/

			printf("\n");
			for(k=0;k<cm;k++){
				for(p=0;p<cm;p++)printf("%9.3f",mat[p][k]);/*����� �������*/
				printf("|%9.3f",vek[k]);/*����� �������*/
				printf("\n");
			}
		}

	/*����� ������� ��c�� �������*/
	printf("\nReshennaia matrixa\n");
	for(o=0;o<cm;o++){
		for(p=0;p<cm;p++){
			printf("%9.3f",mat[p][o]);/*����� �������*/
			fprintf(f2,"%9.3f",mat[p][o]);/*������ ������� � ����*/
		}

		printf("|%9.3f",vek[o]);/*����� �������*/
		fprintf(f2,"|%9.3f",vek[o]);/*������ ������� � ����*/
		fprintf(f2,"\n");
		printf("\n");
	}

	/*�������� ���. ������ �����*/
	x[cm-1]=vek[cm-1]/mat[cm-1][cm-1];
	for(i=cm-2;i>=0;i--){
		for(p=i+1;p<cm;p++)vek[i]=vek[i]-x[p]*mat[p][i];
		x[i]=vek[i]/mat[i][i];/*������ ����*/
	}

	fprintf(f2,"\n");
	for(i=0;i<cm;i++){
		printf("X%d=%.3f | ",i+1,x[i]);/*����� �����*/
		fprintf(f2,"X%d=%.3f | ",i+1,x[i]);/*������ ����� � ����*/
	}

	getchar();
	getchar();/*���� ������ ������� ��� ����������*/
	fclose(f2);
	fclose(f1);

	return 0;
}
