function f = plotdiff2
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
deltaT =1 ;% Should be filled
maxT=30;% Should be filled
S=load('empiricalDataV2.mat');
Data = S.Data2; % EmpIrical Data
etha = [0.257 0.105 0.062 0.078 0.323 0.089 0.370 0.229 0.113 0.032 0.139 0.312];
maxNumber = floor(maxT/deltaT) ; % Number of steps

S = length (initialization) ; % Number of states
results = zeros(maxNumber,S) ;
results (1,:) = initialization ; 

for t = 2 : 1 : maxNumber
    for i = 1:1:S
         agg_imp = aggImpact( results(t-1 , :) * relations(:,i) , parameters(:,i) ) ; % calculating the agg-impact of the current state
        results (t , i) =  results (t-1 , i) + etha(i) * (agg_imp - results (t-1 , i)) * deltaT  ;
    end
end
close;
figure ;
hold all;
leg = [];
color1=[251 111 66] ./ 255;
color3=[255/255 153/255 255/255];
color2=[0/255 204/255 55/255];
color4=[102/255 0/255 51/255];
color5=[0, 0, 102] ./ 255;
colorvec=['y','m','c','r','g','b','k'];

for i = 1:1:7
    
    plot(results(:,i),colorvec(i),'LineWidth',3) ;
        leg = [leg;['X ',num2str(i)]] ;
end
    plot(results(:,8),'Color',color1,'LineWidth',3) ;
    leg = [leg;['X ',num2str(8)]] ;
    plot(results(:,9),'Color',color2,'LineWidth',3) ;
    leg = [leg;['X ',num2str(9)]] ;
    plot(results(:,10),'Color',color3,'LineWidth',3) ;
    leg = [leg;['X',num2str(10)]] ;
    plot(results(:,11),'Color',color4,'LineWidth',3) ;
    leg = [leg;['X',num2str(11)]] ;
    plot(results(:,12),'Color',color5,'LineWidth',3) ;
    leg = [leg;['X',num2str(12)]] ;
    

for i = 1:1:7
    
    plot(Data(:,i),'o','MarkerEdgeColor',colorvec(i)) ;
        
end
    plot(Data(:,8),'o','MarkerEdgeColor',color1) ;
    plot(Data(:,9),'o','MarkerEdgeColor',color2) ;
    plot(Data(:,10),'o','MarkerEdgeColor',color3) ;
    plot(Data(:,11),'o','MarkerEdgeColor',color4) ;
    plot(Data(:,12),'o','MarkerEdgeColor',color5) ;
    
    
Leg = legend(leg);
set(Leg,'FontSize',14)
ylim( [min(min(results)) , max(max(results))] + 0.1 * [ min(min(results))- max(max(results)) , -min(min(results)) + max(max(results))]);
temp = get(gca,'XTick');
set(gca,'XTickLabel',num2cell(temp * deltaT) , 'fontsize',14); 
set(gca,'XTick',temp);
xlabel('Time' , 'fontsize',14);
ylabel('States Value' ,'fontsize',14 ) ;


end

