# CIC-353 | Operating Systems LAB

## Table of Contents

- [Introduction](#introduction)
- [Installation](#installation)
- [Usage](#usage)
- [Available Programs](#available-programs)
- [License](#license)

## Introduction

This repository is dedicated to the CIC-353 [Operating Systems LAB](./Resources/List%20of%20Experiments.pdf) course instructed by Ms. Kavita Saxena. The course covers various fundamental and advanced topics in operating systems, including process scheduling, memory management, file organization, and synchronization problems.

## Installation

1. Clone the repository:

   ```sh
   git clone https://github.com/amit712singhal/OS_LAB.git
   ```

2. Navigate to the project directory:

   ```sh
   cd OS_LAB
   ```
   
## Usage

- To compile and run any of the C programs, use the following commands:

1. Compile the program (e.g., First-Come-First-Serve Scheduling):

   ```sh
   gcc prg_03_fcfs-scheduling.c -o a
   ```

2. Run the compiled program:

   ```sh
   ./a
   ```

- To compile and run any of the shell scripts, use the following commands:

1. Make the script executable:

   ```sh
   chmod +x prg_06_basicOperations.sh
   ```

2. Run the script:

   ```sh
   ./prg_06_basicOperations.sh
   ```
   
## Available Programs

1. **Basic Programs:**
   - `prg_01_helloWorld.c` & `prg_05_helloWorld.sh` - Basic "Hello World" Program
   - `prg_02.1/02.2_basicOperations.c` & `prg_06_basicOperations.sh` - Basic Operations in C

2. **Process Scheduling:**
   - `prg_03_fcfs-scheduling.c` & `prg_07_fcfs-scheduling.sh` - First-Come-First-Serve (FCFS) Scheduling
   - `prg_04.1_sjf-scheduling (non-preemptive).c` & `prg_08.1_sjf-scheduling (non-preemptive).sh`- Shortest Job First (Non-Preemptive)
   - `prg_04.2_sjf-scheduling (preemptive).c` & `prg_08.2_sjf-scheduling (preemptive).sh` - Shortest Job First (Preemptive)
   - `prg_09_priorityScheduling.sh` - Priority Scheduling
   - `prg_10_roundRobin-scheduling.sh` - Round-Robin Scheduling

3. **Memory Management:**
   - `prg_11.1_FIFO-Page-Replacement.sh` - FIFO Page Replacement Algorithm
   - `prg_11.2_optimal-Page-Replacement.sh` - Optimal Page Replacement Algorithm
   - `prg_11.3_LRU-Page-Replacement.sh` - Least Recently Used (LRU) Page Replacement Algorithm

4. **Memory Allocation:**
   - `prg_12.1_first-fit.sh` - First-Fit Memory Allocation
   - `prg_12.2_best-fit.sh` - Best-Fit Memory Allocation
   - `prg_12.3_worst-fit.sh` - Worst-Fit Memory Allocation

5. **Synchronization Problems:**
   - `prg_13_reader-writer.sh` - Reader-Writer Synchronization Problem
   - `prg_14_producer-consumer.sh` - Producer-Consumer Problem
   - `prg_15_bankersAlgo.sh` - Banker's Algorithm for Deadlock Avoidance

6. **File Organization:**
   - `prg_16_fileOrganizations.c` - File Organization Techniques

## License

This repository is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.
