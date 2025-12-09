* P/G Block Testbench
* Author: Jai Srikar 2024102041

.include pg.cir
.include TSMC_180nm.txt
.param T_rise_fall = 20p
Vdd VDD 0 1.8

Va A 0 PULSE(0 1.8 0 
+ {T_rise_fall} {T_rise_fall} 2n 4n)

Vb B 0 PULSE(0 1.8 0 
+ {T_rise_fall} {T_rise_fall} 1n 2n)

CloadP P 0 10fF
CloadG G 0 10fF

.tran 10p 6n ; 

* --- 1. Propagate Delays ---

* Delay from A (fall at 4n) to P (fall at 5n)
.measure tran T_AP_fall TRIG v(A) val=0.9 fall=1 TARG v(P) val=0.9 fall=1

* Delay from A (rise at 2n) to P (rise, when B=0)
.measure tran T_AP_rise TRIG v(A) val=0.9 rise=1 TARG v(P) val=0.9 rise=1

* Delay from B (rise at 1n) to P (fall, when A=0)
.measure tran T_BP_fall TRIG v(B) val=0.9 rise=1 TARG v(P) val=0.9 fall=1

* Delay from B (fall at 2n) to P (rise, when A=1)
.measure tran T_BP_rise TRIG v(B) val=0.9 fall=1 TARG v(P) val=0.9 rise=1


* --- 2. Generate Delays ---

* Delay from A (fall at 4n) to G (fall at 4n)
.measure tran T_AG_fall TRIG v(A) val=0.9 fall=1 TARG v(G) val=0.9 fall=1

* Delay from A (rise at 2n) to G (rise, when B=1)
.measure tran T_AG_rise TRIG v(A) val=0.9 rise=1 TARG v(G) val=0.9 rise=1

* Delay from B (rise at 1n) to G (rise, when A=0)
.measure tran T_BG_rise TRIG v(B) val=0.9 rise=1 TARG v(G) val=0.9 rise=1

* Delay from B (fall at 2n) to G (fall, when A=1)
.measure tran T_BG_fall TRIG v(B) val=0.9 fall=1 TARG v(G) val=0.9 fall=1


.control
run
set hcopypscolor = 1
set color0 = black
set color1 = white
set color2 = red
set color3 = blue

set curplottitle = "Jai Srikar 2024102041"
plot v(A)+4 v(B)+2 v(P) v(G)
.endc