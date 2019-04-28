clear;
close all;

snr = 20;

mods = categorical({'1.psk2', '2.psk4', '3.psk8', '4.pam2', '5.pam4', '6.pam8', '7.qam4', '8.qam16', '9.qam64'});

mPsk = 2;
mQam = mPsk^2;
N = 1024;
dataPsk = randi([0, mPsk-1], 1, N);
dataQam = randi([0, mQam-1], 1, N);
sPsk = awgn(pskmod(dataPsk, mPsk), snr, 'measured');
sPam = awgn(pammod(dataPsk, mPsk), snr, 'measured');
sQam = awgn(qammod(dataQam, mQam), snr, 'measured');

lh1 = MLC(sPsk, snr);
lh2 = MLC(sPam, snr);
lh3 = MLC(sQam, snr);

figure(1);
subplot(2,3,1); scatter(real(sPsk), imag(sPsk), 'marker', '.'); grid on;
subplot(2,3,2); scatter(real(sPam), imag(sPam), 'marker', '.'); grid on;
subplot(2,3,3); scatter(real(sQam), imag(sQam), 'marker', '.'); grid on;
subplot(2,3,4); bar(mods, lh1 - mean(lh1)); grid on;
subplot(2,3,5); bar(mods, lh2 - mean(lh2)); grid on;
subplot(2,3,6); bar(mods, lh3 - mean(lh3)); grid on;

[maxlh1, n1] = max(lh1);
[maxlh2, n2] = max(lh2);
[maxlh3, n3] = max(lh3);

m1 = string(mods(n1))
m2 = string(mods(n2))
m3 = string(mods(n3))
