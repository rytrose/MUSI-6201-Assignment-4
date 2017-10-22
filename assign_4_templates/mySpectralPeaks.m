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

end