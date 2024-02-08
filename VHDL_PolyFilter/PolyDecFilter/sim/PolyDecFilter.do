vlib work
vcom -93 -explicit          \
../src/PolyDecFilterPkg.vhd \
../src/TestPkg.vhd	    \
../src/SyncDelay.vhd	    \
../src/DataDelay.vhd	    \
../src/DelayLine.vhd	    \
../src/CoefRom.vhd	    \
../src/FilterStage.vhd	    \
../src/Accum.vhd	    \
../src/AddrGen.vhd	    \
../src/AddrDelay.vhd	    \
../src/PolyDecFilter.vhd    \
../src/PolyDecFilter_tb.vhd

vsim +notimingchecks PolyDecFilter_tb
