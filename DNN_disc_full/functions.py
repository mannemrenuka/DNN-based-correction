import numpy
def intensity_data(a):
    stacked_arr = [];
    for b in a[0]:
        for c in b:
            stacked_arr = stacked_arr  + [i for i in c if i!=[]]
    stacked_arr = numpy.array([stacked_arr])
    stacked_arr = numpy.squeeze(stacked_arr)
    stacked_arr.shape
    return (stacked_arr)
