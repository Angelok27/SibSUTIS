/*
Задача:
	На вход программы поступает десятичное число x = x 1 x 2 x 3 x 4 ... x n , где x i – i-й разряд числа x. Необходимо вывести разряды числа x в прямом порядке через пробел.
Пример:
	x = 1456, Вывод на экран: 1 4 5 6
Решение:
	Другим подходом к решению задачи H12.1 является пошаговое выделение разрядов в порядке от старшего к младшему.
	Для этого необходимо вычислить количество n разрядов в x (С12.2). Далее сформировать число 10 n-1 и с помощью него отсечь все разряды кроме старшего:
		d = x div 10 n-1 .
	Для получения второго по значимости разряда формируется число 10 n-2 :
		d = (x div 10 n-2 ) mod 10.
	И так далее. Для решения задачи данным способом необходимо разработать рекуррентное соотношение для степеней 10, которые обеспечивают поразрядный десятичный сдвиг 1 на k разрядов влево.
*/

#include <stdio.h>

int main()
{
	int a = 0, b = 0, c = 0, d = 0, e = 1, i = 0;

	printf("Введите целое десятичное число: ");
	scanf("%d", &a);
	b = a;

	while(b > 0)
	{
		b = b / 10;
		e *= 10;
		c++;
	}
	e = e / 10;
	b = a;
	printf("Разряды в прямом порядке: ");
	for (i=0; i<c; i++)
	{
		d = b/e;
		b = b%e;
		e /= 10;
		printf("%d ", d);
	}
	printf("\n");

	return 0;
}
