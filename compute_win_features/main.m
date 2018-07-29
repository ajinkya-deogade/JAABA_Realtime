tic

load_data = 1;
classifier_preprocessing = 1;
save_scores = 0;

if load_data > 0
    
    if classifier_preprocessing > 0
        outputFolder = '';
        % TestCrawl
        fileName = 'C:\Users\deogadea\Documents\MATLAB\JAABA\oldCLT_update\classifiers_100spine\20150721_crawl.jab';
        prefix = '_crawl_classifier.mat';
        % Test Turn
        %         fileName = 'C:\Users\deogadea\Documents\MATLAB\JAABA\oldCLT_update\classifiers_100spine\stop_cast\20150730_stop_cast_past.jab';
        %         prefix = '_turn_classifier.mat';
        extractEssentialClassifierParameters(fileName, outputFolder, prefix)
    end
    
    %% Dir Paths
    expDir = 'C:\Users\deogadea\Documents\MATLAB\JAABA\oldCLT_update\TRX_Files\Used_TRX_Files\stop_cast_&_turn\SpineLength_100\GroundTruth\kinData6';
    %     fileNameClassifier = '20150723_crawl_classifier.mat';
    
    %     fileNameClassifier = '20150730_turn_classifier.mat';
    fileNameClassifier = '20150730_stop_cast_classifier.mat';
    
    %% Feature List
    
    %     featureList = {{'velmagtail', 'stat', 'mean', 'trans', 'relative', 'radius', 30,'offset', -30},
    %         {'velmagtail', 'stat', 'mean', 'trans', 'relative', 'radius', 12,'offset', -12},
    %         {'velmagtail', 'stat', 'min', 'trans', 'none', 'radius', 15,'offset', -15},
    %         {'centralheadmag', 'stat', 'min', 'trans', 'none', 'radius', 15,'offset', -15},
    %         {'centralheadmag', 'stat', 'min', 'trans', 'none', 'radius', 30,'offset', -30}};
    %     featureList = load('feature_names_all_test_crawl.mat');
    featureList = load('feature_names_all_stop_cast.mat');
    featureList = featureList.feature_names_all;
    
    %% Load Experiment and Read Classifier
    [perframedata, fastPredict, tStartAll, tEndAll] = readDataAndLoadClassifier_3(fileNameClassifier, expDir, featureList);
    
end

%% Predict Experiment
all_pred = [];
i = 1;
window = 90;
for i = window+1:11011
    tEndAll = i;
    tStartAll = tEndAll-window;
    perframe_data_curr = structfun(@(x) x(tStartAll:tEndAll), perframedata, 'UniformOutput', false);
    %     perframe_data_curr = perframedata;
    [pred, ~] = PredictWholeMovie_2(tStartAll, tEndAll, perframe_data_curr, fastPredict);
    all_pred(i) = pred;
end

if save_scores > 0
    fileName = 'C:\Users\deogadea\Documents\MATLAB\JAABA\oldCLT_update\classifiers_100spine\20150721_crawl.jab';
    outputFolder = '';
    prefix = '_scores_stop_cast_classifier.mat';
    [filePath] = addDateToFilename('./', fileName, prefix);
    save(filePath, 'allScores','-mat');
end

toc

% plot(1:length(all_pred), all_pred, 'r.-')

%% Quality Check
% scores_jaaba_detect = load('scores_jaabadetect_test_crawl.mat','-mat');
scores_jaaba_detect = load('20150730_scores_stop_cast_past_jaabadetect.mat','-mat');
score_match = allScores - scores_jaaba_detect.allScores;
score_match = length(find(score_match))

