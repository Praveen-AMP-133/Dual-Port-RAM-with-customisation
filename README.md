# Dual Port RAM with Status Flags (Verilog)

## 📌 Overview

This project implements a **Dual-Port RAM** in Verilog with separate read and write ports.
The design also includes basic **status flags** such as:

* Full
* Empty
* Almost Full
* Almost Empty

This project is intended for **RTL Design and Design Verification beginners** to understand memory design and basic control logic.

---

## ⚙️ Features

* Dual-port RAM with independent read and write ports
* Address-based memory access
* Simple occupancy tracking using valid bits
* Status flag generation
* Fully parameterized design

---

## 🧱 Module Parameters

| Parameter           | Description                | Default |
| ------------------- | -------------------------- | ------- |
| DEPTH               | Number of memory locations | 8       |
| WIDTH               | Data width                 | 8       |
| ALMOST_FULL_THRESH  | Threshold for almost full  | DEPTH-1 |
| ALMOST_EMPTY_THRESH | Threshold for almost empty | 1       |

---

## 🔌 Port Description

### Inputs

* `clk_a` : Write clock
* `addr_a` : Write address
* `clk_b` : Read clock
* `addr_b` : Read address
* `wr_en_a` : Write enable
* `rd_en_b` : Read enable
* `din` : Input data

### Outputs

* `dout` : Output data
* `full` : Indicates memory is full
* `empty` : Indicates memory is empty
* `almost_full` : Indicates memory is nearly full
* `almost_empty` : Indicates memory is nearly empty

---

## 🧠 Design Concept

* Memory is implemented as a register array.
* Each location has an associated **valid bit** to track whether it contains usable data.
* A counter keeps track of the number of valid entries.
* Status flags are generated based on the counter value.

---

## 🧪 Testbench

The included testbench:

* Generates separate clocks for read and write
* Performs continuous write and read operations
* Automatically increments addresses and input data
* Displays memory activity and status flags using `$monitor`

Waveforms are dumped into a `.vcd` file for viewing.

---

## ▶️ Simulation

### Using Icarus Verilog

```bash id="sim001"
iverilog -o dual_port_ram tb_dual_port_ram.v dual_port_ram.v
vvp dual_port_ram
gtkwave dual_port_ram.vcd
```

---

## 📊 Expected Behavior

* Data is written to memory when `wr_en_a` is asserted
* Data is read from memory when `rd_en_b` is asserted
* `full` is asserted when all memory locations contain valid data
* `empty` is asserted when no valid data is present
* `almost_full` and `almost_empty` indicate near-boundary conditions

---

## 🎯 Learning Objectives

This project helps beginners understand:

* Dual-port memory design
* Parameterized RTL coding
* Status flag generation
* Basic verification using testbenches
* Waveform analysis

---

## 🚀 Possible Extensions

* Add constrained-random testbench
* Introduce assertions
* Convert to SystemVerilog
* Build a FIFO using similar concepts

---

## 👨‍💻 Author

Devarala Praveen Kumar

---

## 📄 License

This project is open-source and available under the MIT License.
