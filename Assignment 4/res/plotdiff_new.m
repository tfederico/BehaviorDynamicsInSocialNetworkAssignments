function f = plotdiff_new
figure;
colorvec_char = ["Black" "Grey" "FireBrick" "Tomato" "HotPink" "Purple" "MidnightBlue" "DeepSkyBlue" "LightSeaGreen" "DarkGreen" "Chocolate" "GoldenRod"];
handle = [];
for j=1:12

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

    S=load('empiricalDataV2.mat');

    %Data = S.Data(j); % EmpIrical Data

    etha = [0.31492677561863397	0.08408224317987505	0.042085952906108115	0.41632998833890383	0.14471668052636566	0.056479558367138055	0.21281391988234924	0.3173042151251705	0.24260126051044367	0.04998411423048086	0.21259157688260885	0.1325779167459441];

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



    S1=load('empiricalDataV2.mat');
    color = rgb(colorvec_char(j));

    Data = S1.Data2; % Empirical Data

    plot(Data(:,j),'o','Color',color);

    hold on;

    handle(j) = plot(results(:,j),'LineWidth',3,'Color',color);
    

    hold on;

end

leg = [];
for i = 1:1:length(initialization)
    if i<10
        leg = [leg;['X ',num2str(i)]] ;
    else
        leg = [leg;['X',num2str(i)]] ;
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
end
    

