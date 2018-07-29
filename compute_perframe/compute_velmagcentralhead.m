%compute velmag_centralhead
function [trx]=compute_velmagcentralhead(trx,outputfolder)
inputfilename=[outputfolder,'dxcentralhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_dxcentralhead_mm(trx,outputfolder);
end
load([outputfolder,'dxcentralhead_mm.mat'], 'data')
dxcentralhead_mm=data;
inputfilename=[outputfolder,'dycentralhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_dycentralhead_mm(trx,outputfolder);
end
load([outputfolder,'dycentralhead_mm.mat'], 'data')
dycentralhead_mm=data;
numlarvae=size(trx,2);
velmagcentralhead=cell(1,numlarvae);
for i=1:numlarvae
    velmagcentralhead{1,i}=bsxfun(@hypot,dxcentralhead_mm{1,i},dycentralhead_mm{1,i});
end

units=struct('num','mm','den','s');
data=velmagcentralhead;
filename=[outputfolder, 'velmagcentralhead.mat'];
save(filename, 'data', 'units') 