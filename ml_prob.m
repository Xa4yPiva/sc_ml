close all;

snr = -20 : 2.5 : 20;
p = [18, 19, 20, 23.5, 28, 34, 42, 60, 78, 87, 94, 99, 100, 100, 100, 100, 100] * 1e-2;

figure(1);
set(groot, 'DefaultAxesFontSize', 18);
set(gcf, 'color', 'w');
plot(snr, p, 'marker', '.', 'linewidth', 2, 'markersize', 15);
grid on;
xlabel('SNR, dB');
ylabel('Probability of right decision');