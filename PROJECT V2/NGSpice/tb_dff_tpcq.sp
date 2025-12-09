* Tpcq (Clock-to-Q) Delay Testbench
* Author: Jai Srikar 2024102041

* 1. Include your corrected netlist
.include test.cir

* 2. Parameters
.param LAMBDA=0.09u
.param VDD_VAL=1.8V
.param RISE_FALL=0.05ns
.param VREF=0.9V

* 3. Power
Vvdd vdd 0 DC {VDD_VAL}

* 4. Stimulus
* CLOCK: Period=10ns. Rises at 5ns, 15ns...
Vclk CLK 0 PULSE(0 {VDD_VAL} 0ns {RISE_FALL} {RISE_FALL} 5ns 10ns)

* DATA: Toggles well before Clock to guarantee stable Tpcq measurement
* Rises at 2.5ns (2.5ns before Clock Rise)
* Falls at 12.5ns (2.5ns before Clock Rise)
Vd D 0 PULSE(0 {VDD_VAL} 2.5ns {RISE_FALL} {RISE_FALL} 10ns 20ns)

* 5. DUT
Xdut D CLK Q vdd 0 dff_pos N='20*LAMBDA'

* 6. Analysis
.tran 1ps 25ns

* 7. Measurements (Tpcq)

* A. Tpcq (Rising) - Delay when Q goes Low->High
* Trigger: Clock Rise at 5ns
* Target: Q Rise
.measure tran Tpcq_Rise 
+ TRIG v(CLK) VAL={VREF} RISE=1 
+ TARG v(Q)   VAL={VREF} RISE=1

* B. Tpcq (Falling) - Delay when Q goes High->Low
* Trigger: Clock Rise at 15ns
* Target: Q Fall
.measure tran Tpcq_Fall 
+ TRIG v(CLK) VAL={VREF} RISE=2 
+ TARG v(Q)   VAL={VREF} FALL=1

* C. Average Tpcq
.measure tran Tpcq_Total param='(Tpcq_Rise + Tpcq_Fall)/2'

.control
run
plot v(CLK)+4 v(D)+2 v(Q) title 'Jai Srikar M 2024102041 DFF Tpcq Pre-Layout'

print Tpcq_Rise Tpcq_Fall Tpcq_Total
.endc
.end