#include "fir.h"
// original, non-optimized version of FIR

void fir(data_t input[SIZE], acc_t output[SIZE]) {
   // FIR coefficients
   coef_t coeff[N] = {13, -2, 9, 11, 26, 18, 95, -43, 6, 74};
   // exact translation from FIR formula above
   for (int n = 0; n < SIZE; n++) {
	  acc_t acc = 0;
      for (int i = 0; i < N; i++ ) {
         if (n - i >= 0)
            acc += coeff[i] * input[n - i];
      }
      output[n] = acc;
   }
}
