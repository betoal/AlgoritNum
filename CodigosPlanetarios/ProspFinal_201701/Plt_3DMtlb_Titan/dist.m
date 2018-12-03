clear dta
clear z
dta=[pos(3,:,:)-pos(1,:,:)];

 z(1,:)=dta(1,1,:);
 z(2,:)=dta(1,2,:);
z=z';
[v,iv]=min((z(:,1).^2+z(:,2).^2).^0.5)


%%(z(:,1).^2+z(:,2).^2).^0.5
% ============================================
  d0 = 1;
  d1 = 2035;
 d =d0:d1;
  x=zeros(2,d1);
  x(1,d) = pos(3,1,d);
  x(2,d) = pos(3,2,d);
  x = x';
 
  plot(x(:,1),x(:,2))

% ==========================================
%grafSolo   = [1:np];
%desdeHasta = [1:N_GuardaPosiciones];  

grafSolo   = [ind_Tierra,ind_Luna,ind_Apollo];
desdeHasta = [1990:4810];  

hold off
hold on
for k = grafSolo
  x=zeros(2,N_GuardaPosiciones);
  x(1,:) = pos(k,1,:);
  x(2,:) = pos(k,2,:);
  x = x';
  if k == ind_Jupiter
    plot(x(desdeHasta,1),x(desdeHasta,2),'+r')
  elseif k == ind_Io
    plot(x(desdeHasta,1),x(desdeHasta,2),'og') 
  elseif k == ind_Europa
    plot(x(desdeHasta,1),x(desdeHasta,2),'ob')      
  elseif k == ind_Luna
    plot(x(desdeHasta,1),x(desdeHasta,2),'.k')
  elseif k == ind_Apollo
    plot(x(desdeHasta,1),x(desdeHasta,2),'.r')
  elseif k == ind_Tierra
    plot(x(desdeHasta,1),x(desdeHasta,2),'o')
  else  
    plot(x(desdeHasta,1),x(desdeHasta,2))
  end  
end  
hold off
% ==============================================