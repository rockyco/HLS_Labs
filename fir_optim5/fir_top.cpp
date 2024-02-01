#include <stdio.h>
#include <math.h>
#include "fir.h"

void fir_ref(data_t input[SIZE], acc_t output[SIZE]) {
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


int main () {

  FILE   *fp;
  int err;
  data_t signal[SIZE];
  acc_t hw_result[SIZE];
  acc_t sw_result[SIZE];

  fp=fopen("fir_impulse.dat","w");
  err = 0;
  int i;
  for (i=0;i<SIZE;i++) {
	  signal[i] = i;
  }
  fir(signal, hw_result);
  fir_ref(signal, sw_result);
  for (i=0;i<SIZE;i++) {
	  if (hw_result[i] != sw_result[i]) {
		  err++;
	  }
//   	  printf("%i %d\n",i,(int)result[i]);
   	  fprintf(fp,"%i %d %d\n",i,(int)signal[i],(int)hw_result[i]);
  }
  if (err) {
	  printf("TEST FAILED!\n");
  }
  else {
	  printf("TEST PASSED!\n");
  }
  fclose(fp);
  return 0;
}
