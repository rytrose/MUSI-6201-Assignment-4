function [keyEstimate] = myKeyDetection(x, blockSize, hopSize, fs, tune)

%% Computes the key for the input music signal
% Input:
%   x:          N*1 float vector, input signal
%   blockSize:  int, size of each block
%   hopSize:    int, hop size
%   fs:         float, sampling rate in Hz
%   tune:       boolean, true if tuning frequency correction is to be done,
%               false if no tuning frequency correction is required.
% Output:
%   keyEstimate:The output will be a number between 0 to 23. The mapping
%               between the integer to a key is given in the 
%               label_to_key.txt file in the key_eval directory.

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
[m,n] = size(tune);
if (m ~= 1 && n ~=1)
    error('illegal tune');
end
%if (tune ~= true || tune ~= false)
%    error('illegal tune');
%end
%% Please write your code here
KeyTemplate = [6.35 2.23 3.48 2.33 4.38 4.09 2.52 5.19 2.39 3.66 2.29...
    2.88 6.33 2.68 3.52 5.38 2.60 3.53 2.54 4.75 3.98 2.69 3.34 3.17];

majorTemplate = myNorm(KeyTemplate(1:12));
minorTemplate = myNorm(KeyTemplate(13:24));
template = [];

overlap = blockSize - hopSize;
spec = abs(spectrogram(x, hann(blockSize), overlap));

tf = 0;
if(tune)
   tf = myTuningFrequencyEstimate(x, blockSize, hopSize, fs); 
end

pitchChroma = myPitchChroma(spec, fs, tf);
size_chroma = size(pitchChroma);

numBlocks = size_chroma(2);

minDistance = Inf;
minIndex = 0;
template_i = 1;

while template_i <= 12
    current_major_template = circshift(majorTemplate, [0, template_i - 1]);
    current_minor_template = circshift(minorTemplate, [0, template_i - 1]);
    dist_major = 0;
    dist_minor = 0;
    all_blocks = sum(pitchChroma, 2);
    shift_block = circshift(all_blocks, 3);
    norm_chroma = myNorm(shift_block);
    dist_major = myDistanceMetric(current_major_template', norm_chroma);
    dist_minor = myDistanceMetric(current_minor_template', norm_chroma);
    if dist_major < minDistance
       minDistance = dist_major;
       minIndex = template_i;
    end
    if dist_minor < minDistance
       minDistance = dist_minor;
       minIndex = 12 + template_i;
    end
    template_i = template_i + 1;
end

keyEstimate = minIndex - 1;
end