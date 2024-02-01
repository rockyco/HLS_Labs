#include "fir.h"

void fir(data_t input[SIZE], acc_t output[SIZE]) {
   // FIR coefficients
   coef_t coeff[N] = {13, -2, 9, 11, 26, 18, 95, -43, 6, 74};
   // Shift registers
   int shift_reg[N] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
#pragma HLS ARRAY_PARTITION variable=shift_reg complete dim=1
   // loop through each output
   output_loop :
   for (int i = 0; i < SIZE; i ++ ) {
	   int acc = 0;
	   // shift registers
	   shift_loop :
	   for (int j = N - 1; j > 0; j--) {
#pragma HLS UNROLL
		   shift_reg[j] = shift_reg[j - 1];
	   }
	   // put the new input value into the first register
	   shift_reg[0] = input[i];
	   // do multiply-accumulate operation
	   mulacc_loop :
	   for (int j = 0; j < N; j++) {
#pragma HLS UNROLL
		   acc += shift_reg[j] * coeff[j];
	   }
	   output[i] = acc;
   }
}
