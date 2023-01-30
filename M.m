clc

% ------------ Metodo Gran M (Minimizar)----------%


%------------ Variables------------- %

Z=[4 1];          % Funcion Objetivo

I=[3 1;4 3; 1 2]; % Inecuaciones de las Restricciones 

R=[3 ; 6 ; 3 ];   % Recursos

inq=[0 1 -1];      % Id de Inecuacion,  0: = , 1: >= , -1: <=

n=length(Z);       % Numero de Variables         

m=length(R);       % Numero de Recursos o Inecuaciones

contador=n;       % Contador partiendo de numero de variables en la funcion objetivo

fil=[];            % Filas donde hay Variables Artificiales

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
  elseif inq(i)==0
    contador=contador+1;
    Z(contador)=-10j;
    I(i,contador)=1;
    fil=[fil i];
  else
    contador=contador+1;
    Z(contador)=0;
    I(i,contador)=-1;
    contador=contador+1;
    Z(contador)=-10j;
    I(i,contador)=1;
    fil=[fil i];
  endif

endfor



M=[zeros(m,1) I R;1 Z 0 ];

sprintf('\n-------------Matriz de Control-----------------.\n')
disp([M]);
sprintf('--------------------------------------------------\n')


for i=1:1:length(fil)
  sprintf("Eliminando las M en las variables artificales\n")
  M(end,:)=M(end,:)+ (10j*M(fil(i),:))
endfor



for i=1:1:n
  
  aux=real(M(end,:))==0;
  alpha_pos=real(M(end,:));
  alpha_pos(aux)=inf;

  disp("Columna Pivote:")
  [v_min,col_piv]=min(alpha_pos)

  disp("Valores Delta:")
  delta=real(M(:,end))./real(M(:,col_piv))

  aux=delta<=0;
  delta_pos=delta;
  delta_pos(aux)=inf;

  disp("Elemento y Fila Pivote:")
  [ele_piv,fil_piv]=min(delta_pos)

  M(fil_piv,:)=M(fil_piv,:)/M(fil_piv,col_piv)
  
  for j=1:1:size(M,1)
    
    if j~=fil_piv
      M(j,:)=M(j,:) - (M(j,col_piv) * M(fil_piv,:))
    endif
  endfor
  
  disp("Fin del Proceso, Iteracion")
endfor

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