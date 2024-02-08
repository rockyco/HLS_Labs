ngdbuild -p 4vsx35-FF668-10 ../syn/rev_1/polyintrpfilter.edf polyintrpfilter.ngd

map -p 4vsx35-FF668-10 -o polyintrpfilter_map.ncd polyintrpfilter.ngd polyintrpfilter.pcf

par -ol med -w polyintrpfilter_map.ncd polyintrpfilter.ncd polyintrpfilter.pcf

trce -v 1000 -o polyintrpfilter.twr polyintrpfilter.ncd polyintrpfilter.pcf
