# DNN-based-correction
A deep neural network based correction scheme for improved air-tissue boundary prediction in real-time magnetic resonance imaging video
\\
Description about the folders:
generate_normal: 
Contains files related to normal generation for validation, test, and train data sets.
Example: New_Data_Gen_dev_per_upper -- To generate normals for validation data for the given ranges of percentiles
DNN_dist_full, DNN_disc_full:
Contain files related to grid data generation using the optimum values, training of DNN, corrected ATB generation using the outputs of DNN, evaluation of DTW score between the corrected and ground truth ATBs.
DNN_dist_full: considers the distance between the ground truth ATB point and  the starting point of the grid as the taget output for DNN training.
DNN_disc_full: considers the index of the ground truth ATB point with respect to the grid as the target output for DNN tranining.
Codes:




