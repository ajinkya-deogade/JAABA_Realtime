%compute ycentralhead_mm
function [trx]=compute_ycentralhead_mm(trx,outputfolder)

inputfilename=[outputfolder,'ycentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'yhead_mm.mat'], 'data')
yhead_mm=data;
load([outputfolder,'ycentral_mm.mat'], 'data')
ycentral_mm=data;

numlarvae=size(trx,2);
ycentralhead_mm=cell(1,numlarvae);

for i=1:numlarvae
    ycentralhead_mm{1,i}=yhead_mm{1,i}-ycentral_mm{1,i};
end
units=struct('num','mm','den',[]);
data=ycentralhead_mm;
filename=[outputfolder, 'ycentralhead_mm.mat'];
save(filename, 'data', 'units')