# Floating-Point Multiplier IEEE754

## 📌 Overview
This repository contains the implementation of a **floating-point multiplier** compliant with the **IEEE754** single-precision standard. The project efficiently handles normalized and denormalized operands, as well as special values such as **NaN (Not a Number), infinity, and zero** through a **pipelined architecture**.

## ✨ Features
- ✅ Supports single-precision **IEEE754 floating-point multiplication**
- ✅ **Pipelined architecture** for optimized performance
- ✅ **Handling of edge cases**: zero, infinity, NaN, overflow, and underflow
- ✅ Fully tested with a **comprehensive test bench**

## 🚀 Getting Started
### Prerequisites
Ensure you have the following installed:
- **Vivado/Xilinx ISE** (for VHDL/Verilog development)
- **A simulator** for design verification
- **Basic knowledge** of floating-point arithmetic and hardware design

### Installation
Clone this repository using:
```bash
$ git clone https://github.com/MattiaBrianti/PFRL_Floating-point-multiplier-IEEE754.git
```

## 🛠️ How It Works
The system is divided into **three main stages**:
1. **Prep Stage**: Input processing and special case detection.
2. **Calc Stage**: Exponent handling and mantissa multiplication.
3. **Output Stage**: Normalization and result computation.

## 🧪 Testing
The project has been tested using multiple **edge cases**, ensuring correct functionality:
- 🔹 **Standard multiplications**
- 🔹 **Special numbers handling (NaN, zero, infinity)**
- 🔹 **Overflow and underflow conditions**

## 🏆 Evaluation
This project received a final grade of **30 cum laude**.

## 🤝 Authors
- **[Mattia Brianti](https://github.com/MattiaBrianti)**
- **[Alex Hathaway](https://github.com/Alexhath)**

## 📜 License
This project is released under the **MIT License**. Feel free to use and modify it following the license terms.


