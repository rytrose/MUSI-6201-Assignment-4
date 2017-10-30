function [pitchChroma] = myPitchChroma(X, fs, tf)

%% Compute the pitch chroma for an incoming spectrogram

%   X:          frequencyBins*numBlocks float matrix, input magnitude
%               spectrogram
%   fs:         float, sampling rate in Hz
%   tf:         float, tuning frequency deviation from equitempered scale.
%               this is used for adjusting the semi-tone bins.
% Output:
%   pitchChroma:(12 x numBlocks) float matrix

% Check input dimensions 
[m,n] = size(X);
if (m == 1 || n==1)
    error('illegal input spectrogram');
end
[m,n] = size(fs);
if (m ~= 1 && n ~=1)
    error('illegal fs');
end
[m,n] = size(tf);
if (m ~= 1 && n ~=1)
    error('illegal tf');
end

%% Please write your code here
freq_struct = load('equal-tempered-freqs.mat');
eq_tmp_freqs = freq_struct.Frequency;
% C3 is index 56
% B5 is index 91
freqs = eq_tmp_freqs(56:91);

adjusted_freqs = zeros(36, 1);

i = 1;
while i < 37
   adjusted_freqs(i) = (2^(tf/1200))*freqs(i);
   i = i + 1;
end
disp(adjusted_freqs)

block_i = 1;
size_x = size(X);
num_bins = size_x(1);
numBlocks = size_x(2);
pitchChroma = zeros(12, numBlocks);

while block_i <= numBlocks
    bin_i = 1;
    while bin_i <= num_bins
        bin_freq = bin_i * (fs/(2 * num_bins));
        if (bin_freq <= adjusted_freqs(36) && bin_freq >= adjusted_freqs(1))
            [~,I] = min(abs(adjusted_freqs - bin_freq));
            disp(adjusted_freqs(I))
            disp(bin_freq)
            pitch_class_index = 1 + mod(I-1, 12);
            pitchChroma(pitch_class_index, block_i) = pitchChroma(pitch_class_index, block_i) + abs(X(bin_i, block_i));
        end
        bin_i = bin_i + 1;
    end
    block_i = block_i + 1;
end

end