% Create a waveform represented by integers for a VHDL array
%
% written by Sean Caffee, 26 JUL 05
%

% How many binary digits to quantize to?
b = 16;

% Create a waveform

t = 1:1024;

samplesPerCycle = 8;
phaseOffset = 0;

signal = sin(2*pi*t/samplesPerCycle + phaseOffset);

% Generate quantizer function
q = quantizer('fixed', 'ceil', 'saturate', [b 0]);

% quantize signal
signal_integer = 2^(b-1) * signal;

signal_integer = quantize(q, signal_integer);

% get filename
%fileName = input('Enter output file name: ', 's');
fileName = 'test_waveform.dat';

% write out values in proper format for VHDL array

fid = fopen(fileName, 'w');

for i = 1:length(signal_integer)
   fprintf(fid, '%6d, ', signal_integer(i));
   fprintf(fid, '\n');
end

fclose(fid);


