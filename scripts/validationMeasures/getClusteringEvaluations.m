function globalRes = getClusteringEvaluations(idx, trueLabels, dataWithoutClass,k)

globalRes=[];

res = bestMap(trueLabels,idx); % Khun Munkres mapping

%External validation measures
%Evalua AC: accuracy
ACC = length(find(trueLabels == res))/length(trueLabels)*100;
%Evalua NMI: nomalized mutual information
MIhat = MutualInfo(trueLabels,res);

%Other external validation indices
extern = valid_external(idx,trueLabels);
Rand = extern(1);
AjustedRand = extern(2);
Jaccard = extern(3);
FM = extern(4);

%indices de validacion interna
%Silhouette
s = silhouette(dataWithoutClass,idx,'sqeuclid');
coefSilhouette = mean(s);

%Dunn's index
%Dunn = DunnIndex(dataWithoutClass,idx,k);

%Other internal valiudation measures
% d=18;
% distype=1;
% k=numClases;
% ke=[];
% [Dist, dmax] = similarity_euclid(datosPruebaConSeleccion);
% internos = valid_internal(datosPruebaConSeleccion, res, k, Dist,
% ke, distype, id)
globalRes.ACC = ACC;
globalRes.NMI = MIhat;
globalRes.Rand = Rand;
globalRes.AjustedRand = AjustedRand;
globalRes.Jaccard = Jaccard;
globalRes.FM = FM;
globalRes.coefSilhouette = coefSilhouette;
%globalRes.DunnIndex = Dunn;

end