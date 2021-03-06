/*
Реализовать алгоритм сортировки методом пузырька для целых чисел.
Программа предназначена для сортировки массивов, размер которых не превышает 100 элементов.
На вход поступает число N элементов в сортируемом массиве. Далее через пробел (или новую строку) подаются значения элементов.
В программе предусмотреть два режима работы:
	1) отладочный (debug), при котором содержимое массива отображается на экране после каждого прохода алгоритма;
	2) эксплуатационный (release), при котором на экран выводится только отсортированный массив.
*/

#include<stdio.h>

#include <stdlib.h>
#include <time.h>

void output(int MasX[], int M)
{
	int i;
	printf("\t[");
	for (i = 0; i < M; i++)
		MasX[i] ? printf("%d,", MasX[i]) : 1;
	printf("]\n");
}

int main()
{
	int n = 0, i = 0, j = 0, tmp = 0, l = 0, r = 100;
	printf("Укажите размер случайного массива: ");
	scanf("%d", &n);
	int Mas[n];

	srand(time(NULL));
	printf("\tСлучайный массив: [");
	for(i = 0; i < n; i++)
	{
		Mas[i] = (l - 1 + rand() % r + 2);
		i < n - 1 ? printf("%d,", Mas[i]) : printf("%d]\n", Mas[i]);
	}

	for(i = 0 ; i < n - 1; i++)
	{
		for(j = 0 ; j < n - i - 1 ; j++)
		{
			if(Mas[j] > Mas[j + 1])
			{
				tmp = Mas[j];
				Mas[j] = Mas[j + 1];
				Mas[j + 1] = tmp;
				output(Mas, n);
			}
		}
	}
}
