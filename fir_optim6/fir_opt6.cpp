#include "fir.h"
// original, non-optimized version of FIR

void fir(data_t input[SIZE], acc_t output[SIZE]) {
   // FIR coefficients
   coef_t coeff[N] = {13, -2, 9, 11, 26, 18, 95, -43, 6, 74};
   // Shift registers
   data_t shift_reg[N] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
#pragma HLS ARRAY_PARTITION variable=shift_reg complete dim=1
   // Temporary product wires
   acc_t prod_wire[N];

   memset_loop :
   for (int n = 0; n < N; n++) {
#pragma HLS UNROLL
	   shift_reg[n] = 0;
   }
   // exact translation from FIR formula above
   // loop through each output
   outer_loop :
   for (int i = 0; i < SIZE; i++) {
#pragma HLS PIPELINE
	  acc_t acc = 0;
	  // do multiply operation
	  acc_loop :
      for (int j = 0; j < N; j++ ) {
    	  prod_wire[j] = coeff[j] * input[i];
      }
	  // shift registers
	  shift_loop :
	  for (int j = 0; j < N - 1; j++) {
	     shift_reg[j] = prod_wire[j] + shift_reg[j + 1];
	  }
	  // put the new input value into the last register
	  shift_reg[N - 1] = prod_wire[N - 1];

      output[i] = shift_reg[0];
   }
}
