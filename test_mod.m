%%
clear;
close all;

%%
N = 8;
M = 2;
data = randi([0, M-1], 1, N);
sPsk = pskmod(data, M);
sPam = pammod(data, M);

figure(1);
subplot(3,1,1); plot(data); grid on;
subplot(3,1,2); plot(real(sPsk)); hold on; plot(imag(sPsk)); grid on;
subplot(3,1,3); plot(real(sPam)); hold on; plot(imag(sPam)); grid on;