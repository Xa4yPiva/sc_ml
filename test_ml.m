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

%%
spec = fftshift(abs(fft(s)));
figure(1);
subplot(1,2,1); plot(real(s)); hold on; plot(imag(s)); grid on;
subplot(1,2,2); plot(mag2db(spec)); grid on;

%%
tic
lh = zeros(1, modsNum);
for k = 1 : modsNum
    alph = 0 : M(k)-1;
    Am = pskmod(alph, M(k), ph);  
    lh(k) = 0;
    for n = 1 : length(s)
%         lh(k) = lh(k) + log(sum(1/M(k) * 1/(sqrt(2*pi)*sigma) .* exp(-(abs(s(n) - Am).^2)./(2*sigma^2))));
        lh(k) = lh(k) + log(sum(1/M(k) .* exp(-(abs(s(n) - Am).^2)./(2*sigma^2))));
    end
end
toc

[lhMax, lhId] = max(lh);
modIdx = M(lhId);
fprintf('Modulation = %s, lhMax = %.2f\n', strcat(modType, num2str(modIdx)), lhMax);

figure(2);
subplot(1,2,1); 
scatter(real(s), imag(s), 'marker', '.');
grid on;
subplot(1,2,2);
% bar(lh);
bar(lh - mean(lh));
grid on;

% xi = -2:0.05:2;
% xq = -2:0.05:2;
% p = zeros(length(xi), length(xq));
% 
% M = 4;
% alph = 0 : M-1;
% Am = pskmod(alph, M);
% for i = 1 : length(xi)
%     for q = 1 : length(xq)
%         x = complex(xi(i), xq(q));
%         p(i,q) = sum(1/M * 1/(sqrt(2*pi)*sigma) .* exp(-(abs(x - Am).^2)./(2*sigma^2)));
%     end
% end
% 
% figure(3);
% r a