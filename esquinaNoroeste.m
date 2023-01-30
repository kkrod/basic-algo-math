
% ------------ Metodo de Esquina Noroeste----------%


%------------ Variables------------- %

C=[ 3 6 2
    2 3 5
    6 4 8];         % Matriz de Costos

O=[800  800  400 ]; % Oferta de los Proveedores

D=[600 700 700];    % Demanda de los Estados

[m,n]=size(C);      % Numeros de Almacenes y Ciudades

asig=m+n-1;         % Nro de Asignaciones

x=zeros(m,n);       % Matriz de Resultados


[C O'; D sum(O)]

j=1;
k=1;

for registro=1:1:asig
  sprintf("----------- Iteracion %d -------------------",registro)
  
  if O(1,j) <= D(1,k)
    
    x(j,k)=O(1,j);
    
    D(1,k)=D(1,k)-O(1,j);
    O(1,j)=0;
    j=j+1;
   
 elseif O(1,j) > D(1,k)
   
    x(j,k)=D(1,k);
    O(1,j)=O(1,j)-D(1,k);
    D(1,k)=0;
    k=k+1;
    
  else
    break
  endif
  [x O'; D sum(O)]
endfor

z=0;

for j=1:1:n
  for i=1:1:m
    if x(i,j) > 0
      z=z+C(i,j)*x(i,j);
    endif
  endfor
endfor

registro
asig
sprintf("Total del Costo por Esquina-Noroeste: %d",z)