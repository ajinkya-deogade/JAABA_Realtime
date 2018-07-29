%compute orientation of centralhead vector

function [trx]=compute_centralheadang(trx,outputfolder)

inputfilename=[outputfolder,'xhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xhead_mm.mat'], 'data')
xhead_mm=data;
load([outputfolder,'xcentral_mm.mat'], 'data')
xcentral_mm=data;
load([outputfolder,'yhead_mm.mat'], 'data')
yhead_mm=data;
load([outputfolder,'ycentral_mm.mat'], 'data')
ycentral_mm=data;


centralheadang=cell(size(xhead_mm));

for i=1:size(xhead_mm,2)
    centralheadang{1,i}=bsxfun(@atan2,yhead_mm{1,i}-ycentral_mm{1,i},xhead_mm{1,i}-xcentral_mm{1,i});
end

units=struct('num','rad','den',[]);
data=centralheadang;
filename=[outputfolder, 'centralheadang.mat'];
save(filename, 'data', 'units')