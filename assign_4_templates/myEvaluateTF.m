function [avgDeviation] = myEvaluateTF(pathToAudio, pathToGT)

%% Evaluates the tuning frequency estimation algorithm
% Input:
%   pathToAudio:    string, path to audio files
%   pathToGT:       string, path to ground truth text files
% Output:
%   avgDeviation:   average absolute deviation (in cents) of tuning frequency
%                   from A440 equally tempered scale for all the files in audio
%                   directory.

%% Please write your code here
gts = dir(pathToGT);
audio_files = dir(pathToAudio);
file_index = 1;
avgDeviation = 0;
audio_counter = 0;
while file_index <= length(audio_files)
    audio_file = audio_files(file_index).name;
    if(any(regexp(audio_file,'wav$'))|| any(regexp(audio_file,'au$')))
        audio_path = strcat(pathToAudio, audio_file);
        [~,name,~] = fileparts(audio_path);
        gt_file = strcat(name, '.txt');
        gt_path = strcat(pathToGT, gt_file);
        gt = load(gt_path);
        [x, fs] = audioread(audio_path);
        tf_estimate = myTuningFrequencyEstimate(x, 4096, 2046, fs);
        avgDeviation = avgDeviation + abs(tf_estimate - gt);
        audio_counter = audio_counter + 1;
    end
    file_index = file_index + 1;
end

avgDeviation = avgDeviation / audio_counter;

end