function [perframedata, fastPredict, tStartAll, tEndAll] = readDataAndLoadClassifier_3(fileNameClassifier, expDir, featureList)

%% Load Classifier
[fastPredict] = loadandprocessClassifier(fileNameClassifier, featureList);

%% Load Experiment
[perframedata, tStartAll, tEndAll] = loadTrxandPerframe_3(expDir, fastPredict);

%% Rearange WindowFeatureParameters for ComputeWindowFeatureParameter
fields_perframedata = fieldnames(perframedata);
for m = 1:numel(fields_perframedata)
    fn = fields_perframedata{m};
    select_windowfeaturescellparams = [fastPredict.select_windowfeaturescellparams.(fn)];
    for j=1:2:length(select_windowfeaturescellparams)-1
        if(strcmpi(select_windowfeaturescellparams{j},'trans_types'))
            tmp=uint8(0);
            if ischar(select_windowfeaturescellparams{j+1})
                warning('Trans types is string. It should be cell');
                select_windowfeaturescellparams{j+1} = {select_windowfeaturescellparams{j+1}};
            end
            for i=1:length(select_windowfeaturescellparams{j+1})
                if(strcmpi('none',select_windowfeaturescellparams{j+1}(i)))      tmp=bitor(1,tmp);  end
                if(strcmpi('abs',select_windowfeaturescellparams{j+1}(i)))       tmp=bitor(2,tmp);  end
                if(strcmpi('flip',select_windowfeaturescellparams{j+1}(i)))      tmp=bitor(4,tmp);  end
                if(strcmpi('relative',select_windowfeaturescellparams{j+1}(i)))  tmp=bitor(8,tmp);  end
            end
            select_windowfeaturescellparams{j+1}=tmp;
        end
    end
    
    for k=2:2:length(select_windowfeaturescellparams)
        if(iscell(select_windowfeaturescellparams{k}))
            for j=1:2:length(select_windowfeaturescellparams{k})-1
                if(strcmpi(select_windowfeaturescellparams{k}{j},'trans_types'))
                    tmp=uint8(0);
                    if ischar(select_windowfeaturescellparams{k}{j+1})
                        warning('Trans types is string. It should be cell');
                        select_windowfeaturescellparams{k}{j+1} = {select_windowfeaturescellparams{k}{j+1}};
                    end
                    
                    for(i=1:length(select_windowfeaturescellparams{k}{j+1}))
                        if(strcmpi('none',select_windowfeaturescellparams{k}{j+1}(i)))      tmp=bitor(1,tmp);  end
                        if(strcmpi('abs',select_windowfeaturescellparams{k}{j+1}(i)))       tmp=bitor(2,tmp);  end
                        if(strcmpi('flip',select_windowfeaturescellparams{k}{j+1}(i)))      tmp=bitor(4,tmp);  end
                        if(strcmpi('relative',select_windowfeaturescellparams{k}{j+1}(i)))  tmp=bitor(8,tmp);  end
                    end
                    select_windowfeaturescellparams{k}{j+1}=tmp;
                end
            end
        end
    end
    fastPredict.winFeaSorted{m} = select_windowfeaturescellparams;
end