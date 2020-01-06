function genPerfMat(seqs, trackers, evalType, nameTrkAll, perfMatPath)
pathAnno = 'E:\tracking\anno_uav123_10fps\anno\UAV123_10fps\';%UAV123
pathAnno = 'E:\tracking\anno_uav20l/'%UAV20L
pathAnno = 'E:\tracking\anno_small90_112\';%small90,small112
%pathAnno = 'F:\ДњТы\OTB_tracker_benchmark_v1.0\tracker_benchmark_v1.0\tracker_benchmark_v1.0\anno-VisDrone2018-SOT-train\'
numTrk = length(trackers);

thresholdSetOverlap = 0:0.05:1;
thresholdSetError = 0:50;

switch evalType
    case 'SRE'
        rpAll=['E:\tracking\results\results_SRE_CVPR13\'];
    case {'OPE','TRE'} 
        %rpAll=['E:\lcl\tracking\results\results_UAV123_10fps\'];%10fps
        %rpAll=['E:\lcl\tracking\results\result_uav20l\'];%UAL20L
        %rpAll=['E:\lcl\tracking\results\results_small90\'];
       % rpAll=['E:\lcl\tracking\results\results_OPE_CVPR13\small90_ast\'];
       rpAll=['E:\tracking\results\results_OPE_KCF\'];
       %rpAll=['E:\tracking\results\results_small90_112\'];%small90,small112
end

for idxSeq=1:length(seqs)
    s = seqs{idxSeq};
    
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    nz	= strcat('%0',num2str(s.nz),'d'); %number of zeros in the name of image
    for i=1:s.len
        image_no = s.startFrame + (i-1);
        id = sprintf(nz,image_no);
        s.s_frames{i} = strcat(s.path,id,'.',s.ext);
    end
    
    rect_anno = dlmread([pathAnno s.name '.txt']);
    numSeg = 20;
    [subSeqs, subAnno]=splitSeqTRE(s,numSeg,rect_anno);
    
    nameAll=[];
    for idxTrk=1:numTrk
        
        t = trackers{idxTrk};
        %         load([rpAll s.name '_' t.name '.mat'], 'results','coverage','errCenter');
        
        load([rpAll s.name '_' t.name '.mat'])
        disp([s.name ' ' t.name]);
        
        aveCoverageAll=[];
        aveErrCenterAll=[];
        errCvgAccAvgAll = 0;
        errCntAccAvgAll = 0;
        errCoverageAll = 0;
        errCenterAll = 0;
        
        lenALL = 0;
        
        switch evalType
            case 'SRE'
                idxNum = length(results);
                anno=subAnno{1};
            case 'TRE'
                idxNum = length(results);
            case 'OPE'
                idxNum = 1;
                anno=subAnno{1};
        end
        
        successNumOverlap = zeros(idxNum,length(thresholdSetOverlap));
        successNumErr = zeros(idxNum,length(thresholdSetError));
        
        for idx = 1:idxNum
            
            res = results{idx};
            
            if strcmp(evalType, 'TRE')
                anno=subAnno{idx};
            end
            anno1=anno;
            anno1(:,1)=anno(:,1)+floor(anno(:,3)/2);
            anno1(:,2)=anno(:,2)+floor(anno(:,4)/2);
            results1=res.res;
            results1(:,1)=res.res(:,1)+floor(res.res(:,3)/2);
            results1(:,2)=res.res(:,2)+floor(res.res(:,4)/2);
            DER{idxTrk}= sqrt((anno1(:,1)-results1(:,1)).^2+ (anno1(:,2)-results1(:,2)).^2);
            
            len = size(anno,1);
            
            if isempty(res.res)
                break;
            end
            
            if ~isfield(res,'type')&&isfield(res,'transformType')
                res.type = res.transformType;
                res.res = res.res';
            end
            
            [aveCoverage, aveErrCenter, errCoverage, errCenter] = calcSeqErrRobust(res, anno);
            
            for tIdx=1:length(thresholdSetOverlap)
                successNumOverlap(idx,tIdx) = sum(errCoverage >thresholdSetOverlap(tIdx));
            end
            
            for tIdx=1:length(thresholdSetError)
                successNumErr(idx,tIdx) = sum(errCenter <= thresholdSetError(tIdx));
            end
            
            lenALL = lenALL + len;
            
        end
        

        
        if strcmp(evalType, 'OPE')
            aveSuccessRatePlot(idxTrk, idxSeq,:) = successNumOverlap/(lenALL+eps);
            aveSuccessRatePlotErr(idxTrk, idxSeq,:) = successNumErr/(lenALL+eps);
        else
            aveSuccessRatePlot(idxTrk, idxSeq,:) = sum(successNumOverlap)/(lenALL+eps);
            aveSuccessRatePlotErr(idxTrk, idxSeq,:) = sum(successNumErr)/(lenALL+eps);
        end
        
    end
%     figure;
%   
%             f=1:size(res.res,1);
%             plot(f,DER{1}(f),'LineWidth',3);
%             hold on;
%                         plot(f,DER{2}(f),'color',[1,0,0],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{3}(f),'color',[0,1,0],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{4}(f),'color',[0,0,1],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{5}(f),'color',[1,1,0],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{6}(f),'color',[0,0,0],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{7}(f),'color',[1,0,1],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{8}(f),'color',[0,1,1],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{9}(f),'color',[0.5,0.5,0.5],'lineStyle','-','LineWidth',3);
%             hold on;
%                         plot(f,DER{10}(f),'color',[136,0,21]/255,'lineStyle','-','LineWidth',3);
%             hold on;
%             fontSize = 16;
%             fontSizeLegend = 20;
%             hl=legend('LCCF','LCCF SCT','MDNet SCT','MDnet','CSK','CT','DFT','IVT','SCT','KCF','Interpreter', 'none','fontsize',fontSizeLegend,'Location','NorthWest');
%             set(hl,'Box','off');
%             set(gca,'FontSize',20);
%             
%             xlabel('Frame','fontsize',fontSize);
%             ylabel('DER','fontsize',fontSize);
%                         plot(f,DER{11}(f),'color',[255,127,39]/255,'lineStyle','-','LineWidth',10);
%             hold on;
end
%
          

            
dataName1=[perfMatPath 'aveSuccessRatePlot_' num2str(numTrk) 'alg_overlap_' evalType '.mat'];
save(dataName1,'aveSuccessRatePlot','nameTrkAll');

dataName2=[perfMatPath 'aveSuccessRatePlot_' num2str(numTrk) 'alg_error_' evalType '.mat'];
aveSuccessRatePlot = aveSuccessRatePlotErr;
save(dataName2,'aveSuccessRatePlot','nameTrkAll');
