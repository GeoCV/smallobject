%%%º∆À„ ±º‰
clear
close all;
clc

addpath('D:\tracker_benchmark_v1.0/util');

attPath = 'D:\tracker_benchmark_v1.0\anno\att\'; % The folder that contains the annotation files for sequence attributes
seqs=configSeqs;

trackers=configTrackers;
numSeq=length(seqs);
numTrk=length(trackers);

nameTrkAll=cell(numTrk,1);
for idxTrk=1:numTrk
    t = trackers{idxTrk};
    nameTrkAll{idxTrk}=t.namePaper;
end

nameSeqAll=cell(numSeq,1);
numAllSeq=zeros(numSeq,1);

att=[];
for idxSeq=1:numSeq
    s = seqs{idxSeq};
    nameSeqAll{idxSeq}=s.name;
    
    s.len = s.endFrame - s.startFrame + 1;
    
    numAllSeq(idxSeq) = s.len;
    
    att(idxSeq,:)=load([attPath s.name '.txt']);
end

attNum = size(att,2);

figPath = 'D:\tracker_benchmark_v1.0\figs\overall\';

perfMatPath = 'D:\tracker_benchmark_v1.0\perfMat\overall\';

if ~exist(figPath,'dir')
    mkdir(figPath);
end

metricTypeSet = {'error', 'overlap'};
evalTypeSet = {'OPE'};%'SRE', 'TRE', 

rankingType = 'threshold';%AUC, threshod

rankNum = 10;%number of plots to show


thresholdSetOverlap = 0:0.05:1;
thresholdSetError = 0:50;

for i=1:length(metricTypeSet)
    metricType = metricTypeSet{i};%error,overlap
    
    switch metricType
        case 'overlap'
            thresholdSet = thresholdSetOverlap;
            rankIdx = 11;
            xLabelName = 'Overlap threshold';
            yLabelName = 'Success rate';
        case 'error'
            thresholdSet = thresholdSetError;
            rankIdx = 21;
            xLabelName = 'Location error threshold';
            yLabelName = 'Precision';
    end  
        
    if strcmp(metricType,'error')&strcmp(rankingType,'AUC')
        continue;
    end
    
    tNum = length(thresholdSet);
    pathAnno = 'D:\tracker_benchmark_v1.0/anno/';
    for j=1:length(evalTypeSet)
        
        evalType = evalTypeSet{j};%SRE, TRE, OPE
        
        plotType = [metricType '_' evalType];
        
        switch metricType
            case 'overlap'
                titleName = ['Success plots of ' evalType];
            case 'error'
                titleName = ['Precision plots of ' evalType];
        end

        dataName = [perfMatPath 'aveSuccessRatePlot_' num2str(numTrk) 'alg_'  plotType '.mat'];
        
        % If the performance Mat file, dataName, does not exist, it will call
        % genPerfMat to generate the file.
       % if ~exist(dataName)
        rpAll=['.\results\results_OPE_CVPR13\'];
        T(1)=0;
        T(2)=0;
         T(3)=0;
          T(4)=0;
for idxSeq=1:88
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
        T(idxTrk)=results{1,1}.fps+T(idxTrk);
        
        
    end
end
    end
end
       % end        
        T
       
   
