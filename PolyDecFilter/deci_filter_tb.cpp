#include <stdio.h>
#include <math.h>
#include "deci_filter.h"

void deci_filter_ref(data_t input[SIZE], acc_t output[SIZE/INTRP_FACTOR]) {
   // FIR coefficients
	   coef_t coeff[NUM_STAGES][INTRP_FACTOR] = {
	     {1883, 1700, 1518, 1338, 1163,  994,  833,  680,  537},
	     {3244, 3140, 3021, 2887, 2740, 2583, 2417, 2243, 2064},
	     {3331, 3400, 3449, 3479, 3489, 3479, 3449, 3400, 3331},
	     {2064, 2243, 2417, 2583, 2740, 2887, 3021, 3140, 3244},
	     { 537,  680,  833,  994, 1163, 1338, 1518, 1700, 1883}
	   };
    data_t dat_reg[NUM_STAGES];
    data_t dat_buf[NUM_STAGES-1][INTRP_FACTOR];
    for (int i = 0; i < NUM_STAGES-1; i++) {
      for (int j = 0; j < INTRP_FACTOR; j++) {
	      dat_buf[i][j] = 0;
      }
    }
   // exact translation from FIR formula above
   acc_t acc = 0;
   acc_t sum = 0;
   for (int n = 0; n < SIZE/INTRP_FACTOR; n++) {
      sum = 0;
      for (int i = 0; i < INTRP_FACTOR; i++ ) {
    	  acc = 0;
	      for (int k = 0; k < NUM_STAGES-1; k++) {
		      dat_reg[k] = dat_buf[k][i];
	      }
	      dat_reg[NUM_STAGES-1] = input[n*INTRP_FACTOR + i];
        for (int j = 0; j < NUM_STAGES; j++) {
        	acc += coeff[j][i] * dat_reg[j];
        }
        for (int m = 0; m < NUM_STAGES-1; m++) {
        	dat_buf[m][i] = dat_reg[m+1];
        }
        sum += acc;
      }
      output[n] = sum;
   }
}


int main (void) {

  FILE   *fp;
  int err;
  data_t signal[SIZE];
  acc_t hw_result[SIZE/INTRP_FACTOR];
  acc_t sw_result[SIZE/INTRP_FACTOR];

  fp=fopen("fir_impulse.dat","w");
  err = 0;
  for (int i=0;i<SIZE;i++) {
	  signal[i] = i;
  }
  deci_filter(signal, hw_result);
  deci_filter_ref(signal, sw_result);
  for (int i=0;i<SIZE/INTRP_FACTOR;i++) {
	  if (hw_result[i] != sw_result[i]) {
		  err++;
	  }
//   	  printf("%i %d\n",i,(int)result[i]);
   	  fprintf(fp,"%d %d %d\n",i,(int)sw_result[i],(int)hw_result[i]);
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
