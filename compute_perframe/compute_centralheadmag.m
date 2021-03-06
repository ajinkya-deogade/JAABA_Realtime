%compute length of centralhead vector

function [trx]=compute_centralheadmag(trx,outputfolder)

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

centralheadmag=cell(size(xhead_mm));

for i=1:size(xhead_mm,2)
    centralheadmag{1,i}=bsxfun(@hypot,xhead_mm{1,i}-xcentral_mm{1,i},yhead_mm{1,i}-ycentral_mm{1,i});
end

units=struct('num','mm','den',[]);
data=centralheadmag;
filename=[outputfolder, 'centralheadmag.mat'];
save(filename, 'data', 'units')