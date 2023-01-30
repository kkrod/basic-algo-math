

% ------------ Metodo Simplex (Maximizar)----------%

%------------ Variables------------- %

U=[ 21 24 36 ];              % Funcion Objetivo

I=[ 1 1 1 ; 1 1 2 ; 2 3 5 ]; % Inecuaciones de las Restricciones

R=[ 400 ; 500 ; 1450 ];      % Recursos

nro_i= size(I);              % Numero de Inecuaciones


disp("Dado la Funcion Objetivo:")
U=[1  U*-1]


disp("Con las Siguientes Restricciones:")
Res=[I R]


disp("Se Construye la Matriz de Control:")
M=[ zeros(nro_i,1)  I  eye(nro_i)   R
            U   zeros(1,nro_i) 0]

%------------- Logaritmo -------------%

for i=1:1:50
  neg=M(end,1:end-1)<0;
  
  if neg==0
    break
  endif
  
  disp("Columna Pivote:")
  [v_min,col_piv]=min(M(end,:))
  
 disp("Valores Delta:")
  delta=M(:,end)./M(:,col_piv)
  
  aux=delta<=0;
  delta_pos=delta;
  delta_pos(aux)=inf;
  
  %disp("Elemento y Fila Pivote:")
  [ele_piv,fil_piv]=min(delta_pos)
  
  M(fil_piv,:)=M(fil_piv,:)/M(fil_piv,col_piv)
  
  for j=1:1:size(M,1)
    
    if j~=fil_piv
      M(j,:)=M(j,:) - (M(j,col_piv) * M(fil_piv,:))
    endif
  endfor
  
  disp("Fin del Proceso, Iteracion")
endfor

for i=1:1:(nro_i+1)
  if  s=size(find(M(:,i)~=0)) == [1,1]
    aux=find(M(:,i)==1);
   
    if i==1
        sprintf("U: %f",M(aux,end))
    else
        sprintf("X%d: %f",i-1,M(aux,end))
    endif
  else
    sprintf("X%d: Muchas Soluciones",i-1)
  endif
endfor
            





