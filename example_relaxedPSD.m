clear; close all; clc

%% Parameter definition
wu = 15;                    % cut-off frequency
T = 60;                     % upper time bound

dt = 2*pi /(2 * wu);        % time step size
dw = 2*pi / T;              % frequency step size

w = 0:dw:wu;                % frequency vector
t = 0:dt:T;                 % time vector

Nw = length(w);             % length of frequency vector
Nt = length(t);             % length of time vector

Ne = 50;                    % number of realisations 

x = zeros(Ne, length(t));   % initialise time signals
ensemble = zeros(Ne, Nt);   % initialise ensemble

% PSD parameter
b = 1;
sigma = 1;

% Source PSD
S = @(w) (0.25 * sigma^2 * b^3 .* (w).^2 .*exp(-b*abs(w)));

%% generate time signal by Spectral Representation Method
for k=1:Ne
    
    % Spectral representation method (Shinozuka & Deodatis, 1991)
    x_temp = zeros(1, length(t));   % realisations
    for j = 1:Nw  
        x_temp = x_temp + (sqrt(4.*S(w(j)).*dw)*cos(j.*dw.*t + 2.*pi.*rand));     
    end

    % save generated time signal
    x(k, :) = x_temp;

    % compute periodogram of time signals
	ensemble(k,:) = abs(fft(x_temp)).^2 * dt^2./T ./ (2*pi);

end
% use only first half of PSDs
ensemble(:, Nw+1:end) = [];

%% Ensemble plot
figure; hold on; grid on;
plot(w, ensemble)
xlabel('Frequency (rad/s)')
ylabel('Power Spectral Density (m^2/s^3)')
title('Ensemble of PSDs')

%% compute relaxed PSD
relaxedPSD = gen_relaxedPSD(ensemble);

d_pdf = 0.001;
figure; hold on
plot_relaxedPSD(ensemble, relaxedPSD, w, d_pdf, 0.2);
xlabel('Frequency (rad/s)'); 
ylabel('Power Spectral Density (m^2/s^3)'); 
zlabel('Probability Density')

%% pdf "slices" for selected frequencies
figure; hold on; grid on;
xlabel('Power Spectral Density (m^2/s^3)')
ylabel('Probability Density')

x = 0:0.001:0.2;
w1 = 30;
w2 = 45;
w3 = 60;

y1 = pdf(relaxedPSD{w1}, x);
p1 = plot(x, y1);

y2 = pdf(relaxedPSD{w2}, x);
p2 = plot(x, y2);

y3 = pdf(relaxedPSD{w3}, x);
p3 = plot(x, y3);

legend(['\omega = ' num2str(w(w1)) ' rad/s'],['\omega = ' num2str(w(w2)) ' rad/s'],['\omega = ' num2str(w(w3)) ' rad/s'])


