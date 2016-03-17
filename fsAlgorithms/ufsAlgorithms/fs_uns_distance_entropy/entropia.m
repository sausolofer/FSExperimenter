%Funcion que calcula la Entropia dados dos patrones

function E= entropia(distancia,alfa)
ep=0.00001; %He agregado este epsilon para evitar indeterminacion

S=similaridad(distancia,alfa);
E=S*log2(S)+(1-S+ep)*log2(1-S+ep);
%E=(S*exp(1-S))+(1-S)*exp(S);