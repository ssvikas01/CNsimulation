# Energy-Aware Routing Protocol for Wireless Sensor Networks (WSNs)

![Python 3.12+](https://img.shields.io/badge/python-3.12%2B-blue.svg)
![Tests: 239 Passed](https://img.shields.io/badge/tests-239%20passed-success.svg)
![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)
![GUI: Streamlit](https://img.shields.io/badge/GUI-Streamlit-FF4B4B.svg)

A Python-based simulation environment for modeling, analyzing, and comparing **Shortest-Path (Dijkstra)** and **Residual-Energy-Aware** routing protocols in Wireless Sensor Networks (WSNs).

---

## 📌 Research Question & Objective

> **"Does incorporating residual node energy into multi-hop routing decisions increase wireless sensor network operational lifetime compared with conventional shortest-path routing under strictly identical topological and traffic conditions?"**

### Core Highlights & Capabilities:
* **Topology Generator:** Generates 2D random geometric graphs with customizable node density, communication range, and base station coordinates.
* **First-Order Radio Model:** Implements realistic transmitter and receiver energy dissipation ($E_{elec}$, $E_{amp} \cdot d^2$).
* **Dual Routing Engine:**
  * **Shortest-Path Routing:** Traditional Dijkstra minimizing Euclidean distance.
  * **Energy-Aware Routing:** Weighted composite cost function:
    $$\text{Cost}(u, v) = \alpha \cdot \frac{\text{dist}(u,v)}{d_{max}} + \beta \cdot \left(1 - \frac{E_{residual}(v)}{E_{initial}(v)}\right)$$
* **Comprehensive Metrics:** Tracks FND, HND, LND, PDR, average hop count, total energy consumed, and packet loss.
* **Paired Comparative Experiments:** Eliminates topological variance by evaluating competing algorithms across identical pseudo-random seeds.
* **Interactive Streamlit GUI:** Web interface for parameter tuning, real-time simulation runs, side-by-side comparison charts, and JSON data export.
* **Test Suite:** 239 automated unit and integration tests passing with 0 warnings.

---

## 📊 Key Evaluation Metrics

| Metric | Name | Definition & Research Relevance |
| :--- | :--- | :--- |
| **FND** | **First Node Death** | The simulation round when the first sensor depletes its battery. Defines the network **stability period** (guaranteed full sensor coverage). |
| **HND** | **Half Node Death** | The round when $\le 50\%$ of sensors remain operational. Measures network operational half-life. |
| **LND** | **Last Node Death** | The round when all sensors are exhausted. Marks total network extinction. |
| **PDR** | **Packet Delivery Ratio** | Ratio of successfully delivered packets to generated packets ($\text{Delivered} / \text{Generated}$). |
| **Hop Count** | **Average Path Length** | Mean number of intermediate forwarding hops per delivered packet. |

---

## 🚀 Quick Start Guide

### 1. Installation

```bash
# Clone the repository
git clone https://github.com/ssvikas01/CNsimulation.git
cd CNsimulation

# Create & activate a virtual environment
python -m venv .venv
# On Windows:
.venv\Scripts\activate
# On Linux/macOS:
source .venv/bin/activate

# Install dependencies (including Streamlit GUI & testing tools)
pip install -r requirements.txt
pip install -r requirements-dev.txt
pip install -e .
```

---

### 2. Running on Windows (One-Click)

* **Interactive Menu Launcher:** Double-click **`run_menu.bat`** to access an interactive terminal menu:
  * `[1]` Launch Streamlit Web GUI
  * `[2]` Run Single CLI Simulation
  * `[3]` Run Paired Comparison Experiment
  * `[4]` Run Full Test Suite (pytest)
* **Direct Dashboard Launcher:** Double-click **`start_dashboard.bat`** to boot directly into the Streamlit Web GUI.

---

### 3. Running via Command Line (CLI)

```bash
# Launch the Interactive Streamlit Web GUI (Recommended)
streamlit run src/energy_routing/dashboard.py

# Or run via Python module
python -m energy_routing.main gui

# Run single simulation with default config (configs/base.yaml)
python -m energy_routing.main run --config configs/base.yaml

# Run paired routing comparison experiment (Shortest-Path vs Energy-Aware across 5 seeds)
python -m energy_routing.main experiment --name routing_comparison --base-config configs/base.yaml

# List all available experiment suites
python -m energy_routing.main list-experiments

# Run the full automated test suite (239 tests)
pytest tests/ -v
```

---

### 4. Linux / macOS Convenience Script

```bash
chmod +x run.sh

./run.sh gui         # Launch Streamlit GUI
./run.sh run         # Run default simulation
./run.sh experiment  # Run comparison experiment
./run.sh test        # Run test suite
```

---

## 🖥️ Interactive Web Dashboard Preview

The Streamlit web interface provides three main operating sections:

```
+-----------------------------------------------------------------------------------+
|              Energy-Aware Routing Protocol Simulator (Streamlit GUI)               |
+-----------------------------------------------------------------------------------+
|  [Tab A: Run Simulation]   |  [Tab B: Compare Algorithms]  |  [Tab C: Saved Data] |
+-----------------------------------------------------------------------------------+
|  - Slider controls for node count, range (m), initial energy (J), rounds, seed   |
|  - Real-time degradation curves (Alive nodes vs. rounds, Energy depletion)        |
|  - Scorecards for FND, HND, LND, and Packet Delivery Ratio (PDR)                  |
|  - Paired win/loss comparison table across multiple pseudo-random seeds           |
|  - One-click JSON data export and reload capabilities                             |
+-----------------------------------------------------------------------------------+
```

---

## 📁 Repository Structure

```
CNsimulation/
├── configs/                 # YAML configuration files (base.yaml, small.yaml, large.yaml)
├── docs/                    # Technical & scientific documentation
│   ├── ALGORITHM.md         # Detailed routing cost and energy formulas
│   ├── ARCHITECTURE.md      # Modular architecture & class relationships
│   ├── ENERGY_MODEL.md      # Radio energy equations & worked examples
│   ├── EXPERIMENTS.md       # Experimental protocols & hypothesis testing
│   └── LIMITATIONS.md       # Assumptions & physical simplifications
├── results/                 # Simulation logs & JSON result archives
├── scripts/                 # Sensitivity and parameter optimization scripts
├── src/energy_routing/      # Core Python package
│   ├── models/              # Dataclasses: Node, Packet, SimulationResult
│   ├── network/             # Graph construction & topology generators
│   ├── routing/             # Dijkstra & Energy-Aware pathing algorithms
│   ├── simulation/          # Event loop, round stepping & radio energy model
│   ├── metrics/             # Collectors for FND, HND, LND, and PDR
│   ├── visualization/       # Matplotlib charts & network topology plots
│   └── dashboard.py         # Streamlit Web GUI implementation
├── tests/                   # 239 automated unit & integration tests
├── pyproject.toml           # Package metadata & build configuration
├── requirements.txt         # Production dependencies
├── run_menu.bat             # Interactive Windows terminal launcher
├── start_dashboard.bat      # Quick Windows dashboard script
└── run.sh                   # Linux / macOS shell wrapper
```

---

## 🔬 Experimental Findings Summary

Based on controlled comparisons across 10 independent random network topologies ($N = 50$ nodes, $R = 20\text{ m}$, $E_0 = 1.0\text{ J}$):
1. **Prolonged Stability Period:** Energy-Aware routing consistently delays **First Node Death (FND)** by routing packets around heavily loaded or low-battery nodes, avoiding the premature creation of "energy holes" around the base station.
2. **Trade-off in Path Length:** Incorporating residual energy slightly increases the average hop count ($\sim 10-15\%$ longer paths), which is compensated by balanced node depletion.
3. **High Reliability:** Packet Delivery Ratio (PDR) remains near $100\%$ throughout the network stability phase.

---

## 📜 License

This project is licensed under the **MIT License** — feel free to use and extend for academic and research purposes.
