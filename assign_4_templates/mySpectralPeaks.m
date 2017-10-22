function [spectralPeaks] = mySpectralPeaks(x)

%% Returns the top 20 spectral peak bins in the spectrum of x
% Input:
%   x:              N*1 float vector, input signal
% Output:
%   spectralPeaks:  20*1 float vector, bin indices of spectral peaks

% Check input dimensions 
[~,n] = size(x);
if (n>1)
    error('illegal input signal');
end

%% Please write your code here
spectrum = abs(fft(x));

% All peaks, and their bin indices
[pks, ind] = findpeaks(spectrum);

% Sort to get the top 20
[sorted, sort_i] = sort(pks, 'descend');

bin_i = zeros(20, 1);

i = 1;
while i < 21
    if length(sort_i) < i
        bin_i(i) = NaN; 
    else
        bin_i(i) = ind(sort_i(i));    
    end
    i = i + 1;
end

spectralPeaks = bin_i;
end