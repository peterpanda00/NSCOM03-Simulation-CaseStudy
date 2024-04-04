import socket
import numpy as np
import matplotlib.pyplot as plt

# Function to modulate the signal using ASK
def ask_modulation(binary_input, carrier_freq, sampling_rate, duration):
    t = np.linspace(0, duration, int(duration * sampling_rate), endpoint=False)
    carrier_wave = np.sin(2 * np.pi * carrier_freq * t)
    signal = np.zeros_like(t)
    for i, bit in enumerate(binary_input):
        if bit == '1':
            signal += carrier_wave
    return t, signal

# Function to modulate the signal using FSK
def fsk_modulation(binary_input, freq0, freq1, sampling_rate, duration):
    t = np.linspace(0, duration, int(duration * sampling_rate), endpoint=False)
    signal = np.zeros_like(t)
    for i, bit in enumerate(binary_input):
        freq = freq0 if bit == '0' else freq1
        carrier_wave = np.sin(2 * np.pi * freq * t)
        signal += carrier_wave
    return t, signal

# Function to demodulate the ASK signal
def ask_demodulation(received_signal, carrier_freq, sampling_rate):
    demodulated_signal = np.sign(received_signal)  # Simple envelope detection
    return demodulated_signal

# Function to demodulate the FSK signal
def fsk_demodulation(received_signal, freq0, freq1, sampling_rate):
    demodulated_signal = []
    for sample in received_signal:
        if np.abs(sample - np.sin(2 * np.pi * freq0 / sampling_rate)) < np.abs(sample - np.sin(2 * np.pi * freq1 / sampling_rate)):
            demodulated_signal.append('0')
        else:
            demodulated_signal.append('1')
    return ''.join(demodulated_signal)


server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)


server_address = ('localhost', 12345)
server_socket.bind(server_address)


server_socket.listen(1)

print("Waiting for a connection...")


connection, client_address = server_socket.accept()

try:
    print("Connection established with", client_address)
    
   
    binary_input = '01010010100101000'  # 16-bit binary input
    carrier_freq = 50  
    freq0 = 25  
    freq1 = 50  
    sampling_rate = 10  
    duration = len(binary_input) / sampling_rate
    

    t_ask, modulated_ask = ask_modulation(binary_input, carrier_freq, sampling_rate, duration)

    t_fsk, modulated_fsk = fsk_modulation(binary_input, freq0, freq1, sampling_rate, duration)
    

    connection.sendall(modulated_ask.tobytes())
    connection.sendall(modulated_fsk.tobytes())
    
    print("Modulated signals sent successfully!")
    
    # Demodulate the received ASK signal
    demodulated_ask = ask_demodulation(modulated_ask, carrier_freq, sampling_rate)
    
    # Demodulate the received FSK signal
    demodulated_fsk = fsk_demodulation(modulated_fsk, freq0, freq1, sampling_rate)
    
    print("Demodulated ASK Signal:", demodulated_ask)
    print("Demodulated FSK Signal:", demodulated_fsk)
    
finally:
    # Clean up the connection
    connection.close()
    server_socket.close()
