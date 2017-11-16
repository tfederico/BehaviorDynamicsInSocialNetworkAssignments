function [SSR,error] = calculateSSR(P)

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
0	0	0	0	0	0	0	0	0	0	0	0
] ;% Should be filled
delta_t =1 ;% Should be filled
maxT=30;% Should be filled
S=load('empiricalDataV1.mat');
Data = S.Data; % Empirical Data
etha = [0.1 0.1 0.1 0.05 0.05 0.05 0.5 0.1 0.1 0.01 0.1 0.5];
for i=1:length(P)
    etha(12) = P(i); % Missing parameters are equal to the input of this function

    newResutls = BDiSNModel1(initialization, relations, etha , parameters, delta_t, maxT ) ;
    %newResutls = newResutls(1:30,1:12); 
    SSR(i) = nansum (nansum ((newResutls - Data) .^2 )) ;
    error(i)=sqrt(SSR(i))/12;
end
end
