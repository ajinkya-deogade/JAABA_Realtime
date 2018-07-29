%compute dspinerelevantpositions

function [trx]=compute_dspinerelevantpositions(trx,outputfolder)
inputfilename=[outputfolder,'xhead_mm.mat'];
if ~exist(inputfilename,'file')
    [trx]=compute_spinerelevantpositions(trx,outputfolder);
end
load([outputfolder,'xhead_mm.mat'],'data');
xhead_mm=data;
load([outputfolder,'xcentral_mm.mat'],'data');
xcentral_mm=data;
load([outputfolder,'xtail_mm.mat'],'data');
xtail_mm=data;

load([outputfolder,'yhead_mm.mat'],'data');
yhead_mm=data;
load([outputfolder,'ycentral_mm.mat'],'data');
ycentral_mm=data;
load([outputfolder,'ytail_mm.mat'],'data');
ytail_mm=data;

numlarvae=size(trx,2);
dxhead_mm=cell(1,numlarvae);
dxcentral_mm=cell(1,numlarvae);
dxtail_mm=cell(1,numlarvae);
dyhead_mm=cell(1,numlarvae);
dycentral_mm=cell(1,numlarvae);
dytail_mm=cell(1,numlarvae);
for i=1:numlarvae
    dxhead_mm{1,i}=(xhead_mm{1,i}(2:end)-xhead_mm{1,i}(1:end-1))./trx(i).dt;
    dxcentral_mm{1,i}=(xcentral_mm{1,i}(2:end)-xcentral_mm{1,i}(1:end-1))./trx(i).dt;
    dxtail_mm{1,i}=(xtail_mm{1,i}(2:end)-xtail_mm{1,i}(1:end-1))./trx(i).dt;
    dyhead_mm{1,i}=(yhead_mm{1,i}(2:end)-yhead_mm{1,i}(1:end-1))./trx(i).dt;
    dycentral_mm{1,i}=(ycentral_mm{1,i}(2:end)-ycentral_mm{1,i}(1:end-1))./trx(i).dt;
    dytail_mm{1,i}=(ytail_mm{1,i}(2:end)-ytail_mm{1,i}(1:end-1))./trx(i).dt;
end


units=struct('num','mm','den','s');

data=dxhead_mm;
filename=[outputfolder, 'dxhead_mm.mat'];
save(filename, 'data', 'units')
data=dxcentral_mm;
filename=[outputfolder, 'dxcentral_mm.mat'];
save(filename, 'data', 'units')
data=dxtail_mm;
filename=[outputfolder, 'dxtail_mm.mat'];
save(filename, 'data', 'units')
data=dyhead_mm;
filename=[outputfolder, 'dyhead_mm.mat'];
save(filename, 'data', 'units')
data=dycentral_mm;
filename=[outputfolder, 'dycentral_mm.mat'];
save(filename, 'data', 'units')
data=dytail_mm;
filename=[outputfolder, 'dytail_mm.mat'];
save(filename, 'data', 'units')