function [dist] = myDistanceMetric(template, chroma)
    dist = sum(abs(template - chroma));
    %dist = sqrt(sum((template - chroma) .^ 2)); euclidean distance
end
