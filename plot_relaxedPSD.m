function p = plot_relaxedPSD(ensemble, relaxedPSD, omega, pdfDiscretisation, varargin)
% Function for visualising the relaxed stationary power spectral density
%
% INPUT:
%       - ensemble:             Ensemble of power spectral densities
%       - relaxedPSD:           Object of respective distribution types
%       - omega:                Frequency discretisation of the probability density functions
%       - pdfDiscretisation:    Discretisation of the probability density functions
%       - varargin:             optional input parameter for defining max. value of plot in y-direction    
%
% OUTPUT:
%       - p:                    Plot object with specifications
%
% Author:
% Marco Behrendt
% Institute for Risk and Reliability, Leibniz Universität Hannover
% behrendt@irz.uni-hannover.de
% https://github.com/marcobehrendt
% 
% Date: 31 January 2019

% define the max. value of the plot in y-direction
if isempty(varargin)
    maxPlotValue = 2.5 * max(mean(ensemble,1));    
else
    maxPlotValue = varargin{1};
end

% pdf discretisation for plot
pdfDiscreteValues = 0:pdfDiscretisation:maxPlotValue;
% initialise plot matrix
relaxedPSD_slices = zeros(size(ensemble,2), length(pdfDiscreteValues));

% define discrete PDFs
for i = 1:size(ensemble,2)
    relaxedPSD_slices(i,:) = pdf(relaxedPSD{i},pdfDiscreteValues); 
end

% scaling for normalised probability density
max_value = max(relaxedPSD_slices, [], 2);
relaxedPSD_slices = relaxedPSD_slices./max_value;

% plot
p = pcolor(relaxedPSD_slices');
h = colorbar;
ylabel(h, 'Probability Density (normalised)')
shading interp

xlim([1 size(relaxedPSD_slices, 1)])
ylim([1 size(relaxedPSD_slices, 2)])

set(gca,'XTickLabel', round(omega(get(gca, 'XTick')),1))
set(gca,'YTickLabel', get(gca, 'YTick')*pdfDiscretisation)
set(gca,'YTickMode', 'manual')

end

