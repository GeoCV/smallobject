
function out = get_sal_context(img)

    saliency_map_resolution = [48 64];                  % the target saliency map resolution; the most important parameter for spectral saliency approaches
    smap_smoothing_filter_params = {'gaussian',9,2.5};  % filter parameters for the final saliency map
    cmap_smoothing_filter_params = {};                  % optionally, you can also smooth the conspicuity maps
    cmap_normalization = 1;                             % specify the normalization of the conspicuity map here
    extended_parameters = {};                           % @note: here you can specify advanced algorithm parameters for the selected algorithm, e.g. the quaternion axis
    do_figures = false;                                 % enable/disable spectral_saliency_multichannel's integrated visualizations
    img=double(img)/255;
    sm = spectral_saliency_multichannel(img,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);%get_sal(img); % get the processed saliency information
    sm=mat2gray(sm);

    sm = imresize(sm, [size(img,1),size(img,2)]);
    out =sm ; % mixture in Eq.(1)

end

