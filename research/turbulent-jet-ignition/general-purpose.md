---
title: General purpose
parent: Turbulent Jet Ignition
grand_parent: Research
nav_order: 1
permalink: /research/turbulent-jet-ignition/general-purpose/
---

# General purpose

Turbulent Jet Ignition (TJI) is the process of ignition of a flammable atmosphere by a high-speed jet of hot gas. The process of ignition of cold streams by jets of hot burnt gas is critical in many applications including flameproof enclosures, reciprocating engines, wave rotor engines or pulse detonation engines. The ability to predict ignition success or failure of the flammable mixture in which the hot burnt gas jets penetrate is critical for the design of the ducted jets. Three-dimensional, kinetically detailed Direct Numerical Simulations (DNS) have been performed to investigate the ignition process of a cold lean premixed mixture at atmospheric conditions by a jet of hot burnt gas that may be cooled before injection. DNS allowed a parametric study of the impact of the jet injection speed and temperature on the ignition process and provided data to build and test models for jet ignition. Figure DNS-TJI depicts the simulated ignition sequences. More details in this [journal publication](https://doi.org/10.1016/j.combustflame.2020.09.017).

<p align="center">
<img src="/assets/images/research/DNS_TJI.png" alt="" style="width:600px"><br>
<em>Figure DNS-TJI: Direct Numerical Simulation (DNS) of Turbulent Jet Ignition (TJI). Planar cut in the jet axis colored by the Heat Release Rate (HRR) with three isolines of temperature. Jet injection bulk velocity = 150.0 m/s. Atmospheric conditions.</em>
</p>

Based on the DNS results, a zero-dimensional Lagrangian model has been developed where a small element of the jet burnt gas mixes at a certain rate with the fresh gas while it potentially ignites, in order to predict the outcome of a jet ignition sequence (success or failure). This model is a good candidate to assess the ignition of a flammable atmosphere at a low computational cost. Figure COR illustrates how the model works. More details in this [journal publication](https://doi.org/10.1016/j.combustflame.2020.09.017).

<p align="center">
<img src="/assets/images/codes/COR_illustration.png" alt="" style="width:500px"><br>
<em>Figure COR: Sketch of the Convected Open Reactor (COR) model to predict the outcome of the ignition of an atmosphere by a jet of hot burnt gas. The code of the model is available in the <a href="/codes/">code section</a>.</em>
</p>

<div markdown="0" style="max-width: 800px; margin: 0 auto; display: flex; align-items: center; gap: 20px;">
  <div style="flex: 0 0 10%;">
    <img src="/assets/images/logos/PRACE.png" style="width: 100%; height: auto; display: block;">
  </div>
  <div style="flex: 1 1 auto;">
    We acknowledge PRACE for awarding us access to Irene at the "Très Grand Centre de calcul du Commissariat à l'énergie atomique et aux énergies alternatives" (TGCC), France (project ID 2019204881).
  </div>
</div>
