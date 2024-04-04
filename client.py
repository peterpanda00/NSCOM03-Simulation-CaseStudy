import socket
import numpy as np
import matplotlib.pyplot as plt

# Function to plot the received signal
def plot_received_signal(t, received_signal, modulation_type):
    plt.figure()
    plt.plot(t, received_signal)
    plt.title(f"Received Signal ({modulation_type})")
    plt.xlabel("Time (s)")
    plt.ylabel("Amplitude")
    plt.grid(True)
    plt.show()

# Create a TCP/IP socket
client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect the socket to the server
server_address = ('localhost', 12345)
client_socket.connect(server_address)

try:
    # Receive the modulated signals
    received_ask = client_socket.recv(4096)
    received_fsk = client_socket.recv(4096)
    
    # Convert bytes to numpy arrays
    modulated_ask = np.frombuffer(received_ask, dtype=np.float64)
    modulated_fsk = np.frombuffer(received_fsk, dtype=np.float64)
    
    # Define parameters
    sampling_rate = 10
    duration = len(modulated_ask) / sampling_rate
    t = np.linspace(0, duration, len(modulated_ask), endpoint=False)
    
    # Plot the received signals
    plot_received_signal(t, modulated_ask, "ASK")
    plot_received_signal(t, modulated_fsk, "FSK")
    
finally:
    # Clean up the connection
    client_socket.close()
