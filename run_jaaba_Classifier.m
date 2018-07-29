function run_jaaba_Classifier(inputfile, fileNameClassifier, featureListFile)
    tic
    addpath('.\perframe');
    addpath('.\JAABA_RealTime_10');

    tic
    display('Converting Raw Data to kinData Format......');
    [~, ~, kinData] = JLight(inputfile, '.\Data\', 1);
    toc

    tic
    display('Computing Spines......');
    kinData_spine = computeSpine_kinData(kinData);
    toc

    tic
    display('Converting kinData to JAABA Trx Format......');
    outputfolder_trx = '.\Data\TRX\';

    if exist(outputfolder_trx,'dir') ~= 7
        mkdir(outputfolder_trx);
    end
    expDir = createtrxhighresnospinecomputation_cluster(inputfile, kinData_spine, outputfolder_trx);
    toc

    tic
    display('Computing JAABA Perframe Features......');
    %     expDir = 'C:\Users\deogadea\Documents\MATLAB\JAABA_RealTime_12\Data\TRX\20141113-172916';
    expDir = strcat(expDir, filesep);
    allperframefeatureshighres_cluster(expDir);
    toc
    %         fileNameClassifier = '.\Data\20150811_crawl_classifier.mat';
    %         featureListFile = '.\Data\feature_names_all_test_crawl.mat';
    %         inputfile = '.\Data\20141113-172916_data.txt';
    tic
    [allScores] = predictAllBehavior_scores(fileNameClassifier, expDir, featureListFile);
    toc
    %     [classifierinfo, allScores] = JAABADetect(outputfolder_exp, 'jabfiles', classifierFiles);
    score_file = '.\Data\scores.mat';
    save(score_file, 'allScores');
    toc
end