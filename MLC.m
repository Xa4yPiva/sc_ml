function [likelihood] = MLC(s, snr)

ph = 0;

N0 = 1 / db2pow(snr);
sigma = sqrt(N0/2);

mPsk = 2.^(1:3);
mPam = mPsk;
mQam = 4.^(1:3);

lhPsk = zeros(1, length(mPsk));
for k = 1 : length(mPsk)
    M = mPsk(k);
    alphabet = 0 : M-1;
    Am = pskmod(alphabet, M, ph);  
    lhPsk(k) = 0;
    for n = 1 : length(s)
        lhPsk(k) = lhPsk(k) + log(sum(1/M .* exp(-(abs(s(n) - Am).^2)./(2*sigma^2))));
    end
end

lhPam = zeros(1, length(mPam));
for k = 1 : length(mPam)
    M = mPam(k);
    alphabet = 0 : M-1;
    Am = pammod(alphabet, M, ph);  
    lhPam(k) = 0;
    for n = 1 : length(s)
        lhPam(k) = lhPam(k) + log(sum(1/M .* exp(-(abs(s(n) - Am).^2)./(2*sigma^2))));
    end
end

lhQam = zeros(1, length(mQam));
for k = 1 : length(mQam)
    M = mQam(k);
    alphabet = 0 : M-1;
    Am = qammod(alphabet, M);  
    lhQam(k) = 0;
    for n = 1 : length(s)
        lhQam(k) = lhQam(k) + log(sum(1/M .* exp(-(abs(s(n) - Am).^2)./(2*sigma^2))));
    end
end

likelihood = [lhPsk, lhPam, lhQam];

end

