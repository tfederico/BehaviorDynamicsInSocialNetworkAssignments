function f = plotdiff
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

deltaT =1 ;% Should be filled

maxT=30;% Should be filled

S=load('empiricalDataV1.mat');

Data = S.Data(12); % EmpIrical Data

etha = [0.1 0.1 0.1 0.05 0.05 0.05 0.5 0.1 0.1 0.01 0.1 0.05];

maxNumber = floor(maxT/deltaT) ; % Number of steps

S = length(initialization) ; % Number of states

results = zeros(maxNumber,S) ;

results(1,:) = initialization ; 

for t = 2 : 1 : maxNumber
    
    for i = 1:1:S
        
        agg_imp = aggImpact( results(t-1 , :) * relations(:,i) , parameters(:,i) ) ; % calculating the agg-impact of the current state
        
        results (t , i) =  results (t-1 , i) + etha(i) * (agg_imp - results (t-1 , i)) * deltaT  ;
    end
    
end

figure;

S1=load('empiricalDataV1.mat');

Data = S1.Data; % Empirical Data

plot(Data(:,12),'o');

hold on;

plot(results(:,12),'LineWidth',3);

hold on;


end

