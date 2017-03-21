# Ambegaokar-Baratoff-Josephson-Junction-Fitting
A matlab program for fitting Ic data from Jospehson junctions using the AB equation for junctions and Gross equation for gap

Included is the Code for the program as well as a compiled copy that will work in the matlab runtime environment R2012a

You can important critical current data as a function of temperature in .CSV format where the first column is the temperature in Kelvin and the second column is the critical current in Amps
The fit uses the Ambegaokar-Baratoff equation [1] with the Gross gap equation [2].
There are various options when fitting. You can set the gap ratio to be a constant, you can do a two band fit where you can also set the gap ratios for the bands as equal as well as the specific heat jump ratios.


References:

1.	Ambegaokar, V, and Baratoff, A. Tunneling between superconductors. Phys. Rev. Lett. 10, 486-489 (1963). 
2.	Gross, F., Chandrasekhar, B.S., Einzel, D., Andres, K., Hirschfeld, P.J., Ott, H.R., Beuers, J., Fisk, Z., Smith, J.L. Anomalous temperature dependence of the magnetic field penetration depth in superconducting UBe13. Zeitschrift für Physik B Condensed Matter 64, 175-188 (1986). 
