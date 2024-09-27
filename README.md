# Assembly-Powered Calculator

This project is a simple calculator developed in **Pascal**, where all the processing and arithmetic operations are performed using **x86 Assembly**. The goal of this project is to demonstrate the integration of a high-level language (Pascal) with low-level assembly code, optimizing operations at the hardware level for better performance and control.

## Features
- **Basic Arithmetic Operations**: Supports addition, subtraction, multiplication, and division.
- **Assembly-Optimized Processing**: All the calculations are done using x86 assembly instructions, ensuring efficient CPU utilization.
- **Pascal Interface**: The user interface is written in Pascal, providing a simple text-based interaction for users.
- **Error Handling**: Handles basic arithmetic errors, such as division by zero.

## How It Works
The calculator is written in Pascal, which is responsible for:
- Taking user input.
- Displaying results.
- Handling user interaction.

All arithmetic operations (addition, subtraction, multiplication, division and more) are offloaded to x86 Assembly code. The Pascal code calls these assembly routines for processing. This hybrid approach combines the simplicity of Pascal with the power and speed of Assembly for handling low-level operations directly on the CPU.

