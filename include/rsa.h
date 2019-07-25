#define P 61
#define Q 53
#define N 3233
#define E 17
#define D 2753
#include <stdint.h>
#define int_type uint64_t
#define size_type size_t

int_type count_bits(int_type number);
int_type integer_power(int_type base, int_type exp);
int_type montgomery_modular_multiplication(int_type X, int_type Y, int_type M);
void test_function();