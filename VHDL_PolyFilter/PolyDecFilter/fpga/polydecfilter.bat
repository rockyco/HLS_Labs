ngdbuild -p 4vsx35-FF668-10 ../syn/rev_1/polydecfilter.edf polydecfilter.ngd

map -p 4vsx35-FF668-10 -o polydecfilter_map.ncd polydecfilter.ngd polydecfilter.pcf

par -ol med -w polydecfilter_map.ncd polydecfilter.ncd polydecfilter.pcf

trce -v 1000 -o polydecfilter.twr polydecfilter.ncd polydecfilter.pcf
