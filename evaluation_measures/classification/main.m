clc; clear; close all;

% INPUT AND OUTPUT
% This function requires two input files: 
% *) The ground truth classification vector "ground2.txt", here precomputed
%    from the cla file; 
% *) A dissimilarity matrix, here pre-permuted as described in the readme 
%    in the folder "evaluation_measures".
% It computes several statistics from the corresponding confusion matrix: 
% TPR, TNR, PPV, NPV, ACC, F1.
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
% Additionally, the user should set the participant number P, the task type
% ("geom" or "geomchem"), the run (1, 2 or 3; the only exception is for P=5, 
% that has a single run for the task "geomchem" --> the code will generate 
% an error, just ignore it).


% Participant (integer from 1 to 5)
P = 1;

% Task type (set to "geom" or "geomchem")
task = "geom";

% Run number (set to 1, 2, or 3; note that P5 has only one run for
% geomchem)
run = 1;

% Coarser classification?
coarse = 0;

% Ground truth (either "GT2" or "GT3", to be set if coarse==1).
ground_truth = "GT2";


%% PREDICTED

if coarse==1
    if ground_truth == "GT2"
        macro_classes = load("../macro_classes_GT2.txt");
    else
        macro_classes = load("../macro_classes_GT3.txt");
    end
end

if task=="geom"
    [successi,classlabel]= valuta_classificazioneNN("../ground2.txt",...
        "../../dissimilarity_matrices/P" + num2str(P) + "/" + task + "/run" + num2str(run) + ...
        "A.matrixPerm.txt");
else
    [successi,classlabel]= valuta_classificazioneNN("../ground2.txt",...
        "../../dissimilarity_matrices/P" + num2str(P) + "/" + task + "/run" + num2str(run) + ...
        "B.matrixPerm.txt");
end
predicted = classlabel(:,2);

%% ACTUAL
actual = load("../ground2.txt");
actual = actual(:,2);


if coarse==1
    for i=1:size(actual,1)
        actual(i) = macro_classes(actual(i),2);
        predicted(i) = macro_classes(predicted(i),2);
    end
end


card_classes = zeros(max(actual),1);
for i=1:length(card_classes)
   card_classes(i) = sum(actual==i); 
end


%% CONFUSION MATRIX AND ITS STATISTICS
confusion = my_confusion_matrix(predicted, actual);
TP = diag(confusion);
FN = zeros(size(TP));
FP = zeros(size(TP));
TN = zeros(size(TP));
for i=1:length(FN)
    FN(i) = sum(confusion(i,:))-TP(i);
    FP(i) = sum(confusion(:,i))-TP(i);
    TN(i) = sum(sum(confusion([1:i-1,i+1:end],[1:i-1,i+1:end])));
end

TPR = TP./(TP+FN); TPR(isnan(TPR))=0;
TNR = TN./(TN+FP); TNR(isnan(TNR))=0;
PPV = TP./(TP+FP); PPV(isnan(PPV))=0;
NPV = TN./(TN+FN); NPV(isnan(NPV))=0;
ACC = (TP+TN)./(TP+TN+FP+FN);
F1 = (2*TP)./(2*TP+FP+FN);


disp("Average TPR is: " + num2str(sum(card_classes.*TPR)/sum(card_classes)))
disp("Average TNR is: " + num2str(sum(card_classes.*TNR)/sum(card_classes)))
disp("Average PPV is: " + num2str(sum(card_classes.*PPV)/sum(card_classes)))
disp("Average NPV is: " + num2str(sum(card_classes.*NPV)/sum(card_classes)))
disp("Average ACC is: " + num2str(sum(card_classes.*ACC)/sum(card_classes)))
disp("Average F1  is: " + num2str(sum(card_classes.*F1)/sum(card_classes)))

disp("Latexitazion....");
disp(num2str(sum(card_classes.*TPR)/sum(card_classes)) + " & " + ...
    num2str(sum(card_classes.*TNR)/sum(card_classes)) + " & "  +...
    num2str(sum(card_classes.*PPV)/sum(card_classes)) + " & " + ...
    num2str(sum(card_classes.*NPV)/sum(card_classes)) + " & " + ...
    num2str(sum(card_classes.*ACC)/sum(card_classes)) + " & " + ...
    num2str(sum(card_classes.*F1)/sum(card_classes)) + " \\");
