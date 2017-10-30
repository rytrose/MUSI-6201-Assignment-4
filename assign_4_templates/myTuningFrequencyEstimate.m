function [tf] = myTuningFrequencyEstimate(x, blockSize, hopSize, fs)

%% Estimate the tuning frequency of an input music signal
% Input:
%   x:          N*1 float vector, input signal
%   blockSize:  int, size of each block
%   hopSize:    int, hop size
%   fs:         float, sampling rate in Hz
% Output:
%   tf:         deviation of tuning frequency from A440 equally tempered
%               scale in cents.

% Check input dimensions 
[~,n] = size(x);
if (n>1)
    error('illegal input signal');
end
[m,n] = size(blockSize);
if (m ~= 1 && n ~=1)
    error('illegal blockSize');
end
[m,n] = size(hopSize);
if (m ~= 1 && n ~=1)
    error('illegal hopSize');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end

%% Please write your code here
freq_struct = load('equal-tempered-freqs.mat');
eq_tmp_freqs = freq_struct.Frequency;

blocked_audio = myBlockAudio(x, blockSize, hopSize, fs);
size_audio = size(blocked_audio);
num_blocks = size_audio(2);

signal_length = length(x);
frequencies = (0:(signal_length-1))*fs/signal_length;

devs = zeros((num_blocks * 20), 1);

i = 1;
while i < num_blocks + 1
    block = blocked_audio(:, i);
    peak_bins = mySpectralPeaks(block);
    
    j = 1;
    while j < 21
        % Found peak frequency
        bin_i = peak_bins(j);
        peak_f = frequencies(bin_i);
        
        % Closest equal tempered frequencys
        [~,I] = min(abs(eq_tmp_freqs-peak_f));
        eq_tmp_f = eq_tmp_freqs(I);
        
        % Deviation in cents
        dev = 1200 * log2(peak_f/eq_tmp_f);
        
        % Add to list
        dev_i = ((i - 1) * 20) + j;
        devs(dev_i) = dev;
        
        j = j + 1;
    end
    
    i = i + 1;
end

histogram(devs);
[n, edges] = histcounts(devs);
[val, i] = max(n);
tf = edges(i);



end