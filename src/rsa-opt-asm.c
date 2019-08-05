#include <stdio.h>
#include <math.h>
#include <assert.h>
#include <stdlib.h>
#include "rsa.h"

int_type M_ = 0x87C0A58506C013;
int_type E_ = 0x10001;
int_type D_ = 0x6D65F46A3E84F1;


int_type count_bits(int_type N) 
{       
	register size_type count = 0;
	while (N)
	{
		count = count + 1;
		N = N>>1;
	}
	return count;
}

int_type integer_power(int_type B, int_type E, int_type M)
{
	register int_type result = 1;
	while(E)
	{
		result = result * B % M;
		--E;
	}
	return result;
}

int_type montgomery_modular_multiplication(int_type X, register int_type Y, register int_type M, register size_type m)
{
	register int_type Z = 0;
	register bit_type Y_0 = Y & 1;
	register bit_type X_i = 0;
	register bit_type Z_n = 0;
	while(m)
	{
		X_i = X & 1;
		Z_n = (Z & 1) ^ (X_i & Y_0);
		Z = (Z + X_i*Y + Z_n * M) >> 1;
		X = X >> 1;
		--m;
	}
	if (Z >= M)
		Z = Z - M;
	return Z;
}

int_type modular_exponentiation(register int_type X, register int_type E, register int_type M, register size_type m)
{
	register int_type Rsq = integer_power(2, m*2, M);
	register int_type Z = montgomery_modular_multiplication(1, Rsq, M, m);
	register int_type P = montgomery_modular_multiplication(X, Rsq, M, m);
	while (E)
	{
		if (E & 1)
			Z = montgomery_modular_multiplication(Z, P, M, m);
		P = montgomery_modular_multiplication(P, P, M, m);
		E = E >> 1;
	}
	return montgomery_modular_multiplication(1, Z, M, m);
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

int_type encrypt(int_type P)
{
	return modular_exponentiation(P, E_, M_, count_bits(M_));
}

int_type decrypt(int_type C)
{
	return modular_exponentiation(C, D_, M_, count_bits(M_));
}

void profile()
{
	srand(0);
	for (int i = 0; i < 1000; i++)
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
