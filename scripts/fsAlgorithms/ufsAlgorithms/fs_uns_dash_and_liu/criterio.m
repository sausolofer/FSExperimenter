function [valor]=criterio(datos,labels)

labels = double(labels);
k=max(labels);

[st,sw,sb,cintra,cinter] = valid_sumsqures(datos,labels,k);
   

if (det(sw)>0)
  valor=trace(inv(sw)*sb); 
else
  valor=0;
end


