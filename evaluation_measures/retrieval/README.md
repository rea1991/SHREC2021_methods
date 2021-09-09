The codes in this folder allows to reproduce the retrieval measures provided in the paper.


### NN, 1T, 2T, eM and DCG (Table 3)
To compute the retrieval measures NN, 1T, 2T, eM and DCG, one needs to use the routine ``psbTable.exe``. A precompiled version, available for Ubuntu 18.04, is provided. As an alternative, one could compile the source code (see the folder ``source_codes``). To run the precompiled, type in the terminal the command

``./psbTable.exe ../classTest.cla ../../dissimilarity_matrices/P1/geom/run1A.matrixPerm.txt``

where
-  P1,...,P5 are the five participants to the track.
-  "geom" and "geomchem" identify, respectively, the folders containing the dissimilarity matrices for Tasks A (only geometry) and B (geometry and physicochemical properties).

### Precision recalls (Figures 11, 12 and 19) and mAP (Table 3)
To compute the precision recalls, one needs to use the routine ``prerec.exe``. A precompiled version is provided. To run it on Ubuntu 18.04, use the command:

``wine prerec.exe lista-protein.txt lista-protein.txt ../../dissimilarity_matrices/P1/geom/run1A.matrixPerm.txt ./output/prerec/P1_geom_run1.txt 20``

One can use the MATLAB routines ``plotPrerec_geom.m``, ``plotPrerec_geomchem.m``, ``plotBestPrerec_geom.m`` and ``plotBestPrerec_geomchem.m`` to plot the precision recalls. The mAP coefficients of Table 3 are obtained via the MATLAB routine ``mainMAP.m``.

### ADR (Tables 4 and 8) and NDCG (Figures 12 and 19)
- First, run the MATLAB routine ``main_mean_ADR_DCG.m``: it allows to get the numbers contained in Tables 4 and 8, as well as some quantities that are used to plot the NDCGs..
- Then, run the MATLAB routine ``plotNDCG.m``: it allows to reproduce all but one images in Figures 12 and 19 (the best run per participants are obtained by the MATLAB routine ``plotBestNDCG.m``).
