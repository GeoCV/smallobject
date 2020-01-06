function trackers=configTrackers

trackers_small90={ struct('name','OAB','namePaper','OAB'),...
   struct('name','OCT','namePaper','OCT'),...
   struct('name','fDSST','namePaper','fDSST'),...
   struct('name','CT','namePaper','CT'),...
   struct('name','CSK','namePaper','CSK'),...
   struct('name','IVT','namePaper','IVT'),...
   struct('name','ORIA','namePaper','ORIA'),...
   struct('name','KCF','namePaper','KCF'),...
   struct('name','KCF_AST','namePaper','KCF_AST'),...
   struct('name','DFT','namePaper','DFT')....
   struct('name','SPC','namePaper','SPC'),...
   struct('name','MTT','namePaper','MTT'),...
   struct('name','L1APG','namePaper','L1APG'),...
   struct('name','LOT','namePaper','LOT'),...
   struct('name','Frag','namePaper','Frag'),...
   struct('name','SBT','namePaper','SemiT'),...
   struct('name','BSBT','namePaper','BSBT'),...
   struct('name','LCCF','namePaper','LCCF'),....
   struct('name','LCCF_AST','namePaper','LCCF_AST').... 
   struct('name','KMS','namePaper','KMS'),...
   struct('name','SMS','namePaper','SMS'),...
   struct('name','CPF','namePaper','CPF'),...
   struct('name','SCT4','namePaper','SCT4'),...
   struct('name','MDNet_AST','namePaper','MDNet_AST'),....
   struct('name','MDNet','namePaper','MDNet'),....      
   struct('name','ECO_HC','namePaper','ECO'),...
   struct('name','ECO_HC_AST','namePaper','ECO_AST'),...
   struct('name','LCT','namePaper','LCT'),...
   struct('name','TLD','namePaper','TLD'),...
   struct('name','LDES','namePaper','LDES'),...
   struct('name','LDES_AST','namePaper','LDES_AST'),...
   struct('name','DaSiamRPN','namePaper','DaSiamRPN'),...
   struct('name','DaSiamRPN_AST','namePaper','DaSiamRPN_AST'),...
   struct('name','SAT_AST','namePaper','SAT_AST'),...
   struct('name','SAT','namePaper','SAT'),...
};    


 trackers_uav20l={struct('name','DaSiamRPN','namePaper','DaSiamRPN'),...
   struct('name','DaSiamRPN_AST','namePaper','DaSiamRPN_AST'),...
   struct('name','SRDCF_AST','namePaper','SRDCF_AST'),...
   struct('name','LCCF_AST','namePaper','LCCF_AST'),...
   struct('name','SRDCF','namePaper','SRDCF'),...
   struct('name','KCF_AST','namePaper','KCF_AST'),...
   struct('name','MEEM','namePaper','MEEM'),...
   struct('name','DSST','namePaper','DSST'),...
   struct('name','SAMF','namePaper','SAMF'),...
   struct('name','Struck','namePaper','Struck'),...
   struct('name','LCCF','namePaper','LCCF'),...
   struct('name','ASLA','namePaper','ASLA'),...
   struct('name','TLD','namePaper','TLD'),...
   struct('name','LCT','namePaper','LCT'),...
   struct('name','IVT','namePaper','IVT'),...
   struct('name','CSK','namePaper','CSK'),...
   struct('name','SAT','namePaper','SAT'),...
   struct('name','LDES_AST','namePaper','LDES_AST'),...
   struct('name','LDES','namePaper','LDES'),...
   struct('name','OCT','namePaper','OCT'),...
   struct('name','KCF_LinearHog','namePaper','KCF'),...
}

trackers_10fps={  struct('name','SRDCF_AST','namePaper','SRDCF_AST'),...
    struct('name','ECO_HC_AST','namePaper','ECO_HC_AST'),...
    struct('name','KCF_AST','namePaper','KCF_AST'),...
    struct('name','DaSiamRPN_AST','namePaper','DaSiamRPN_AST'),...
    struct('name','LDES','namePaper','LDES'),...
    struct('name','DaSiamRPN','namePaper','DaSiamRPN'),...
    struct('name','LDES_AST','namePaper','LDES_AST'),...
    struct('name','SAT_AST','namePaper','SAT_AST'),...
    struct('name','ECO_HC','namePaper','ECO_HC'),...
    struct('name','MDNet_AST','namePaper','MDNet_AST'),...
    struct('name','KCF_GaussHog','namePaper','KCF'),...
    struct('name','MDNet','namePaper','MDNet'),...
    struct('name','SRDCF','namePaper','SRDCF'),...
    struct('name','SAT','namePaper','SAT'),...
    struct('name','DSST','namePaper','DSST'),...
    struct('name','TLD','namePaper','TLD'),...
    struct('name','MUSTER','namePaper','MUSTER'),...
    struct('name','SAMF','namePaper','SAMF'),...
    struct('name','Struck','namePaper','Struck'),...
    struct('name','OCT','namePaper','OCT'),...
    struct('name','LCT','namePaper','LCT'),...
}; 

trackers_small112={struct('name','ECO_HC_AST','namePaper','ECO_AST'),...
   struct('name','LCCF_AST','namePaper','LCCF_AST'),...
   struct('name','ECO_HC','namePaper','ECO'),...
   struct('name','KCF_AST','namePaper','KCF_AST'),...
   struct('name','KCF','namePaper','KCF'),...
   struct('name','LCCF','namePaper','LCCF'),...
   struct('name','SCT','namePaper','SCT'),...
   struct('name','IVT','namePaper','IVT'),...
   struct('name','CSK','namePaper','CSK'),...
   struct('name','SAT_AST','namePaper','SAT_AST'),...
   struct('name','SAT','namePaper','SAT'),...
   struct('name','LCT','namePaper','LCT'),...
   struct('name','TLD','namePaper','TLD'),...
   struct('name','LDES','namePaper','LDES'),...
   struct('name','LDES_AST','namePaper','LDES_AST'),...
   struct('name','OCT','namePaper','OCT'),...
   struct('name','DaSiamRPN','namePaper','DaSiamRPN'),...
   struct('name','DaSiamRPN_AST','namePaper','DaSiamRPN_AST'),...
}
        
%trackers = trackers_10fps;   
%trackers = trackers_uav20l;
%trackers =  trackers_small90;
%trackers =  trackers_small112;
trackers =  {struct('name','KCF_AST','namePaper','KCF_AST'),...
   }
