%compute ytailcentral_mm
function [trx]=compute_ytailcentral_mm(trx,outputfolder)

inputfilename=[outputfolder,'ycentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'ycentral_mm.mat'], 'data')
ycentral_mm=data;
load([outputfolder,'xtail_mm.mat'], 'data')
ytail_mm=data;

numlarvae=size(trx,2);
ytailcentral_mm=cell(1,numlarvae);

for i=1:numlarvae
    ytailcentral_mm{1,i}=ycentral_mm{1,i}-ytail_mm{1,i};
end
units=struct('num','mm','den',[]);
data=ytailcentral_mm;
filename=[outputfolder, 'ytailcentral_mm.mat'];
save(filename, 'data', 'units')