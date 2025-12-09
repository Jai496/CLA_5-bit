* DFF Characterization Testbench
* Author: Jai Srikar 2024102041
.include dff.cir
.include TSMC_180nm.txt

Vdd VDD 0 1.8V
Vclk CLK 0 PULSE(0 1.8 0 20p 20p 0.5n 1n)


Vin D 0 PWL(
+ 0.00n 0      ; Start at 0V
+ 0.68n 0      ; D is LOW until 0.68n
+ 0.70n 1.8    ; D rises fast (20ps) -> Setup for CLK edge at 1.0ns
+ 1.20n 1.8    ; D holds 1.8V (Guarantees positive Hold Margin)
+ 1.22n 0      ; D falls fast (20ps) -> D=0 for CLK edge at 2.0ns
+ 2.83n 0      ; Hold 0V
+ 2.85n 1.8    ; Next D rise
+ 4.00n 1.8    ; End
+ )
.tran 10p 6n
.measure tran T_cq_rise TRIG v(CLK) val=0.9 rise=2 TARG v(Q) val=0.9 rise=1

.measure tran T_cq_fall TRIG v(CLK) val=0.9 rise=3 TARG v(Q) val=0.9 fall=2

.measure tran T_cq_avg PARAM='(T_cq_rise + T_cq_fall) / 2'

.measure tran T_setup_margin TRIG v(D) val=0.9 rise=1 TARG v(CLK) val=0.9 rise=2

.measure tran T_hold_margin TRIG v(CLK) val=0.9 rise=2 TARG v(D) val=0.9 fall=1

.measure tran T_skew_rise TRIG v(CLK) val=0.9 rise=2 TARG v(CLKb) val=0.9 fall=2

.control
set hcopypscolor = 1
set color0 = black
set color1 = white
set color2 = red
set color3 = blue
set color4 = green

run

set curplottitle = "Jai Srikar 2024102041 - Inputs"
plot V(CLK)+2 V(D)
set curplottitle = "Jai Srikar 2024102041 - Output Q"
plot V(Q) V(CLK)+2
.endc