# 28nm HKMG NMOS: DC Calibration & AC Characterization

## Project Overview
This project involves the full physics-based characterization of a **28nm High-K Metal Gate (HKMG)** NMOS transistor using Synopsys Sentaurus TCAD. The simulation workflow demonstrates a professional "calibration-first" approach:
1.  **DC Calibration:** Matching simulated I-V curves against a reference PDK model to verify physical parameters.
2.  **AC Analysis:** Performing Small-Signal analysis to extract frequency-dependent C-V characteristics.

## Key Technical Features
* **Technology:** 28nm Planar NMOS with HfO2 High-K Dielectric.
* **Physics Models:**
    * **Mobility:** Philips Unified Mobility (PhuMob) with Enormal dependence.
    * **Quantization:** Density Gradient (eQuantumPotential) for accurate inversion layer modeling.
    * **Tunneling:** Trap-Assisted Tunneling (TAT) for leakage current analysis.

## Simulation Results

### 1. Device Structure & Doping
The device features a 28nm gate length with **Halo Implants** and **Source/Drain Extensions (LDD)** to mitigate Short Channel Effects.
![Device Structure](results/NMOS_Structure.png)

*Zoomed-in view of the High-K Gate Stack and Channel Doping:*
![Doping Zoom](results/NMOS_Doping_Zoom.png)

### 2. DC Model Calibration
The simulation results (Red) show excellent agreement with the reference PDK model (Black), validating the input deck calibration.

| Transfer Characteristics ($I_d-V_g$) | Output Characteristics ($I_d-V_d$) |
| :---: | :---: |
| ![IdVg](results/NMOS_IdVg.png) | ![IdVd](results/NMOS_IdVd.png) |
| *Matching threshold voltage ($V_{th}$) and subthreshold slope* | *Accurate saturation region behavior* |

### 3. AC Characterization (C-V)
Small-Signal AC analysis (1 MHz) was performed to extract the Gate Capacitance ($C_{gg}$). The curve clearly validates the High-K dielectric stack performance across **Accumulation**, **Depletion**, and **Inversion** regions.
![CV Curve](results/NMOS_CV_Curve.png)

## Repository Structure
* `src/`: Sentaurus Input Decks.
    * `sde_des.cmd`: Structure generation (Scheme).
    * `sdevice_des.cmd`: Physics simulation and Sweep definitions.
    * `sdevice.par`: Calibrated material parameters.
* `scripts/`: Tcl scripts for visualization and data extraction.
* `results/`: Simulation plots and device visualizations.
