
function [valor]=CHN(datos,labels)
%Funcion que calcula el Indice de Calinski-Harabasz Normalizado
[nrow,nc] = size(datos);
labels = double(labels);
k=max(labels);
%funcion que calcula las diversas matrices usadas en LDA dados los datos y
%clusters
[st,sw,sb,cintra,cinter] = valid_sumsqures(datos,labels,k);

%calcula la traza de las matrices intra e inter clase
ssw = trace(sw);
ssb = trace(sb);

if k > 1
  CH = ssb/(k-1); 
else
  CH =ssb; 
end
%indice de Calinski-Harabasz Normalizado
valor = (nrow-k)*CH*nc/ssw;  
%valor = (nrow-k)*CH/ssw;  
% valor=trace(inv(sw)*sb)*1/nc;
% valor=log(det(sb))-log(det(sw));
%valor=(ssb/ssw)*nc;