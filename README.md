# DNN-based-correction
A deep neural network based correction scheme for improved air-tissue boundary prediction in real-time magnetic resonance imaging video\
Description about the folders:\
generate_normal: \
Contains files related to normal generation for validation, test, and train data sets.\
Example: New_Data_Gen_dev_per_upper -- To generate normals for validation data for the given ranges of percentiles\
DNN_dist_full, DNN_disc_full:\
Contain files related to grid data generation using the optimum values, training of DNN, corrected ATB generation using the outputs of DNN, evaluation of DTW score between the corrected and ground truth ATBs, and smoothing of the corrected ATBs.\
DNN_dist_full: considers the distance between the ground truth ATB point and the starting point of the grid as the taget output for DNN training.\
DNN_disc_full: considers the index of the ground truth ATB point with respect to the grid as the target output for DNN tranining.\
Codes:\
Intensity_Profile_Generator_per_lower -- generates grid data for different percentile values for tranining data for lower ATB.\
Bulk_Training_Grid_per.ipynb -- DNN training\
Pred_Grid_CSV_per.ipynb -- To get predictions from DNN for both train and validation data.\
CSV_to_Contour_GridWise_per -- To generate corrected ATBs for train and validation data using the predictions from DNN.\
MA_DTW_per -- DTW scores for different values of percentile values for validation data.\
MA_cont_rad -- Smooths the corrected ATBs using local regression lines based approach for different radius values and generates optimum values for grid generation and radious values for test data. \
Test_Intensity_Gen -- To generate grid data for test data using optimum values.\
Pred_Grid_CSV.ipynb -- To get prediction for the test data.\
CSV_to_Contour_GridWise_KS -- To get corrected ATBs from the DNN outputs for test data.\
MA_Contours -- To smooth the corrected ATBs using the optimum radius value for test data.\
DTWDist_Performance --  Obtain DTW distance between the corrected and ground truth ATBs for test data.\







