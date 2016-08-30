function [Sbest,valor,indRank,tiempo]=metodoHibrido_EntropiaExp(instancias,beta,options)

% import selectordevariables2.Interfaz;
% import selectordevariables2.Filtros
import weka.core.Instance

tic;
inicio=tic;

%obtiene los datos sin la clase
%datos=Interfaz.getMatrix(instancias);
datos=obtieneDatos(instancias)
%Nombre de la base
nombreBase=instancias.relationName;

%inicializacion
[M,N]=size(datos);
gamaBest = 1000; 
indSbest=[];
valores=[];
S=[];

ConjuntoOriginal=pdist(datos,'euclidean');

 if ~exist('options', 'var')
        
% evaluar con metodo filter Basado en entropia (rank)
[indRank,valRank]= MuestreoAleatorio(datos);

 
 else
% evaluar con metodo filter Basado en entropia (rank)
[indRank,valRank]= MuestreoAleatorio(datos,options.porcent,options.numMuestras);
 end

for i=1:N
   
        S=[S,indRank(i)]; % genera un subconjunto con cardinalidad i para evaluacion
        datosCand=datos(:,S);
               
       % Se evalua con medida filter ( )
        gama= FFEI2(datosCand,ConjuntoOriginal,beta)
           
        if(gama < gamaBest)
             gamaBest = gama;
             indSbest=S;
             %indicesMejorSubconjunto=rank;    
        end
        
        valores=[valores,gama];
end

 Sbest= indSbest;
 valor=gamaBest;
 tiempo = toc(inicio);  