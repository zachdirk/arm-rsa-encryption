#include <stdint.h>
#define int_type uint64_t
#define size_type size_t

int_type count_bits(int_type number);
int_type integer_power(int_type B, int_type E, int_type M);
int_type montgomery_modular_multiplication(int_type X, int_type Y, int_type M);
int_type modular_exponentiation(int_type X, int_type E, int_type M);
void test_function();
int_type encrypt(int_type P);
int_type decrypt(int_type C);
