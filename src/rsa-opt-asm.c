#include <stdio.h>
#include <math.h>
#include <assert.h>
#include <stdlib.h>
#include "rsa.h"

int_type M_ = 0x87C0A58506C013;
int_type E_ = 0x10001;
int_type D_ = 0x6D65F46A3E84F1;


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

int_type integer_power(int_type base, int_type exp, int_type m)
{
	int_type result = 1;
	for (int i = 0; i < exp; i++)
	{
		result = result * base % m;
	}
	return result;
}

int_type montgomery_modular_multiplication(int_type X, int_type Y, int_type M)
{
	size_type m = count_bits(M);
	int_type Z = 0;
	for (int i = 0; i < m; i++)
	{
		int_type X_i = (X >> i) & 1;
		int_type Y_0 = Y & 1;
		int_type Z_n = (Z & 1) ^ (X_i & Y_0);
		Z = (Z + X_i*Y + Z_n * M) >> 1;
	}
	if (Z >= M)
		Z = Z - M;
	return Z;
}

int_type modular_multiplication(int_type X, int_type Y, int_type M)
{
	int_type Rsq = integer_power(2, count_bits(M)*2, M);
	int_type Xbar = montgomery_modular_multiplication(X, Rsq, M);
	int_type Ybar = montgomery_modular_multiplication(Y, Rsq, M);
	int_type Zbar = montgomery_modular_multiplication(Xbar, Ybar, M);
	int_type Z = montgomery_modular_multiplication(Zbar, 1, M);
	return Z;
}

int_type modular_exponentiation(int_type X, int_type E, int_type M)
{
	size_type m = count_bits(M);
	int_type Rsq = integer_power(2, m*2, M);
	int_type Z = montgomery_modular_multiplication(1, Rsq, M);
	int_type P = montgomery_modular_multiplication(X, Rsq, M);
	for (int i = 0; i < m; i++)
	{
		
		if ((E >> i) & 1)
			Z = montgomery_modular_multiplication(Z, P, M);
		P = montgomery_modular_multiplication(P, P, M);
	}
	return montgomery_modular_multiplication(1, Z, M);
}
#ifdef DEBUG
void test_function()
{
	int_type X = 17;
	int_type Y = 22;
	int_type M = 23;
	printf("MP: X=%llu, Y=%llu, M=%llu, Z=%llu, Answer=%llu\n", X, Y, M, modular_multiplication(X, Y, M), (X*Y)%M);
	X = 43;
	Y = 56;
	M = 97;
	printf("MP: X=%llu, Y=%llu, M=%llu, Z=%llu, Answer=%llu\n", X, Y, M, modular_multiplication(X, Y, M), (X*Y)%M);
	X = 561;
	Y = 622;
	M = 813;
	printf("MP: X=%llu, Y=%llu, M=%llu, Z=%llu, Answer=%llu\n", X, Y, M, modular_multiplication(X, Y, M), (X*Y)%M);
	X = 4;
	int_type E = 13;
	M = 497;
	printf("ME: X=%llu, E=%llu, M=%llu, Z=%llu, Answer=%llu\n", X, E, M, modular_exponentiation(X, E, M), 445);
	X = 855;
	E = 2753;
	M = 3233;
	printf("ME: X=%llu, E=%llu, M=%llu, Z=%llu, Answer=%llu\n", X, E, M, modular_exponentiation(X, E, M), 123);
	X = 5877759;
	E = E_;
	M = M_;
	printf("ME: X=%llu, E=%llu, M=%llu, Z=%llu, Answer=%llu\n", X, E, M, modular_exponentiation(X, E, M), 837238223);
}
#endif

int_type encrypt(int_type p)
{
	return modular_exponentiation(p, E_, M_);
}

int_type decrypt(int_type c)
{
	return modular_exponentiation(c, D_, M_);
}

void profile()
{
	srand(0);
	for (int i = 0; i < 100; i++)
	{
		int_type msg = rand();
		int_type c = encrypt(msg);
		int_type d = decrypt(c);
		assert(msg == d);
	}
		
}


int main()
{
	#ifdef DEBUG
	test_function();
	#endif
	profile();
	return(0);
}
