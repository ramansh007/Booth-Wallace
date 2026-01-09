# Pipelined 8-bit Signed Booth-Wallace Tree Multiplier (Radix-4)

## 📌 Overview

This repository contains an optimized hardware implementation of a **Signed 8x8-bit Multiplier** using **Radix-4 Booth Encoding**. The design features **Sign Extension Elimination** to reduce hardware complexity and utilizes a **Wallace Tree** structure for high-speed partial product reduction.

The design includes input/output pipelining to ensure high-speed timing closure and clean signal paths.

## 🚀 Key Features

- **Radix-4 Booth Encoding:** Reduces the partial product count from 8 to 4, halving the adder tree depth.
- **Signed Arithmetic:** Natively handles 2's complement numbers.
- **Wallace Tree Reduction:** Replaces standard ripple-carry addition with a parallel reduction tree (Full/Half Adders) to compress 4 rows into 2 rows (Sum & Carry).
- **Sign Extension Elimination:** Uses the "Inverse Sign" ($\bar{S}$) and "Hot 1" matrix trick to avoid full 16-bit sign extension for every row, saving logic resources.
- **Pipelined Architecture:** A 2-stage pipeline (Input Register $\to$ Logic $\to$ Output Register) ensures short critical paths.

---

## 🏗️ Architecture

The design is modular, separating the encoding logic from the summation logic.

**Block Hierarchy:**

1.  **`Top`:** The wrapper module handling clocking, reset, and I/O registration.
2.  **`DFF`:** Input pipeline stage to buffer `A` and `B` operands.
3.  **`Partial_Products`:** Instantiates 4 parallel **Booth Encoders** to generate partial product rows.
4.  **`Partial_Products_Adder`:** Implements a **Wallace Tree** to reduce the rows and a **Carry Lookahead Adder (CLA)** for the final sum.

![Design Hierarchy](Docs/RTL.png)
_Figure 1: Synthesis Hierarchy showing the modular structure._

---

## 🧠 Algorithm Details

### 1. Radix-4 Booth Encoding

Instead of processing one bit at a time, we process 3 bits of the multiplier ($B_{i+1}, B_i, B_{i-1}$) to determine the operation on the multiplicand ($A$).

| Multiplier Bits | Operation | Description               |
| :-------------- | :-------- | :------------------------ |
| **000, 111**    | $+0$      | Zero                      |
| **001, 010**    | $+A$      | Add Multiplicand          |
| **011**         | $+2A$     | Shift Left (x2)           |
| **100**         | $-2A$     | Shift Left, Invert, Add 1 |
| **101, 110**    | $-A$      | Invert, Add 1             |

### 2. Sign Extension Elimination

Standard multiplication requires sign-extending every partial product to the final width (16 bits), which wastes adder bits. This design uses the optimization constants ($\bar{S}$, $1$) placed in the MSB positions to emulate sign extension without the physical wires.

![Booth Algorithm Dot Diagram](Docs/Sign%20Extention%20Elimination.png)
_Figure 2: Radix-4 Dot Diagram illustrating the partial product alignment and sign extension strategy._

### 3. Wallace Tree Reduction

The addition of the four partial product rows is handled by a **Wallace Tree**, which operates in parallel stages to minimize propagation delay:

1.  **Stage 1 (Reduction):** The 4 partial product rows are grouped by column weight. Full Adders (3-to-2 compression) and Half Adders (2-to-2 compression) reduce the 4 rows down to 3.
2.  **Stage 2 (Compression):** A second layer of adders further reduces the 3 rows down to just 2 final vectors: a **Sum Vector** and a **Carry Vector**.
3.  **Final Addition:** A 16-bit **Carry Lookahead Adder (CLA)** sums the final two vectors to produce the result. This avoids the long carry-propagation delay of ripple carry adders.

---

## 📊 Simulation Results

The design was verified using a self-checking testbench covering corner cases (Max Positive, Max Negative, Zero).

**Waveform Analysis:**
The simulation confirms correct signed multiplication with a **Cycle latency** (Input Reg $\to$ Output Reg).

![Simulation Waveform](Docs/RTL%20Simulation.png)
_Figure 3: Post-Synthesis Verification._

**Test Cases:**

- $4 \times 5 = 20$
- $10 \times -2 = -20$ (Mixed Sign)
- $-10 \times -10 = 100$ (Negative $\times$ Negative)
- $127 \times 127 = 16129$ (Max Positive)
- $-128 \times 1 = -128$ (Max Negative)
