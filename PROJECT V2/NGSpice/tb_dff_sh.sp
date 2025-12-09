* Final Corrected DFF Testbench
* Author: Jai Srikar 2024102041

* 1. Include Netlist
.include dff.cir

* 2. Parameters
.param LAMBDA=0.09u
.param VDD_VAL=1.8V
.param RISE_FALL=0.05ns
.param VREF=0.9V

* 3. Power
Vvdd vdd 0 DC {VDD_VAL}

* 4. Stimulus

* CLOCK: Start Low. Rise at 10ns.
* (Old incorrect code had delay 0ns. This uses 10ns).
Vclk CLK 0 PULSE(0 {VDD_VAL} 10ns {RISE_FALL} {RISE_FALL} 10ns 20ns)

* DATA: Rises at 5ns.
* Since Clock is at 10ns, Setup Margin = 5ns (Positive).
Vd D 0 PWL(
+ 0ns     0
+ 0ns     0
+ 0.05ns  {VDD_VAL}
+ 17ns    {VDD_VAL}
+ 17.05ns 0
)

* 5. DUT
Xdut D CLK Q vdd 0 dff_pos N='20*LAMBDA'

* 6. Analysis
.tran 1ps 25ns

* 7. Measurements

* Setup Time
* Trigger on Data Rise (5ns). Target on Clock Rise (10ns).
* Expect: +5.0ns
.measure tran T_Setup TRIG v(D) VAL={VREF} RISE=1 TARG v(CLK) VAL={VREF} RISE=1

* Hold Time
* Trigger on Clock Rise (10ns). Target on Data Fall (17ns).
* Expect: +7.0ns
.measure tran T_Hold TRIG v(CLK) VAL={VREF} RISE=1 TARG v(D) VAL={VREF} FALL=1

.control
run
plot v(CLK)+2 v(D)+1 v(Q) title 'Corrected Setup/Hold Timing'
print T_Setup T_Hold
.endc
.end