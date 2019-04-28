addpath(genpath('../sc_common'));
addpath(genpath('../matlab_utils'));
clear;
% clc;
close all;
% 
%%
samplesNum = 2^12;
x2 = randi([0,1], 1, samplesNum);
x4 = randi([0,3], 1, samplesNum);
x8 = randi([0,7], 1, samplesNum);

%% Modulation
%--psk--
ph = pi/4;
snr = 10;
N0 = 1 / db2pow(snr);
sigma = sqrt(N0/2);

M = 2.^(1:4);
modsNum = length(M);
xPSK = zeros(modsNum, samplesNum);
sPSK = xPSK;
for m = 1 : modsNum
    xPSK(m,:) = pskmod(randi([0,M(m)-1], 1, samplesNum), M(m), ph);
    sPSK(m,:) = awgn(xPSK(m,:), snr, 'measured');
end

% N = length(sPSK);
% u1 = mean(angle(sPSK), 2)
% u2 = 1 / N * sum(angle(sPSK).^2, 2)
% u3 = 1 / N * sum(angle(sPSK).^3, 2)
% u4 = 1 / N * sum(angle(sPSK).^4, 2)
% u5 = 1 / N * sum(angle(sPSK).^5, 2)
% u6 = 1 / N * sum(angle(sPSK).^6, 2)
% u7 = 1 / N * sum(angle(sPSK).^7, 2)
% u8 = 1 / N * sum(angle(sPSK).^8, 2)
% u16 = 1 / N * sum(angle(sPSK).^16, 2)
% return;

modType = 'psk';
m = 2;
s = sPSK(M==m,:);

% s = awgn(s1, 10, 'measured');

%%
c = zeros(modsNum, 5);
for i = 1 : modsNum
    c(i,:) = Cumulants(sPSK(i,:));
end
c
return;