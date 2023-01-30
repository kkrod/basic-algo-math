clear;

% ------------ Metodo de Aproximacion Vogel----------%


%------------ Variables------------- %

C=[5  2  7  3
   3  6  6  1
   6  1  2  4
   4  3  6  6];        % Matriz de Costos

S=[80 ; 30 ; 60 ; 45 ]; % Satisfaccion de los Almacenes

N=[70  40  70  35];  % Necesidades de las Ciudades

[m,n]=size(C);         % Numeros de Almacenes y Ciudades

numbasic=m+n-1;        % 

x=zeros(m,n);          % Matriz de Resultados

for j=1:n
    for i=1:m
        copia_c(i,j)=C(i,j);
        copia_s(i)=S(i);
    end
    copia_n(j)=N(j);
end

for r=1:1:numbasic
  sprintf("----------- Iteracion %d -------------------",r)
  disp("Matriz Principal")
  [copia_c S; N 0]
  
  % Buscando los minimos valores en las filas
  minfila1=zeros(m,1);
  minfila2=zeros(m,1);
  jmin=zeros(1,m);
  
  for i=1:1:m
    min1=inf;
    for j=1:1:n
      if copia_c(i,j)<min1
        min1=copia_c(i,j);
        jmin(i)=j;
      endif
    endfor
    minfila1(i)=min1;
  endfor
  
  for i=1:1:m
    min2=inf;
    for j=1:1:n
      if j~=jmin(i)
          if copia_c(i,j)<=min2
              min2=copia_c(i,j);
          endif
      endif      
    endfor
    minfila2(i)=min2;
  endfor
  
  % Buscando los minimos valores en las columnas
  mincol1=zeros(1,n);
  mincol2=zeros(1,n);
  imin=zeros(n,1);
  
  for j=1:1:n
    min1=inf;
    for i=1:1:m
        if copia_c(i,j)<min1
            min1=copia_c(i,j);
            imin(j)=i;
        endif
    endfor
    mincol1(j)=min1;
  endfor

  for j=1:1:n
    min2=inf;
    for i=1:1:m
      if i~=imin(j)
          if copia_c(i,j)<=min2
              min2=copia_c(i,j);
          endif
      endif     
    endfor
    mincol2(j)=min2;
  endfor
  
  % Calculando la penalizacion
  penafila=zeros(m,1);
  penacol=zeros(1,n);
  for i=1:1:m
      penafila(i)=minfila2(i)-minfila1(i);
  endfor
  
  for j=1:1:n
    penacol(j)=mincol2(j)-mincol1(j);
  endfor
  disp("Penalizaciones")
  penafila
  penacol
  
  % Encontrando el valor mas alto de penalizacion
  minf=0;
  fil=zeros(m,1);
  for i=1:1:m
      if penafila(i)>=minf
          minf=penafila(i);
          iminfila=i; 
      endif
  endfor
  fil(iminfila)=minf;
  
  minc=0;
  col=zeros(1,n);
  for j=1:1:n
      if penacol(j)>=minc
          minc=penacol(j);
          jmincol=j;
      endif
  endfor
  col(jmincol)=minc;
  
  penmayor=zeros(1,n);
  for j=1:1:n
    if minc>=minf
        penmayor(jmincol)=col(jmincol);
        penc=1;
    else
        penmayor(iminfila)=fil(iminfila);
        penc=1;
    endif
  endfor
  
  if penc==1
      j=jmincol;
      R1=inf;
      for i=1:m
          if copia_c(i,jmincol)<=R1
              R1=copia_c(i,jmincol);
              igreat=i;
          end
      end
      
      if copia_s(igreat)>copia_n(jmincol)
          x(igreat,jmincol)=copia_n(jmincol);
          copia_s(igreat)=copia_s(igreat)-copia_n(jmincol);
          copia_n(jmincol)=0;
          eliminar=0;
      elseif copia_s(igreat)<copia_n(jmincol)
          x(igreat,jmincol)=copia_s(igreat); 
          copia_n(jmincol)=copia_n(jmincol)-copia_s(igreat);
          copia_s(igreat)=0;
          
          eliminar=1; 
      elseif copia_s(igreat)==copia_n(jmincol)
            x(igreat,jmincol)=copia_s(igreat); 
          copia_n(jmincol)=0;
          copia_s(igreat)=0;
          eliminar=2;
      end
      
        % Eliminaar Columna o fila sustituyendo por Inf
        if eliminar==0
            for i=1:m
                copia_c(i,jmincol)=inf;
            end
        elseif eliminar==1 
            for j=1:n
                copia_c(igreat,j)=inf;
            end
        elseif eliminar==2
            for i=1:m
                copia_c(i,jmincol)=inf;
            end
            for j=1:n
                copia_c(igreat,j)=inf;
            end
        
        end
  else
      i=iminfila;
      R2=inf;
      for j=1:n
          if copia_c(iminfila,j)<R2
              R2=copia_c(iminfila,j);
              jgreat=j; 
          end
      end
      
      if copia_s(iminfila)>copia_n(jgreat)
          x(iminfila,jgreat)=copia_n(jgreat);
          copia_s(iminfila)=copia_s(iminfila)-copia_n(jgreat);
          copia_n(jgreat)=0;
          eliminar=0; 
      elseif copia_s(iminfila)<copia_n(jgreat)
          x(iminfila,jgreat)=copia_s(iminfila); 
          
          copia_n(jgreat)=copia_n(jgreat)-copia_s(iminfila);
          copia_s(iminfila)=0;
          eliminar=1; 
      elseif copia_s(iminfila)==copia_n(jgreat)
          x(iminfila,jgreat)=copia_s(iminfila);
          copia_n(jgreat)=0;
          copia_s(iminfila)=0;
          eliminar=2; 
      end
          % Eliminar Columna o fila sustituyendo por Inf
        if eliminar==0
            for i=1:m
                copia_c(i,jgreat)=inf;
            end
        elseif eliminar==1 
            for j=1:n
                copia_c(iminfila,j)=inf;
            end
        elseif eliminar==2 
            for i=1:m
                copia_c(i,jgreat)=inf
            end
            for j=1:n
                copia_c(iminfila,j)=inf;
            end
        end 
      
  endif
  disp("Matriz Resultado")
    [x S; N 0]

endfor % Final del ciclo principal

 z=0;
    for j=1:n
        for i=1:m
            if x(i,j)>0
                z=z+C(i,j)*x(i,j);
            end
        end
    end
  
  sprintf("Total del Costo por Voguel: %d",z)