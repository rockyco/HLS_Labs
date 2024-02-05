#include "intrp_filter.h"
// original, non-optimized version of FIR

void intrp_filter(data_t input[SIZE], acc_t output[SIZE*INTRP_FACTOR]) {
   // FIR coefficients
   //coef_t coeff[N] = {13, -2, 9, 11, 26, 18, 95, -43, 6, 74};
   coef_t coeff[NUM_STAGES][INTRP_FACTOR] = {
     {1883, 1700, 1518, 1338, 1163,  994,  833,  680,  537},
     {3244, 3140, 3021, 2887, 2740, 2583, 2417, 2243, 2064},
     {3331, 3400, 3449, 3479, 3489, 3479, 3449, 3400, 3331},
     {2064, 2243, 2417, 2583, 2740, 2887, 3021, 3140, 3244},
     { 537,  680,  833,  994, 1163, 1338, 1518, 1700, 1883}
   };
#pragma HLS ARRAY_PARTITION dim=1 type=complete variable=coeff
   // Shift registers
   data_t shift_reg[NUM_STAGES];
#pragma HLS ARRAY_PARTITION variable=shift_reg complete dim=1
   // Accumulate registers
   acc_t acc[NUM_STAGES+1];
#pragma HLS ARRAY_PARTITION variable=acc complete dim=1
   acc[0] = 0;

   memset_loop :
   for (int n = 0; n < NUM_STAGES; n++) {
#pragma HLS UNROLL
	   shift_reg[n] = 0;
   }
   // exact translation from FIR formula above
   // loop through each output
   outer_loop :
   for (int i = 0; i < SIZE; i++) {
	  // shift registers
	  shift_loop :
	  for (int m = 0; m < NUM_STAGES - 1; m++) {
#pragma HLS UNROLL
	     shift_reg[m] = shift_reg[m + 1];
	  }
	  // put the new input value into the last register
	  shift_reg[NUM_STAGES - 1] = input[i];
	  // do multiply & accumulate operation
	  acc_loop :
      for (int j = 0; j < INTRP_FACTOR; j++ ) {
#pragma HLS PIPELINE II=1
    	  for (int k = 0; k < NUM_STAGES; k++) {
    		  acc[k+1] = shift_reg[k] * coeff[k][j] + acc[k];
    	  }
    	  output[i*INTRP_FACTOR + j] = acc[NUM_STAGES];
      }
   }
}
