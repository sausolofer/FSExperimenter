function [ out ] = fsLsWnchBE(instances, idMedida, gradExp)

%% initializes the parameters
clusters = instances.numClasses;
[X,~] = getNumericCodification(instances);

if idMedida == 1
    options = [];
    options.Metric = 'Euclidean';
    options.NeighborMode = 'KNN';
    options.k =5;%round((1/3)*size(datos,1) );
    options.WeightMode = 'HeatKernel';
    options.numCluster=clusters;
    options.idM = idMedida;
else
    options = [];
    options.Metric = 'Cosine';
    options.NeighborMode = 'KNN';
    options.k = 5;
    options.WeightMode = 'Cosine';
    options.numCluster = clusters;
    options.idM = idMedida;
end

% funcion recursiva que realiza una busqueda hacia atras con criterio WNCH y LS
[Sbest,valor]=BE(X,gradExp,options);
%obtiene los indices del cto. de variables seleccionadas
Sbest=Regresa_Indices(X,Sbest);

out.W = valor; %weight of each feature
out.fList = Sbest; %contains a set of feature index. Features in the top of the rank list are most relevant features according to the algorithm
out.prf = 0; %smaller the weights are the more relevant (.prf=-1).
out.fImp = true; % is a subset selection algorithm?

function [Sbest,valor]=BE(datos,gradExp,options)

%obtiene la dimension y el numero de instancias
[~,n]=size(datos);
% evalua con metodo filter Basado en el Laplacian Score (rank)
[indicesRank,~]= laplacianScoreVar(datos,options);

%condicion de paro
if(length(indicesRank)==1)
    idx= kmeans(datos,options.numCluster,'emptyaction','drop','replicates',3,'start','sample');
    valor = CHN(datos,idx);
    Sbest=datos;
    return
else
    bandera=false;
    indAux=indicesRank;
    %actualSubconj=datos;
    %Agrupa los datos con kmeans
    idx= kmeans(datos,options.numCluster,'emptyaction','drop','replicates',3,'start','sample');
    %obtiene la calidad de las particiones con el indice de
    %Calinski-Harabasz Normalizado
    valorMejorSubconj = CHN(datos,idx);%*valRank(end);
    cont=0;
    for i = n: -1:1
        indexSubCand=indAux;
        indexSubCand(i)=[];
        
        subconjuntoCandidato=datos(:,indexSubCand);
        idx= kmeans(subconjuntoCandidato,options.numCluster,'emptyaction','drop','replicates',3,'start','sample');
        
        valorSubconjuntoCandidato = CHN(subconjuntoCandidato,idx);%*(valRank(i));
        if valorSubconjuntoCandidato > valorMejorSubconj
            valorMejorSubconj = valorSubconjuntoCandidato;
            mejorSubconjunto=indexSubCand;%subconjuntoCandidato;
            bandera=true;
            cont=0;
        else
            if cont>=gradExp && bandera== false
                Sbest= datos;%(:,actualSubconj);
                valor= valorMejorSubconj;  return
            elseif cont>=gradExp && bandera==true
                break;
            else
                cont=cont+1;
                continue
            end
        end
    end
    
    if(bandera==true)
        %Se llama recursivamente el metodo
        [Sbest,valor]=BE(datos(:,mejorSubconjunto),gradExp,options);
        return
    else
        %if(bandera==false)
        Sbest=datos;
        valor=valorMejorSubconj;
        return
    end
end

