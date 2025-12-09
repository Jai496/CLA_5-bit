* Complete Testbench: Manchester Adder (Plots + Calculations)
* Author: Jai Srikar M

* 1. Load Circuit
.include full_layout.cir
.include TSMC_180nm.txt

* 2. Parameters
.param VDD_VAL=1.8V
.param VREF=0.9V
.global gnd vdd

* 3. Power
Vdd_src vdd 0 {VDD_VAL}


* 4. Stimulus: WORST CASE RIPPLE
* Operation: 31 (11111) + 1 (00001) = 32 (00000, Cout=1)
* This toggles every Sum bit (1->0) and the Carry Out (0->1).
* Perfect for visualizing activity and measuring worst-case delay.

* Clock: 20ns Period. Rises at 10ns, 30ns.
V_clk clock_in 0 PULSE(0 {VDD_VAL} 0ns 0.1ns 0.1ns 10ns 20ns)

* Input A: 00001 (A1 toggles at 5ns)
V_qa1 q_a1 0 PULSE(0 {VDD_VAL} 5ns 0.1ns 0.1ns 100ns 200ns)
V_qa2 q_a2 0 0
V_qa3 q_a3 0 0
V_qa4 q_a4 0 0
V_qa5 q_a5 0 0

* Input B: 11111 (All High)
V_qb1 q_b1 0 {VDD_VAL}
V_qb2 q_b2 0 {VDD_VAL}
V_qb3 q_b3 0 {VDD_VAL}
V_qb4 q_b4 0 {VDD_VAL}
V_qb5 q_b5 0 {VDD_VAL}
V_cin carry_0 0 0

* Loads
Cload_s1 s1 0 10f
Cload_s2 s2 0 10f
Cload_s3 s3 0 10f
Cload_s4 s4 0 10f
Cload_s5 s5 0 10f
Cload_c5 cout 0 10f

* 5. Analysis
.tran 0.01n 60n

* 6. MEASUREMENTS

* A. Combinational Logic Delay (Clock -> Carry Chain End)
* We measure how long it takes for the internal node 'c5' (Carry Out Logic)
* to rise after the input clock (10ns) launches the data.
* This captures the ripple time.
.measure tran T_Logic_Delay 
+ TRIG v(clock_in) VAL={VREF} RISE=1 
+ TARG v(c5)       VAL={VREF} RISE=1

* B. Tpcq (Clock -> Output Pin)
* We measure the delay of the Output Register.
* Trigger: 2nd Clock Rising (30ns)
* Target:  Output Pin 'cout' Rising
.measure tran Tpcq_Out 
+ TRIG v(clock_in) VAL={VREF} RISE=2 
+ TARG v(cout)     VAL={VREF} RISE=1

* C. Max Frequency Calculation
* Min Clock Period = Logic Delay + Setup Time (Est 0.2ns)
* Note: Tpcq is included in the Logic Delay measurement start point relative to clock.
.measure tran T_Critical param='T_Logic_Delay + 0.2n'
.measure tran F_Max_GHz  param='1/T_Critical'

.control
run
set color0=black
set color1=white

echo "-------------------------------------------------------"
echo "        PERFORMANCE METRICS"
echo "-------------------------------------------------------"
print T_Logic_Delay
print Tpcq_Out
print F_Max_GHz

* --- PLOT 1: Input A (Stacked) ---
plot v(clock_in)+12 v(q_a5)+10 v(q_a4)+8 v(q_a3)+6 v(q_a2)+4 v(q_a1)+2 title 'Input A (00000->00001)'

* --- PLOT 2: Input B (Stacked) ---
plot v(clock_in)+12 v(q_b5)+10 v(q_b4)+8 v(q_b3)+6 v(q_b2)+4 v(q_b1)+2 title 'Input B (11111)'

* --- PLOT 3: Outputs (Stacked) ---
* Expected: Sum bits fall to 0, Cout rises to 1 at 30ns.
plot v(clock_in)+14 v(cout)+12 v(s5)+10 v(s4)+8 v(s3)+6 v(s2)+4 v(s1)+2 title 'Jai Srikar M 2024102041 Pre-Layout 5 bit CLA testing'

.endc
.end