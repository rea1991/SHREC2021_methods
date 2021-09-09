clc; clear; close all;

% INPUT AND OUTPUT
% This function requires two input files: 
% *) The ground truth classification vector "ground2.txt", here precomputed
%    from the cla file; 
% *) A dissimilarity matrix, here pre-permuted as described in the readme 
%    in the folder "evaluation_measures".
% It computes and plots the confusion matrices and saves them in the output
% folder.
%
% PARAMETERS
% When "coarse" is set to 0, it computes the statistics provided in Table
% 5 (PDB-based community decomposition). Optionally aggregates some classes
% if "coarse" is set to 1:
% *) Table 6 (BLAST-based community decomposition of level 3) is obtained
% by setting ground_truth to "GT2".
% *) Table 7 (BLAST-based community decomposition of level 2) is obtained
% by setting ground_truth to "GT3".
%
% Additionally, the user should set the task type ("geom" or "geomchem")
% and the run (1, 2 or 3; the only exception is for P=5, that has a
% single run for the task "geomchem" --> the code will generate an error,
% just ignore it).


% Task type (set to "geom" or "geomchem")
task = "geom";

% Run number (set to 1, 2, or 3; note that P5 has only one run for
% geomchem)
run = 1;

% Coarser classification?
coarse = 0;

% Ground truth (either "GT2" or "GT3", to be set if coarse==1).
ground_truth = "GT2";

if coarse==1
    if ground_truth == "GT2"
        macro_classes_path = "macro_classes_GT2.txt";
    else
        macro_classes_path = "macro_classes_GT3.txt";
    end
    macro_classes = load(macro_classes_path);
end

for P=1:5
    close all;
    
    if task=="geom"
        dissMat_Participant = "../../dissimilarity_matrices/P" + ...
            num2str(P) +"/"+ task + "/run" + run + "A.matrixPerm.txt";
    else
        dissMat_Participant = "../../dissimilarity_matrices/P" + ...
            num2str(P) +"/"+ task + "/run" + run + "B.matrixPerm.txt";
    end
    
    actual = load("../ground2.txt");
    actual = actual(:,2);
    [successi,classlabel]=valuta_classificazioneNN('../ground2.txt', dissMat_Participant);
    predicted = classlabel(:,2);
    
    if coarse==1
        for i=1:size(actual,1)
            actual(i) = macro_classes(actual(i),2);
            predicted(i) = macro_classes(predicted(i),2);
        end
    end
    
    
    
    confusion = my_confusion_matrix(predicted, actual);
    %set(gcf,'Position',[100 100 250 250])
    % imagesc(confusion)
    % %colormap("colorcube")
    % winter2 = jet(128);
    % winter2(end,:) = [1 1 1];
    % colormap(flipud(winter2))
    % colorbar
    
    
    %% NON-LINEAR  HSVCOLORMAP
    cMap = jet(128);
    dataMax = 1543;
    dataMin = 0;
    centerPoint = 1;
    scalingIntensity = 10;
    
    x = 1:length(cMap);
    x = x - (centerPoint-dataMin)*length(x)/(dataMax-dataMin);
    x = scalingIntensity * x/max(abs(x));
    x = sign(x).* exp(abs(x));
    x = x - min(x); x = x*511/max(x)+1;
    newMap = interp1(x, cMap, 1:512);
    %newMap(1,:) = [1 1 1];
    
    
    h = figure;
    imagesc(confusion); colormap(newMap);
    %colorbar
    set(gcf,'Position',[100 100 250 250])
    axis square
    caxis([0 160])
    title ("P" + num2str(P) + ", run " + num2str(run))
    
    if coarse
        saveas(h, "./output/" + ground_truth + "_conf_mat_P" + num2str(P) + ...
            "_"+ task + "_run" + run, "epsc");
    else
        saveas(h, "./output/GT1_conf_mat_P" + num2str(P) + ...
            "_"+ task + "_run" + run, "epsc");
    end
end
