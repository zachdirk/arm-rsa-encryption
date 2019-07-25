#include <stdio.h>
#include <math.h>
#include <assert.h>
#include "rsa.h"

int_type count_bits(int_type number) 
{       
	size_type count = 0;
	while (number)
	{
		count = count + 1;
		number = number>>1;
	}
	return count;
}

int_type integer_power(int_type base, int_type exp)
{
	int_type result = 1;
	for (int i = 1; i < exp; i++)
	{
		result = result * base;
	}
	return result;
}

int_type montgomery_modular_multiplication(int_type X, int_type Y, int_type M)
{
	size_type m = count_bits(M);
	int_type R = integer_power(2, m);
	int_type T = 0;
	for (int i = 0; i < m; i++)
	{
		int_type X_b = (X >> i) & 1;
		int_type Y_b = Y & 1;
		int_type T_b = (T & 1) ^ (X_b & Y_b);
		T = (T + X_b*Y + T_b * M) >> 1;
	}
	if (T >= M)
		return T - M;
	else
		return T;
}

void test_function()
{
	assert(montgomery_modular_multiplication(17, 22, 23) == 16);
}

int main()
{
	test_function();
	int_type X = 17;
	int_type Y = 22;
	int_type M = 23;
	printf("MMM: X = %d, Y = %d, M = %d, Z = %d\n", X, Y, M, montgomery_modular_multiplication(X, Y, M));
	return(0);
}
