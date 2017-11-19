function [error] = calculateSSR2(P)

initialization =[1 1 0.9 0.8 0.7 0.6 0.5 0.4 0.3 0.2 0.1 0] ; % Should Be filled 

relations =[0 0.6 0.8 1 0.5 0 0 0 0 0 0 0;
            0.7 0 0 0 0.4 0.8 0 0 0 0 0 0;
            0.5 0 0 0 1 0 0.9 0 0 0 0 0;
            0.6 0 0 0 0 0 0.4 0.8 0.7 0 0 0;
            0.3 0.5 0.4 0 0 0.3 0.1 0 0 0.7 0.3 0;
            0 0.6 0 0 0.3 0 0 0 0 0.7 0 0.2;
            0 0 1 0.2 0.3 0 0 0.1 0 0 0.2 0;
            0 0 0 0.5 0 0 0.4 0 0.8 0 0.5 0;
            0 0 0 0.9 0 0 0 1 0 0 0 0;
            0 0 0 0 0.4 0.7 0 0 0 0 0.9 0.7;
            0 0 0 0 0.3 0 0.2 0.3 0 0.1 0 0.2;
            0 0 0 0 0 0.9 0 0 0 0.8 0.9 0]  ; % Should be filled
        
parameters =[0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0;
1	1	1	1	1	1	1	1	1	1	1	1;
2.1	1.7	2.2	2.6	3.2	2.7	2	2.2	1.5	2.3	2.8	1.1;
0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0;
0	0	0	0	0	0	0	0	0	0	0	0] ;% Should be filled

delta_t =1 ;% Should be filled

maxT=30;% Should be filled

S = load('empiricalDataV2.mat');

Data = S.Data2; % Empirical Data

%etha = [0.1 0.1 0.1 0.05 0.05 0.05 0.5 0.1 0.1 0.01 0.1 0.5];

etha = P; % Missing parameters are equal to the input of this function

newResutls = BDiSNModel1(initialization, relations, etha , parameters, delta_t, maxT );

%newResutls = newResutls(1:30,1:12); 

SSR = nansum (nansum ((newResutls - Data) .^2 )) ;

error = sqrt(SSR/12);

end
