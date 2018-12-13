function gmm = calcGMM(masas)
G = 6.67408E-11; %%  m3 kg-1 s-2 
n = size(masas,2);
 gmm = zeros(1,((n-1)*n)/2);
 c1 = 0;
 for k = 1:n-1
   c0 = c1 + 1
   c1 = c0 + n - k - 1
   gmm(c0:c1) = masas(k+1:n)*masas(k);
 end    
 gmm = G * gmm;
 gmm
end