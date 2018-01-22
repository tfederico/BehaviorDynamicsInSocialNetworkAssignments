function [results] = BDiSNModel1Tuning(initialization, relations, etha , parameters, deltaT, maxT )
 
% Inputs :
    % initialization : initial values of
    % relations : how states are connected to each other
    % etha : speed factors
    % parameters : combination functions and their parameters
    % delta t
    % maxT : this simulation starts from t=1 to t=maxT

maxNumber = floor(maxT/deltaT) ; % Number of steps

% co = [  1 1 0;
%         1 0 1;
%         0    0.4470    0.7410;
%         0.8500    0.3250    0.0980;
%         0.9290    0.6940    0.1250;
%         0 1 1;
%         0.3010    0.7450    0.9330;
%         0.6350    0.0780    0.1840;
%         0 0 0;
%         0.4940    0.1840    0.5560;
%         0.4660    0.6740    0.1880;
%         0 1 0;
%         0 0 1];
 


labs = ["ws_s","ss_s","srs_s","cs_{sens,s}","srs_{self}","cs_{self}","ws_B","ss_B","srs_B","ps_B","cs_{B,s}","esc_B","srs_{anx}","ps_{anx}","es_{anx}","srs_{agg}","ps_{agg}","es_{agg}"];

co = [rgb('HotPink'); rgb('MediumSeaGreen'); rgb('ForestGreen'); rgb('Black');
      rgb('DarkCyan'); 
       rgb('Salmon');  
      rgb('DarkKhaki'); rgb('GreenYellow'); rgb('MediumAquamarine');
      rgb('OliveDrab'); rgb('DarkOliveGreen'); rgb('Chocolate'); 
      rgb('Maroon'); rgb('Navy');
      rgb('FireBrick'); rgb('Orange'); rgb('DarkOrchid');
      rgb('Indigo'); rgb('Goldenrod')];

counter = 0;
S = length (initialization) ; % Number of states
results = zeros(maxNumber,S) ;
results (1,:) = initialization ; 

for t = 2 : 1 : maxNumber
    for i = 1:1:S
        agg_imp = aggImpact( results(t-1 , :) * relations(:,i) , parameters(:,i) ) ; % calculating the agg-impact of the current state
        results (t , i) =  results (t-1 , i) + etha(i) * (agg_imp - results (t-1 , i)) * deltaT  ;
        if(t > (maxNumber/3) && t < (2/3)*(maxNumber))
               results(t, 1) = 0;
               %results(t, 5) = 0;
               results(t, 7) = 0;
        end
        if(t >= (2/3)*(maxNumber) && t < (maxNumber))
            results(t, 1) = 0.2;
            %results(t, 5) = 0.2;
            results(t, 7) = 0.2;
        end
%         if(t >= (maxNumber/2) && t < (2/3)*maxNumber)
%             results(t, 1) = 0;
%             %results(t, 5) = 0;
%             results(t, 7) = 0;
%         end
%         if(t >= (2/3)*maxNumber && t < (5/6)*maxNumber)
%             results(t, 1) = 0.2;
%             %results(t, 5) = 0.2;
%             results(t, 7) = 0.2;
%         end
%         if(t >= (5/6)*maxNumber && t < maxNumber)
%             results(t, 1) = 0;
%             %results(t, 5) = 0;
%             results(t, 7) = 0;
%         end
    end
end

%
% If you do not waht to create a figure as the result, you can make the rest of this code as comments: (using %{ at the begining of the next line 

close;
figure ;
hold all;
leg = [];
handle = [];
for i = 1:1:S
    counter = counter + 1;
    if(counter == length(co))
        counter = 1;
    end
    
    color = co(counter,:);
    
    handle(i) = plot(results(:,i),'LineWidth',3,'Color',color) ;
    if i<10
        leg = [leg;labs(i)] ;
    else
        leg = [leg;labs(i)] ;
    end
end
Leg = legend(handle, leg);
set(Leg,'FontSize',14)
ylim( [min(min(results)) , max(max(results))] + 0.1 * [ min(min(results))- max(max(results)) , -min(min(results)) + max(max(results))]);
temp = get(gca,'XTick');
set(gca,'XTickLabel',num2cell(temp * deltaT) , 'fontsize',14); 
set(gca,'XTick',temp);
xlabel('Time' , 'fontsize',14);
ylabel('States Value' ,'fontsize',14 ) ;

%}