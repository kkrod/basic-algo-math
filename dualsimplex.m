clc

% ------------ Metodo Dual Simplex (Minimizar)----------%


%------------ Variables------------- %

Z=[315 110 50];      % Funcion Objetivo

I=[15 2 1;7.5 3 1; 5 2 1]; % Inecuaciones de las Restricciones 

R=[200 ; 150 ; 120 ]; % Recursos

inq=[1 1 1];       % Id de Inecuacion,  0: = , 1: >= , -1: <=

n=length(Z);       % Numero de Variables         

m=length(R);       % Numero de Recursos o Inecuaciones

contador=n;       % Contador partiendo de numero de variables en la funcion objetivo

fil=[];           % Filas donde hay Variables holgura negativas

%------------------------------------%


disp("Dado la Funcion Objetivo:")
Z=-Z

disp("Con las Siguientes Restricciones:")
Res=[I R]


for i=1:1:m
  if inq(i)<0
    contador=contador+1;
    Z(contador)=0;
    I(i,contador)=1;
  else
    contador=contador+1;
    Z(contador)=0;
    I(i,contador)=-1;
    fil=[fil i];
  endif

endfor

M=[zeros(m,1) I R;1 Z 0 ];

for i=1:1:length(fil)
  sprintf("Volviendo variables de Holgura positivas\n")
  M(fil(i),:)=-1*M(fil(i),:)
endfor
sprintf('\n-------------Matriz de Control-----------------.\n')
disp([M]);
sprintf('--------------------------------------------------\n')


for i=1:1:50
  neg=M(:,end)<0;
  
  if neg==0
    break
  endif
  
  disp("Fila Pivote:")
  [v_min,fil_piv]=min(M(:,end))
  
  disp("Valores Delta:")
  delta=M(end,1:end-1)./M(fil_piv,1:end-1)


  aux=(delta==-Inf);
  aux2=delta==0;
  delta_pos=delta;
  delta_pos(aux)=inf;
  delta_pos(aux2)=inf;
  
  disp("Columna Pivote:")
  [piv,col_piv]=min(delta_pos)
  
  M(fil_piv,:)=M(fil_piv,:)/M(fil_piv,col_piv)
  
  for j=1:1:size(M,1)
    if j~=fil_piv
      M(j,:)=M(j,:) - (M(j,col_piv) * M(fil_piv,:))
    endif
  endfor
  sprintf("Iteracion %d",i)
endfor
disp("Fin del Proceso")
for i=1:1:(n+1)
  if  s=size(find(M(:,i)~=0)) == [1,1]
    aux=find(M(:,i)==1);
   
    if i==1
        sprintf("Z: %f",M(aux,end))
    else
        sprintf("X%d: %f",i-1,M(aux,end))
    endif
  else
    sprintf("X%d: Muchas Soluciones",i-1)
  endif
endfor