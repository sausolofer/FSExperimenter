function indMuestra = MuestraAleatoria(totalInstancias,porcent)

numInstancias = round(totalInstancias*porcent/100);

indMuestra = round(1 + (totalInstancias-1).*rand(numInstancias,1));

