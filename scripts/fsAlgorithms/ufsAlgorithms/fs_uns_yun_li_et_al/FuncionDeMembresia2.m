function valorDeMembresia = FuncionDeMembresia2(dpq,D)

%dpq = distanciaEuclidiana(p,q);

if(dpq <= D)
    
    valorDeMembresia = 1 - (dpq / D);
    
else
    
 valorDeMembresia = 0;   
 
end