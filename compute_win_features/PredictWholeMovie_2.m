function [behavioral_prediction, scores] = PredictWholeMovie_2(tStartAll, tEndAll, perframedata, fastPredict)

windowfeaturescellparams = fastPredict.windowfeaturescellparams;
curperframefns = fastPredict.pffs;
classifier = fastPredict.select_classifier;
blockSize = 10000;
tStart = tStartAll;
tEnd = tEndAll;
scores = nan(1,tEnd);
feature_names=cell(1,numel(curperframefns));

if tEnd-tStart < 3,
    scores(tStart:tEnd) = -1;
    fprintf('Not predicting. Trajectory is too short\n');
else
    for curt0 = tStart:blockSize:tEnd
        curt1 = min(curt0+blockSize-1, tEnd);
        fields_perframedata = fieldnames(perframedata);
        X = [];
        for j = 1:numel(fields_perframedata)
            fn = fields_perframedata{j};
            t00 = curt0-tStart+1;
            t11 = min(curt1-tStart+1, numel(perframedata.(fn)));
            %             [x_curr, feature_names_curr] = ComputeWindowFeatures(perframedata.(fn), windowfeaturescellparams.(fn){:},'t0',t00,'t1', t11);
            fastPredict.winFeaSorted{j}{end+1} = 't0';
            fastPredict.winFeaSorted{j}{end+1} = t00;
            fastPredict.winFeaSorted{j}{end+1} = 't1';
            fastPredict.winFeaSorted{j}{end+1} = t11;
            [x_curr, ~] = ComputeWindowFeatures(perframedata.(fn), fastPredict.winFeaSorted{j}{:});
            
            if t11 < curt1-tStart+1,
                x_curr(:,end+1:end+(curt1-tStart+1)-t11) = nan;
            end
            
            nold = size(X,1);
            nnew = size(x_curr,2);
            if nold > nnew,
                warning('Number of examples for per-frame feature %s does not match number of examples for previous features',fn);
                x_curr(:,end+1:end+nold-nnew) = nan;
            elseif nnew > nold && ~isempty(X),
                warning('Number of examples for per-frame feature %s does not match number of examples for previous features',fn);
                X(end+1:end+nnew-nold,:) = nan;
            end
            X = [X, x_curr']; %#ok<AGROW>
%             feature_names{j} = cellfun(@(s) [{fn},s],feature_names_curr,'UniformOutput',false); %#ok<AGROW>
            
        end
% %         wfidx = FindWfidx_2(fastPredict.wfs, [feature_names{:}]);
        X = single(X);
        scores(curt0:curt1) = myBoostClassify(X(:,fastPredict.select_wfidx), classifier);
    end
end

if scores(end) > 0
    behavioral_prediction = 1;
else
    behavioral_prediction = 0;
end

% scoresA = scores;
% scoreNorm = prctile(abs(scoresA),80);
% scoresA(scoresA<-scoreNorm) = -scoreNorm;
% scoresA(scoresA>scoreNorm) = scoreNorm;
% scoresA = scoresA/scoreNorm;

% postprocessparams.method = 'Hysteresis';
% postprocessparams.hystopts(1) = struct('name','High Threshold','tag','hthres','value',0);
% postprocessparams.hystopts(2) = struct('name','Low Threshold','tag','lthres','value',0);
% postprocessparams.filtopts(1) = struct('name','Size','tag','size','value',1);
% postprocessparams.blen = 1;
%
% allScores = struct;
% postprocessedscoresA = nan(1,tEndAll(1));
% % postprocessedscoresA(tStartAll(1):tEndAll(1)) = ApplyHysteresis(scoresA(tStartAll(1):tEndAll(1)), postprocessparams, windowdata);
%
% allScores.scores = scoresA;
% allScores.tStart = tStartAll;
% allScores.tEnd = tEndAll;
% allScores.postprocessed = postprocessedscoresA;
% allScores.postprocessparams = postprocessparams;
%
% [i0s,i1s] = get_interval_ends(allScores.postprocessed > 0);
% allScores.t0s{1} = i0s;
% allScores.t1s{1} = i1s;

% allScores.scoreNorm = windowdata.scoreNorm;

end