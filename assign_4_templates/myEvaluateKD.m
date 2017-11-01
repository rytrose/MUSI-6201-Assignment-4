function [accuracy] = myEvaluateKD(pathToAudio, pathToGT)

%% Evaluates the tuning frequency estimation algorithm
% Input:
%   pathToAudio:    string, path to audio files
%   pathToGT:       string, path to ground truth text files
% Output:
%   avgDeviation:   accuracy of key detection algorithm for the audio files
%                   in the audio directory

%% Please write your code here
gts = dir(pathToGT);
audio_files = dir(pathToAudio);
file_index = 1;
avgDeviation = 0;
audio_counter = 0;
accuracy = zeros(2, 1);
while file_index <= length(audio_files)
    audio_file = audio_files(file_index).name;
    if(any(regexp(audio_file,'wav$'))|| any(regexp(audio_file,'au$')))
        audio_path = strcat(pathToAudio, audio_file);
        [~,name,~] = fileparts(audio_path);
        gt_file = strcat(name, '.txt');
        gt_path = strcat(pathToGT, gt_file);
        gt = load(gt_path);
        [x, fs] = audioread(audio_path);
        with_correction = myKeyDetection(x, 4096, 2048, fs, true);
        without_correction = myKeyDetection(x, 4096, 2048, fs, false);
        if(with_correction == gt)
            accuracy(1) = accuracy(1) + 1;
        end
        if(without_correction == gt)
            accuracy(2) = accuracy(2) + 1;
        end
        audio_counter = audio_counter + 1;
    end
    file_index = file_index + 1;
end

accuracy = accuracy ./ audio_counter;

end