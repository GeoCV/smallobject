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
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % (Quaternion) Discrete Cosine Transform ((Q)DCT)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

    % ====================================================================
    % DCT Image Signatures - "simple" single-channel and averaging
    % ====================================================================
    case {'dct'}
      channel_isi=zeros(size(IR));
      channel_di=zeros(size(IR));
      
      % calculate "saliency" for each channel
      for i=1:1:nchannels
        % calculate the channel ssaliency / conspicuity map
        [channel_saliency(:,:,i),channel_isi(:,:,i),channel_di(:,:,i)]=spectral_dct_saliency(IR(:,:,i));
        
        % filter the conspicuity maps
        if ~isempty(cmap_smoothing_filter_params)
          channel_saliency_smoothed(:,:,i)=imfilter(channel_saliency(:,:,i), fspecial(cmap_smoothing_filter_params{:})); % @note: smooth each channel vs. smooth the aggregated/summed map
        else
          channel_saliency_smoothed(:,:,i)=channel_saliency(:,:,i);
        end
        
        % normalize the conspicuity maps
        switch cmap_normalization % simple (range) normalization
          case {1}
            % simply normalize the value range
            cmin=min(channel_saliency_smoothed(:));
            cmax=max(channel_saliency_smoothed(:));
            if (cmin - cmax) > 0
              channel_saliency_smoothed=(channel_saliency_smoothed - cmin) / (cmax - cmin);
            end

          case {0}
            % do nothing
            
          otherwise
            error('unsupported normalization')
        end
      end
          
      % uniform linear combination of the channels
      S=mean(channel_saliency_smoothed,3);
      
      % filter the saliency map
      if ~isempty(smap_smoothing_filter_params)
        if ischar(smap_smoothing_filter_params{1}) && strcmp('anigauss',smap_smoothing_filter_params{1})
          S=anigauss(S,smap_smoothing_filter_params{2});
        else
          S=imfilter(S, fspecial(smap_smoothing_filter_params{:}));
        end
      end
          
      if do_figures
        figure('name','Saliency / Channel');
        for i=1:1:nchannels
          subplot(4,nchannels,0*nchannels+i);
          if do_channel_image_mattogrey
            subimage(mat2gray(IR(:,:,i))); 
          else
            subimage(IR(:,:,i));
          end
          title(['Channel ' int2str(i)]);
        end
        for i=1:1:nchannels
          subplot(4,nchannels,1*nchannels+i);
          subimage(mat2gray(channel_saliency_smoothed(:,:,i))); 
          title(['Channel ' int2str(i) ' Saliency']);
        end
        for i=1:1:nchannels
          subplot(4,nchannels,2*nchannels+i);
          subimage(mat2gray(channel_isi(:,:,i))); 
          title(['Channel ' int2str(i) ' Image Signature']);
        end
        for i=1:1:nchannels
          subplot(4,nchannels,3*nchannels+i);
          subimage(mat2gray(channel_di(:,:,i))); 
          title(['Channel ' int2str(i) ' DCT']);
        end
      end

  

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % DUMMY IMPLEMENTATIONS
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    case {'ones'}
      S=double(ones(imsize));
      
    case {'zeros'}
      S=double(ones(imsize));
      
    case {'random'}
      S=rand(imsize);
      
    case {'center-bias','centerbias'}
      if numel(imsize) == 1
        imsize=[size(I,1) size(I,2)];
      end
      
      x = ones(imsize(1),1)*[1:imsize(2)];
      y = [1:imsize(1)]'*ones(1,imsize(2));
      
      S=double(zeros(imsize));
      
      % center the Gaussian in the image
      y0 = imsize(1)/2;
      x0 = imsize(2)/2;
      
      % define width/height std. dev.
      h0 = imsize(1)/4;
      w0 = imsize(2)/4;      
      
      S  = S + ( exp((-(x-x0).^2)/w0^2) .* exp((-(y-y0).^2)/h0^2) );

    otherwise
      error('unsupported multichannel saliency calculation mode')

  end
  
  if do_figures
    figure('name',['Saliency (' multichannel_method ')']);
    subplot(1,2,1); imshow(I);
    subplot(1,2,2); imshow(mat2gray(imresize(S, imorigsize(1:2))));
  end
     