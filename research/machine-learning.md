---
title: Machine Learning for High-Fidelity LES
parent: Research
nav_order: 1
permalink: /research/machine-learning/
---

# Machine Learning for High-Fidelity Large Eddy Simulation

## Hydrogen Combustion

Large Eddy Simulation (LES) plays a key role in the design of new combustion chambers for robust and safe combustion of carbon-free fuels such as H2. It is a very efficient method which consists of filtering and modeling small-scale flow physics that would otherwise be very computationally expensive to resolve. However, the high molecular diffusion of H2 challenges subfilter-scale modeling for lean premixed mixtures. This work establishes a framework for data-driven machine learning modeling of LES burning rates, enabling high-fidelity simulation of hydrogen combustion systems that are essential for achieving a low-carbon economy.

The data-driven approach leverages a Convolutional Neural Network (CNN), trained to approximate filtered burning rates from emulated LES data. From emulated LES fields, a CNN has been trained to estimate the LES burning rates based on known LES scalars. Once trained, the model was found to approximate the burning rates on solutions never seen during training with high accuracy. In addition, the model was able to approximate burning rates on filter sizes and equivalence ratios other than those used for training.

More details in this [journal publication](https://doi.org/10.1017/dce.2025.1). The training database is available on Kaggle via [BLASTNet](https://www.kaggle.com/organizations/blastnet).

<p align="center">
<img src="/assets/images/research/MLH2_diagram.png" alt="" style="width:700px; max-width:100%; height:auto;"><br>
<em>Figure CNN-H2: Diagram of the strategy used to generate data and train the CNN. More details in this <a href="https://doi.org/10.1017/dce.2025.1">journal publication</a>.</em>
</p>

<div markdown="0" style="max-width: 800px; margin: 0 auto; display: flex; align-items: center; gap: 20px;">
  <div style="flex: 0 0 25%;">
    <img src="/assets/images/logos/logo_SNSF.PNG" style="width: 100%; height: auto; display: block;">
  </div>
  <div style="flex: 1 1 auto;">
    This research was funded in part by the Swiss National Science Foundation (SNSF) under grant agreement No. 219938.
  </div>
</div>
<div markdown="0" style="max-width: 800px; margin: 0 auto; display: flex; align-items: center; gap: 20px;">
  <div style="flex: 0 0 30%;">
    <img src="/assets/images/logos/CSCS.jpg" style="width: 100%; height: auto; display: block;">
  </div>
  <div style="flex: 1 1 auto;">
    This work was supported by a grant from the Swiss National Supercomputing Centre (CSCS) under project ID s1262.
  </div>
</div>
