function x = get_features(im, features, cell_size, cos_window,pos)
%GET_FEATURES
%   Extracts dense features from image.
%
%   X = GET_FEATURES(IM, FEATURES, CELL_SIZE)
%   Extracts features specified in struct FEATURES, from image IM. The
%   features should be densely sampled, in cells or intervals of CELL_SIZE.
%   The output has size [height in cells, width in cells, features].
%
%   To specify HOG features, set field 'hog' to true, and
%   'hog_orientations' to the number of bins.
%
%   To experiment with other features simply add them to this function
%   and include any needed parameters in the FEATURES struct. To allow
%   combinations of features, stack them with x = cat(3, x, new_feat).
%
%   Joao F. Henriques, 2014
%   http://www.isr.uc.pt/~henriques/
saliency_map_resolution = [162 237];                  % the target saliency map resolution; the most important parameter for spectral saliency approaches
smap_smoothing_filter_params = {'gaussian',9,2.5};  % filter parameters for the final saliency map
cmap_smoothing_filter_params = {};                  % optionally, you can also smooth the conspicuity maps
cmap_normalization = 1;                             % specify the normalization of the conspicuity map here
extended_parameters = {};                           % @note: here you can specify advanced algorithm parameters for the selected algorithm, e.g. the quaternion axis
do_figures = false;                                 % enable/disable spectral_saliency_multichannel's integrated visualizations


	if features.hog,
		%HOG features, from Piotr's Toolbox
		x = double(fhog(single(im) / 255, cell_size, features.hog_orientations));
		x(:,:,end) = [];  %remove all-zeros channel ("truncation feature")
	end
	
	if features.gray,
		%gray-level (scalar feature)
		x = double(im(:,:,1)) / 255;
		x = x - mean(x(:));
    end
    
    if features.mix,
		%gray-level (scalar feature)
        x = double(fhog(single(im) / 255, cell_size, features.hog_orientations));
		x(:,:,end) = [];
        im=imresize(im,[size(x,1),size(x,2)]);
		x(:,:,32) = double(im(:,:,1)) / 255;
		x(:,:,32) = x(:,:,32) - mean(mean(x(:,:,32)));
    end
	
%     if features.qdct,
% 		%gray-level (scalar feature)
% 		%x = double(im) / 255;
% 		%x = spectral_saliency_multichannel(x,saliency_map_resolution,'quat:dct',smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures);
%         scale=1;
%         hamming_window = hamming(sz(1)) * hann(sz(2))'; % use Hamming window to reduce frequency effect of image boundary, as explained in Sec.5
%         sigma = mean(sz); % initial \sigma_1 for the weight function w_{\sigma} in Eq.(11)
%         [rs, cs] = ndgrid((1:sz(1)) - floor(sz(1)/2), (1:sz(2)) - floor(sz(2)/2));
%         dist = rs.^2 + cs.^2;
%         window = hamming_window.*exp(-0.5 / (sigma^2) *(dist));
%         window = window/sum(sum(window)); % normalization
%         x = get_sal_context(im);
%         %figure;imshow(x);
%     
%     end

	%process with cosine window if needed
	if ~isempty(cos_window),
		x = bsxfun(@times, x, cos_window);
	end
	
end
