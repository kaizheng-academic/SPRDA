# GAPDA
piRNA and PIWI proteins have been confirmed for disease diagnosis and treatment as novel biomarkers due to its abnormal expression in various cancers. However, the current research is not strong enough to further clarify the functions of piRNA in cancer and its underlying mechanism. Therefore, how to provide large-scale and serious piRNA candidates for biological research has grown up to be a pressing issue. In this study, a novel computational model based on the structural perturbation method is proposed to predict potential disease-associated piRNAs, called SPRDA. Notably, SPRDA belongs to positive-unlabeled learning, which is unaffected by negative examples in contrast to previous approaches. In the five-fold cross-validation, SPRDA shows high performance on the benchmark dataset piRDisease, with an AUC of 0.9529. Furthermore, the predictive performance of SPRDA for 10 diseases shows the robustness of the proposed method. Overall, the proposed approach can provide unique insights into the pathogenesis of the disease and will advance the field of oncology diagnosis and treatment.

# Requirements
* matlab 2018b

The code has been tested on the Windows platform.

# Dataset Description
* 5-cv.mat: Adjacency matrixes for five-fold cross-validation;
* disease_RNA_A.mat: Complete piRNA-disease association matrix;
* DS_small_gene.mat: Disease functional similarity network;
* PS_small.mat: piRNA sequence similarity network;
* Gaussian.mat: the piRNA and disease Gaussian interaction profile kernel similarity networks;

# Functions Description
* ```SPRDA.m```: this function can implement the SPRDA algorithm;

# Train and test folds

run ```SPRDA.m```

All files of Data and Code should be stored in the same folder to run the model.





