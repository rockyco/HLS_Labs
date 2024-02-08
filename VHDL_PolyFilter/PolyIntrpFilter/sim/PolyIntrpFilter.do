vlib work
vcom -93 -explicit          \
../src/PolyIntrpFilterPkg.vhd \
../src/TestPkg.vhd	    \
../src/SyncDelay.vhd	    \
../src/DataDelay.vhd	    \
../src/DelayLine.vhd	    \
../src/CoefRom.vhd	    \
../src/FilterStage.vhd	    \
../src/AddrGen.vhd	    \
../src/AddrDelay.vhd	    \
../src/PolyIntrpFilter.vhd    \
../src/PolyIntrpFilter_tb.vhd

vsim +notimingchecks PolyIntrpFilter_tb

add wave sim:/PolyIntrpFilter_tb/*

