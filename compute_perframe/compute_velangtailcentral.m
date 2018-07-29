%compute velang_tailcentral
function [trx]=compute_velangtailcentral(trx,outputfolder)
inputfilename=[outputfolder,'dxtailcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_dxtailcentral_mm(trx,outputfolder);
end
load([outputfolder,'dxtailcentral_mm.mat'], 'data')
dxtailcentral_mm=data;
inputfilename=[outputfolder,'dytailcentral_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_dytailcentral_mm(trx,outputfolder);
end
load([outputfolder,'dytailcentral_mm.mat'], 'data')
dytailcentral_mm=data;
numlarvae=size(trx,2);
velangtailcentral=cell(1,numlarvae);
for i=1:numlarvae
    velangtailcentral{1,i}=bsxfun(@atan2,dytailcentral_mm{1,i},dxtailcentral_mm{1,i});
end

units=struct('num','rad','den','s');
data=velangtailcentral;
filename=[outputfolder, 'velangtailcentral.mat'];
save(filename, 'data', 'units') 