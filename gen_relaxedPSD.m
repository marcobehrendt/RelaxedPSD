function relaxedPSD =  gen_relaxedPSD(ensemble)
% Calculation of the parameter for a truncated Gaussian distribution for
% each frequency of an ensemble of power spectral densities
%s
% INPUT:
%       - ensemble:     Ensemble of power spectral densities        
%
% OUTPUT:
%       - relaxedPSD:   Object of truncated Gaussian distributions with
%                       parameter for each frequency
%
% Author:
% Marco Behrendt
% Institute for Risk and Reliability, Leibniz Universität Hannover
% behrendt@irz.uni-hannover.de
% https://github.com/marcobehrendt
%
% Date: 21 November 2019

% define number of individual PSDs of the ensemble
n = size(ensemble,2);
% calculate ensemble mean
ensemble_mean = mean(ensemble);
% calculate ensemble standard deviation
ensemble_std_dev = std(ensemble);

% initialise cell array for PDFs
relaxedPSD = {n};

% define PDFs for individual frequencies
for i = 1:n   
    pd = makedist('Normal','mu',ensemble_mean(i),'sigma',ensemble_std_dev(i));
    relaxedPSD{i} = truncate(pd,0,inf);
end

end