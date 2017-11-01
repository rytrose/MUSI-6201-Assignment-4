function [ normalized ] = myNorm( input_vec )
    unravel = input_vec(:);
    sum_input = sum(unravel);
    normalized = input_vec ./ sum_input;
end

