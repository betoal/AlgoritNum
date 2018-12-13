%G = 6.67408E-11; %%  m3 kg-1 s-2
% m=[5.9736E+24,7.349E+22,1.0E+4];
% %
% % cada móvil en una columna
% %
% % r0=[[0;0;0],[6378000.0+108000.0;0;0]];
% r0=[[0;0;0],[3.832557907001450e+08;0;0],[42.0E+6;0;0]];
% v0=[[0;0;0],[0;1.019927755507821e+03;0],[0;3.054326190990077e+03;0]];
% r=[[v0;r0]];
% 
% p = r(4:6,:);
%     
% %p = [[0;0;0],[1;0;0],[1;1;0]];
% GMM = calcGMM(m)
function fzas = calcFzas(GMM,p)
 n = size(p,2);
 d = zeros(3,((n-1)*n)/2);
 c1 = 0;
 for k = 1:n-1
   c0 = c1 + 1;
   c1 = c0 + n - k - 1;
   pz = eye(3); pz(1,1) = p(1,k);pz(2,2) = p(2,k);pz(3,3) = p(3,k);
   d(:,c0:c1) = p(:,k+1:n)-pz*ones(3,c1-c0+1);
   %d(:,c0:c1)  
 end    
d2=sum(d.*d);
%
% distancias entre los móviles
%
dist = sqrt(d2);
%
u = d./[dist;dist;dist];
%
% valor escalar de la fuerza
%
fs=GMM./d2;
%
fza_xyz = u.*[fs;fs;fs];
fzas = zeros(3,n);
%
c1 = 0;
for k = 1:n-1
   c0 = c1 + 1;
   c1 = c0 + n - k - 1;
   fzas(:,k) = fzas(:,k) + sum(fza_xyz(:,c0:c1),2);
   for w = k+1:n
     fzas(:,w) = fzas(:,w) -fza_xyz(:,c0+w-k-1);
   end
   
end

end