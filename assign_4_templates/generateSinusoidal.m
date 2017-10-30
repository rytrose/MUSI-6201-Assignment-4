function [ t, x ] = generateSinusoidal( amplitude, ...
sampling_rate_Hz, frequency_Hz, length_secs, phase_radians )
% Generates a sinusoidal according to the parameters. 
% The outputs x and t are the generated signal and the 
% corresponding time is seconds. Both outputs are 
% column vectors of the same length

two_pi = 2.0 * pi;

length = sampling_rate_Hz * length_secs;
t = zeros(length, 1);
x = zeros(length, 1);
omega = two_pi * frequency_Hz;

for i = 0:length-1
    one_index = i + 1; % this will be the death of me MATLAB
    whole_seconds_offset = floor(i / sampling_rate_Hz); % integer part
    decimal_seconds_offest = mod(i, sampling_rate_Hz)/sampling_rate_Hz;
    seconds_offset = whole_seconds_offset + decimal_seconds_offest;
    theta =  omega * seconds_offset;
    sample_value = amplitude * sin(theta + phase_radians);
    t(one_index) = seconds_offset;
    x(one_index) = sample_value;
end


end

