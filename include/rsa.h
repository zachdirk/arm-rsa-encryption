#include <stdint.h>
#define int_type uint64_t
#define size_type unsigned int
#define bit_type unsigned int

int_type count_bits(int_type number);
int_type integer_power(int_type B, int_type E, int_type M);
int_type montgomery_modular_multiplication(int_type X, int_type Y, int_type M, size_type m);
int_type modular_exponentiation(int_type X, int_type E, int_type M, size_type m);
void test_function();
int_type encrypt(int_type P);
int_type decrypt(int_type C);
