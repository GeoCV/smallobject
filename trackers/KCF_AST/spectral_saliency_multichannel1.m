function S=spectral_saliency_multichannel(I,imsize,multichannel_method,smap_smoothing_filter_params,cmap_smoothing_filter_params,cmap_normalization,extended_parameters,do_figures,do_channel_image_mattogrey)
 
  %if nargin<2, imsize=1; end % use original image size
  if nargin<2, imsize=[NaN 64]; end
  if nargin<3, multichannel_method='fft'; end
  %if nargin<4, smap_smoothing_filter_params={'anigauss',2.5}; end
  if nargin<4, smap_smoothing_filter_params={'gaussian',9,2.5}; end
  if nargin<5, cmap_smoothing_filter_params={}; end
  if nargin<6, cmap_normalization=1; end
  if nargin<7, extended_parameters={}; end
  if nargin<8, do_figures=false; end
  if nargin<9, do_channel_image_mattogrey=true; end
  
  do_force_double_image_type=false; % force the image to have type double (this is problematic, e.g., for the results of DCT Image Signatures for RGB on the Bruce-Tsotsos data set)
  
  if ~isfloat(I) && do_force_double_image_type
    I=im2double(I);
  end
  imorigsize=size(I);
  IR=imresize(I, imsize, 'bicubic'); % @note: the resizing method has an influence on the results, take care!
  
  nchannels=size(IR,3);
  channel_saliency=zeros(size(IR));
  channel_saliency_smoothed=zeros(size(IR));
  
  switch multichannel_method

    % ====================================================================
    % Quaternion-based DCT image signatures (QDCT)
    % ====================================================================
    %%
    case {'quat:dct','quaternion:dct'}
      if isempty(extended_parameters)
        [S,DCTIR,IDCTIR]=spectral_dct_saliency_quaternion(IR);
      end
%       if iscell(extended_parameters)
%         [S,DCTIR,IDCTIR]=spectral_dct_saliency_quaternion(IR,extended_parameters{:});
%       end
      if isstruct(extended_parameters)
        % set default values
        absexp = 2;
        dctaxis = unit(quaternion(-1,-1,-1));
        L = 'L';
        % set user specified parameters
        if isfield(extended_parameters,'absexp'), absexp = extended_parameters.absexp; end
        if isfield(extended_parameters,'dctaxis'), dctaxis = extended_parameters.dctaxis; end
        if isfield(extended_parameters,'L'), L = extended_parameters.L; end
        [S,DCTIR,IDCTIR]=spectral_dct_saliency_quaternion(IR,absexp,dctaxis,L);
      end
      if ~isempty(smap_smoothing_filter_params)
        if ischar(smap_smoothing_filter_params{1}) && strcmp('anigauss',smap_smoothing_filter_params{1})
          S=anigauss(S,smap_smoothing_filter_params{2});
        else
          S=imfilter(S,fspecial(smap_smoothing_filter_params{:}));
        end
      end

      if do_figures
        visualize_quaternion_image(sign(DCTIR));
        visualize_quaternion_image(IDCTIR);
      end
  end