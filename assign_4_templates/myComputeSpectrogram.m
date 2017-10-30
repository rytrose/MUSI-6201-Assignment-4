function [X, binFreqs] = myComputeSpectrogram(xb, fs, fftLength)

%% Computes the magnitude spectrogram from a matrix of audio blocks
% Input:
%	xb:			(blockSize x numBlocks) float matrix, blocks of audio
%	fs:			float, sampling rate in Hz
% 	fftLength:	int, usually power of 2, length of the fft
% Output:
% 	X:			(floor(fftLength / 2) + 1 x numBlocks) float matrix, magnitude spectrogram 
% 	binFreqs:	(floor(fftLength / 2) + 1 x 1) float vector, center frequencies(Hz) of all bins

%% Please insert your code here
size_xb = size(xb);
numBlocks = size_xb(2);
blockSize = size_xb(1);
binFreqs = (fs/(fftLength))*[1:(floor(fftLength / 2) + 1)];
X = zeros(floor(fftLength / 2) + 1, numBlocks);
i = 1;
while i < numBlocks
    window = xb(:,i).*hann(blockSize);
    mag = abs(fft(window, fftLength));
    mag = mag(1:(floor(fftLength) / 2) + 1);
    X(:,i) = mag;
    i = i + 1;
end

end