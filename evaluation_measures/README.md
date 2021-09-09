### PRE-PROCESSING THE DISSIMILARITY MATRICES
Open MATLAB and move to the folder `evaluation_measures`. In the command window, type:

``permuteMatrix("../dissimilarity_matrices/P1/geom/run1A.matrix","./permutation.txt")``,

to permute the dissimilarity matrix `run1A.matrix` according to the true classification of the test set. This will produce the output file `run1A.matrixPerm.txt`. Repeat this step for all dissimilarity matrices. This is **mandatory** to the computation of any evaluation measure.

### GROUND TRUTHS

1)  **PDB-BASED CLASSIFICATION**.
Two files are available:
    - `ClassTraining.cla` is the PDB-based classification for the training set.
    - `ClassTest.cla` is the PDB-based classification for the test set.
    
    The file `ClassTest.cla` is used to generate: 
    - Tables 3, 5 
    - Figures 11, 13, 14

2) **BLAST-BASED COMMUNITY DECOMPOSITION OF LEVEL 3**.
The file `macro_classes_GT2.txt` joins clusters of protein surfaces starting from the clusters given in ClassTest.cla. It is used to generate:
    - Tables 4, 6
    - Figures 12, 15, 16

3) **BLAST-BASED COMMUNITY DECOMPOSITION OF LEVEL 2**.
The file `macro_classes_GT3.txt` further joins clusters of protein surfaces and is used to generate: 
    - Tables 7, 8
    - Figures 17 18, 19
