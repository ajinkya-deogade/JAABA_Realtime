%compute length of tailcentralvector

function [trx]=compute_tailcentralmag(trx,outputfolder)

inputfilename=[outputfolder,'xcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xcentral_mm.mat'], 'data')
xcentral_mm=data;
load([outputfolder,'xtail_mm.mat'], 'data')
xtail_mm=data;
load([outputfolder,'ycentral_mm.mat'], 'data')
ycentral_mm=data;
load([outputfolder,'ytail_mm.mat'], 'data')
ytail_mm=data;

tailcentralmag=cell(size(xcentral_mm));

for i=1:size(xcentral_mm,2)
    tailcentralmag{1,i}=bsxfun(@hypot,xcentral_mm{1,i}-xtail_mm{1,i},ycentral_mm{1,i}-ytail_mm{1,i});
end

units=struct('num','mm','den',[]);
data=tailcentralmag;
filename=[outputfolder, 'tailcentralmag.mat'];
save(filename, 'data', 'units')