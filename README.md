# NSCOM03-Simulation-CaseStudy

This repository contains Python scripts for simulating digital modulation and demodulation techniques, along with supplementary files including a MATLAB script and PCAP files for Wireshark analysis.

**Team Members**
1. Aperin, Johanna
2. Elloso, Jilliane
3. Tan, Jiliana

**Files Included:**

1. **server.py**: This Python script serves as the server-side implementation for simulating the modulation and transmission of digital signals using Amplitude Shift Keying (ASK) and Frequency Shift Keying (FSK) techniques. It establishes a TCP/IP socket, generates modulated signals, and sends them to connected clients.

2. **client.py**: This Python script complements the server-side functionality by connecting to the server, receiving the modulated signals, and visualizing them for analysis. It establishes a TCP/IP socket, receives signals from the server, and plots them using Matplotlib.

3. **modulation_simulation.m**: This MATLAB script provides an alternative simulation environment . It contains functions for simulating ASK and FSK modulation and demodulation.

4. **wireshark_capture.pcap**: This PCAP file contains captured network packets exchanged during the communication between the server and client scripts. 

**Usage:**

1. Clone the repository to your local machine using Git:

```bash
git clone https://github.com/yourusername/ModulationSimulation.git
```

2. Run the `server.py` script to initiate the server-side simulation:

```bash
python server.py
```

3. Run the `client.py` script to connect to the server, receive modulated signals, and visualize them:

```bash
python client.py
```

4. Additionally, you can explore the `CaseStudy.m` MATLAB script for an alternative simulation environment using MATLAB.

5. Analyze the `wireshark_capture.pcap` file using Wireshark to inspect the captured network packets and validate the communication between the server and client.

**Dependencies:**

- Python 3.x
- NumPy
- Matplotlib
