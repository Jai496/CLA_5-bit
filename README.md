# Pipelined 5-bit Manchester Carry Lookahead Adder

A transistor-level implementation of a pipelined 5-bit Manchester Carry Lookahead (CLA) Adder designed in **TSMC 180 nm CMOS**. The project includes schematic design, physical layout, post-layout verification, and FPGA-based hardware validation.

---

## Features

- Transistor-level CMOS implementation
- Manchester Carry Lookahead architecture
- Pipeline implementation for higher throughput
- Custom physical layout using Magic
- Post-layout parasitic extraction
- FPGA validation with oscilloscope measurements

---

## Tools Used

- Magic VLSI
- NgSpice
- Verilog
- Xilinx Vivado
- Oscilloscope

---

## Design Flow

1. Designed transistor-level CLA schematic
2. Simulated functionality in NgSpice
3. Created physical layout in Magic
4. Performed DRC and LVS
5. Generated extracted netlist
6. Verified post-layout performance
7. Implemented design on FPGA
8. Validated outputs using oscilloscope

---

## Results

### Performance

| Metric | Pre-layout | Post-layout |
|---------|-----------:|------------:|
| Logic Delay | 70.7 ps | 78.6 ps |
| Maximum Frequency | 3.69 GHz | 3.59 GHz |
| Critical Path Delay | 270.8 ps | — |

### Hardware Validation

- Successfully implemented on FPGA
- Functional correctness verified using Verilog testbenches
- Oscilloscope measurements confirmed timing behavior
- Post-layout simulations closely matched schematic simulations

---


## Future Improvements

- Scale to 32-bit architecture
- Port to lower technology nodes
- Perform power optimization

---

## Author

**Jai Srikar Medarametla**
