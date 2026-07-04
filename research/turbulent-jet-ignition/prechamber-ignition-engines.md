---
title: Pre-chamber ignition engines
parent: Turbulent Jet Ignition
grand_parent: Research
nav_order: 2
permalink: /research/turbulent-jet-ignition/prechamber-ignition-engines/
---

# Pre-chamber ignition engines

The Pre-Chamber Ignition (PCI) concept has demonstrated the capability to induce very high burning rates, enabling ultra-lean premixed mixtures to be burnt efficiently in Internal Combustion Engines (ICEs). This is achieved through the creation of multiple highly turbulent jets of hot burnt gas issuing into the main chamber of the engine. However, the design of the ducts connecting pre- and main chamber is very complex: small holes must be used in order to generate enough turbulence in the main chamber, but these small holes can also inhibit ignition of the main chamber because of too high jet cooling and/or speed. This complex optimization problem motivated the research work. Figures LES-TJI-HRR and LES-TJI-AFBF show the advantages of PCI engines over conventional Spark Ignition (SI) engines. More details in my [PhD thesis manuscript](https://hal.archives-ouvertes.fr/tel-03103791).

<p align="center">
<img src="/assets/images/research/LES_SIvsTJI.png" alt="" style="width:600px"><br>
<em>Figure LES-TJI-HRR: Plane cut intersecting the pre-chamber ducts by their axis and colored by the normalized Heat Release Rate (HRR) with three isolines of temperature for both Spark Ignition (SI) and Pre-Chamber Ignition (PCI) engines under the same operating conditions, λ1.5.</em>
</p>

<p align="center">
<img src="/assets/images/research/graph_SIvsTJI.png" alt="" style="width:500px"><br>
<em>Figure LES-TJI-AFBF: Flame surface inside the main chamber A<sup>mc</sup><sub>f</sub> and global Burnt Fraction BF for both Spark Ignition (SI) and Pre-Chamber Ignition (PCI) engines under the same operating conditions, λ1.5.</em>
</p>

A multi-chamber, multi-zone engine model has also been developed to predict the ignition of a lean main chamber by a pre-chamber. The two chambers are connected by small cylindrical holes: the flame is ignited in the pre-chamber, hot gas propagates through the holes and ignites the main chamber through Turbulent Jet Ignition (TJI). The model's original features are: (i) separate balance equations for the pre- and main chambers, (ii) a specific model for temperature and composition evolution in the holes, and (iii) a DNS-based model to predict the ignition of the main chamber fresh gas by the burnt gas turbulent jets exiting the holes. Incorporating this DNS information into the engine model allows prediction of whether ignition will occur, information which is not otherwise accessible using simple models. The resulting approach has been tested on multiple cases to predict ignition limits for very lean cases, effects of hydrogen injection into the pre-chamber, and optimum hole size as a function of equivalence ratio. More details in this [journal publication](https://doi.org/10.1177/14680874211015002).

<p align="center">
<img src="/assets/images/codes/engine_sketch.png" alt="" style="width:520px"><br>
<em>Figure PEMIP: Sketch of the Pre-chamber Engine Model with Ignition Prediction (PEMIP) multi-zone engine model for pre-chamber engines. The code of the model is available in the <a href="/codes/">code section</a>.</em>
</p>

<div markdown="0" style="max-width: 800px; margin: 0 auto; display: flex; align-items: center; gap: 20px;">
  <div style="flex: 0 0 25%;">
    <img src="/assets/images/logos/GENCI.png" style="width: 100%; height: auto; display: block;">
  </div>
  <div style="flex: 1 1 auto;">
    This work was granted access to the high-performance computing resources of TGCC ("Très Grand Centre de calcul du Commissariat à l'énergie atomique et aux énergies alternatives") under the "Grand Challenge" (early access program) allocation number gch0301 attributed by GENCI ("Grand Équipement National de Calcul Intensif").
  </div>
</div>
