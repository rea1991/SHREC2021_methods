# SHREC 2021: Retrieval and classification of protein surfaces equipped with physical and chemical properties

This repository shares the dissimilarity matrices and the routines that were used to produced the results in [1]. The dataset and the ground truths behind the benchmark can be found at:

https://github.com/rea1991/SHREC2021_dataset

### Dissimilarity matrices from the SHREC participants and evaluation measures
Five research groups registered to the track. The submitted dissimilarity matrices can be found inside the five folders in `dissimilarity_matrices`. The codes that were used to compute the evaluation measures are found in the three folders inside  `evaluation_measures`. To compare the performance of the methods that make use of the physicochemical properties against the simple geometric models, we asked the participants to perform two tasks:
- Task A: only the OFF files of the models are considered (i.e. only the geometry is considered);
- Task B: in addition to the geometry, the participant is asked to also consider the TXT files (physicochemical matching).


### Video presentation
The presentation of the benchmark at the 3DOR 2021 workshop is available at:
https://www.youtube.com/watch?v=PrqMuoewyYk


### References
[1]   A. Raffo, U. Fugacci, S. Biasotti, W. Rocchia, Y. Liu, E. Otu, R. Zwiggelaar, D. Hunter, E. I. Zacharaki, E. Psatha, D. Laskos, G. Arvanitis, K. Moustakas, T. Aderinwale, C. Christoffer, W.-H. Shin, D. Kihara, A. Giachetti, H.-N. Nguyen, T.-D. Nguyen, V.-T. Nguyen-Truong, D. Le-Thanh, H.-D. Nguyen, M.-T. Tran. "SHREC 2021: Retrieval and classification of protein surfaces equipped with physical and chemical properties", *Computers & Graphics*, vol. 99, pp. 1-21, 2021. DOI: 10.1016/j.cag.2021.06.010.
