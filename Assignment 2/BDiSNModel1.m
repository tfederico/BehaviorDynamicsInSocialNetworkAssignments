restfunction [results] = BDiSNModel1(initialization, relations, etha , parameters, deltaT, maxT )
 
% Inputs :
    % initialization : initial values of
    % relations : how states are connected to each other
    % etha : speed factors
    % parameters : combination functions and their parameters
    % delta t
    % maxT : this simulation starts from t=1 to t=maxT

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

%
% If you do not waht to create a figure as the result, you can make the rest of this code as comments: (using %{ at the begining of the next line 
close;
figure ;
hold all;
leg = [];
for i = 1:1:S
    plot(results(:,i),'LineWidth',3) ;
    if i<10
        leg = [leg;['X ',num2str(i)]] ;
    else
        leg = [leg;['X',num2str(i)]] ;
    end
end
Leg = legend(leg);
set(Leg,'FontSize',14)
ylim( [min(min(results)) , max(max(results))] + 0.1 * [ min(min(results))- max(max(results)) , -min(min(results)) + max(max(results))]);
temp = get(gca,'XTick');
set(gca,'XTickLabel',num2cell(temp * deltaT) , 'fontsize',14); 
set(gca,'XTick',temp);
xlabel('Time' , 'fontsize',14);
ylabel('States Value' ,'fontsize',14 ) ;

%}