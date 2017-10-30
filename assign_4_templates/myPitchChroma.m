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
freqs = eq_temp_freqs(56:91);

adjusted_freqs = zeros(36, 1);

i = 1;
while i < 37
   adjusted_freqs(i) = (2^(tf/1200))*freqs(i); 
end



end