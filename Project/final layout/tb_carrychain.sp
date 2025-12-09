* Dynamic Carry Chain Testbench
* Author: Jai Srikar M 2024102041

.include carrychain.cir
.include TSMC_180nm.txt
Vdd VDD 0 1.8

Vclk CLK 0 PULSE(0 1.8 0 20p 20p 0.5n 1n)

Vin_G G 0 PWL(
+ 0n 0 0.4n 0
+ 1n 1.8 1.4n 1.8
+ 2n 0 2.4n 0
+ 3n 1.8 3.4n 1.8
+ 4n 0
+ )

Vin_P P 0 PWL(
+ 0n 0 0.4n 0
+ 1n 1.8 1.4n 1.8
+ 2n 1.8 2.4n 1.8
+ 3n 0 3.4n 0
+ 4n 0
+ )

Vin_Cin C_in 0 PWL(
+ 0n 0 0.4n 0  ; Test 1 (0-1ns): G=0, P=0, Cin=0 -> C_next = 0 (Hold)
+ 1n 0 1.4n 0  ; Test 2 (1-2ns): G=1, P=1, Cin=0 -> C_next = 1 (Generate)
+ 2n 1.8 2.4n 1.8 ; Test 3 (2-3ns): G=0, P=1, Cin=1 -> C_next = 1 (Propagate)
+ 3n 1.8 3.4n 1.8 ; Test 4 (3-4ns): G=1, P=0, Cin=1 -> C_next = 1 (Generate)
+ 4n 0
+ )

.tran 10p 5n

.measure tran T_prop_delay TRIG v(CLK) val=0.9 rise=1 TARG v(C_out_domino) val=0.9 fall=1
.measure tran T_gen_delay TRIG v(CLK) val=0.9 rise=2 TARG v(C_out_domino) val=0.9 fall=2


.control
run
set color0 = white
set color1 = black
set curplottitle = "Jai Srikar 2024102041"

plot v(CLK)+10 v(G)+8 v(P)+6 v(C_in)+4 v(C_out)+2 v(C_out_domino)
.endc