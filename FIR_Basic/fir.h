#ifndef _FIR_H_ 
#define _FIR_H_
#include "ap_int.h"
#define N 10
#define SIZE N+10 // just few more samples then number of taps
typedef short	coef_t;
typedef short	data_t;
typedef int 	acc_t;
void fir(data_t input[SIZE], int output[SIZE]);
#endif
