#ifndef _FIR_H_ 
#define _FIR_H_
#include <cstring>
#include <ap_int.h>
#include <ap_fixed.h>
#include <hls_math.h>
#include <hls_stream.h>
#include <complex>

#define INTRP_FACTOR 9
#define NUM_STAGES 5
#define N 10
#define SIZE 54 // just few more samples then number of taps
typedef short	coef_t;
typedef short	data_t;
typedef int 	acc_t;

//coef_t coef[NUM_STAGES][INTRP_FACTOR] = {
//		{ -18, -171, -262, -299, -293, -253, -193, -122, -51},
//		{3648, 3185, 2693, 2194, 1707, 1251,  841,  489, 202},
//		{4061, 4406, 4664, 4825, 4879, 4825, 4664, 4406, 4061},
//		{ 202,  489,  841, 1251, 1707, 2194, 2693, 3185, 3648},
//		{ -51, -122, -193, -253, -293, -299, -262, -171, -18}
//};


void deci_filter(data_t input[SIZE], int output[SIZE/INTRP_FACTOR]);
#endif
