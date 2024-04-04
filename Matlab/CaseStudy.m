% Input binary data
%bitStream = [0 0 0 0 0 0 0 0  0 0 0 0 0 0 0];
%bitStream = [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];
%bitStream = [1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0];
bitStream = [0 1 0 1 0 0 1 0 1 0 0 1 0 1 0 0];

% Length of the bit stream
length_bitStream = length(bitStream);

% Modulation parameters
Amplitude = 5;
time = 0:0.0001:0.1; % Increased time duration for better visualization
frequency_carrier_ask = 50;
frequency_carrier_fsk_0 = 25;
frequency_carrier_fsk_1 = 50;

% ASK carrier signal
carrier_ask = Amplitude * sin(2 * pi * frequency_carrier_ask * time);

% FSK carrier signals for logic 0 and logic 1
carrier_fsk_0 = Amplitude * sin(2 * pi * frequency_carrier_fsk_0 * time);
carrier_fsk_1 = Amplitude * sin(2 * pi * frequency_carrier_fsk_1 * time);


% ASK Modulation
ask_modulated_signal = zeros(1, length_bitStream * length(time));
fsk_modulated_signal = zeros(1, length_bitStream * length(time));

for i = 1:length_bitStream
    for j = (i - 1) * length(time) + 1 : i * length(time)
        if bitStream(i) == 1
            ask_modulated_signal(j) = carrier_ask(j - (i - 1) * length(time));
            fsk_modulated_signal(j) = carrier_fsk_1(j - (i - 1) * length(time));
        else
            ask_modulated_signal(j) = 0;
            fsk_modulated_signal(j) = carrier_fsk_0(j - (i - 1) * length(time));
        end
    end
end

% ASK Demodulation
demodulated_ask = zeros(1, length_bitStream);
demodulated_fsk = zeros(1, length_bitStream);

for i = 1:length_bitStream
    % ASK Demodulation
    ask_correlation = sum(ask_modulated_signal((i - 1) * length(time) + 1 : i * length(time)) .* carrier_ask);
    if ask_correlation > 0
        demodulated_ask(i) = 1;
    else
        demodulated_ask(i) = 0;
    end
    
    % FSK Demodulation
    fsk_correlation_0 = sum(fsk_modulated_signal((i - 1) * length(time) + 1 : i * length(time)) .* carrier_fsk_0);
    fsk_correlation_1 = sum(fsk_modulated_signal((i - 1) * length(time) + 1 : i * length(time)) .* carrier_fsk_1);
    if fsk_correlation_1 > fsk_correlation_0
        demodulated_fsk(i) = 1;
    else
        demodulated_fsk(i) = 0;
    end
end

% Plotting ASK
subplot(4, 1, 1)
stairs(bitStream)
axis([1 length_bitStream -0.1 1.1])
title('Given Sequence (ASK)');
xlabel('Time')
ylabel('Amplitude')

subplot(4, 1, 2)
plot(time, carrier_ask)
title('ASK Carrier Signal');
xlabel('Time')
ylabel('Amplitude')

subplot(4, 1, 3)
plot(ask_modulated_signal)
title('ASK Modulated Signal')
xlim([0, length_bitStream * 1000]); 
xlabel('Time')
ylabel('Amplitude')

subplot(4, 1, 4)
stairs(demodulated_ask)
axis([1 length_bitStream -0.1 1.1])
title('Demodulated Sequence (ASK)');
xlabel('Bit Index')
ylabel('Demodulated Value')

% Plotting FSK
figure;
subplot(4, 1, 1)
stairs(bitStream)
axis([1 length_bitStream -0.1 1.1])
title('Given Sequence (FSK)');
xlabel('Bit Index')
ylabel('Binary Value')

subplot(4, 1, 2)
plot(time, carrier_fsk_0)
hold on
plot(time, carrier_fsk_1)
legend('Logic 0', 'Logic 1')
title('FSK Carrier Signals');
xlabel('Time')
ylabel('Amplitude')

subplot(4, 1, 3)
plot(fsk_modulated_signal)
title('FSK Modulated Signal')
xlim([0, length_bitStream * 1000]); 
xlabel('Time')
ylabel('Amplitude')

subplot(4, 1, 4)
stairs(demodulated_fsk)
axis([1 length_bitStream -0.1 1.1])
title('Demodulated Sequence (FSK)');
xlabel('Bit Index')
ylabel('Demodulated Value')
