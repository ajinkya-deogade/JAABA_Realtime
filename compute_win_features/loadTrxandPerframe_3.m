function [perframedata, tStartAll, tEndAll] = loadTrxandPerframe_3(expDir, fastPredict)

    load(fullfile(expDir, 'trx.mat'));
    perframedir = [expDir filesep 'perframe' filesep '*.mat'];
    filename = dir(perframedir);
    perframedir = [expDir filesep 'perframe' filesep];
    perframefiles = cell(1, numel(fastPredict.allperframefns));
    % curperframefns = fastPredict.pffs;

    for j = 1: length(fastPredict.pffs)
        fn = fastPredict.pffs{j};
        for i = 1:numel(filename)
            if strcmp(filename(i).name(1:end-4), fn)
                perframefiles{j} = [perframedir filename(i).name];
                temp = load(perframefiles{j},'-mat');
                perframedata.(filename(i).name(1:end-4)) = temp.data{1};
            end
        end
    end
    % for k = 1:numel(fastPredict.pffs)
    %     fn = fastPredict.pffs{k};
    %     ndx = find(strcmp(fn, fastPredict.allperframefns));
    %
    %     temp = load(perframefiles{ndx}, '-mat');  %#ok
    %     perframedata(k,:) = temp.data{1};  %#ok
    % end
    tStartAll = trx.firstframe;
    tEndAll = trx.endframe;

end