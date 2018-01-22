function f = plotdiff_new
figure;
colorvec_char = ["Black" "Grey" "FireBrick" "Tomato" "HotPink" "Purple" "MidnightBlue" "DeepSkyBlue" "LightSeaGreen" "DarkGreen" "Chocolate" "GoldenRod"];
handle = [];

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
for j=1:18

    initialization = [0.2	0	0	0	0.2	0	0.2	0	0	0	0	0	0	0	0	0	0	0]; % Should Be filled 
    relations =  [0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0.2	0	0.2	0	0	0	0	0.5	0	0	1	0	0	1	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.2	0	0	-0.2;
    0	0	0	0	0	0.2	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	-0.2	0	0	-0.2;
    0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0.5	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0.5	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0.2	0	0.2	0	0	0	0.5	0	0	0	1	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0;
    0	0	0	0.2	0	0.2	0	0	0	0.5	0	0	0	0	0	0	1	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0]; % Should be filled
    parameters = [1	1	1	0	1	0	1	1	1	0	0	1	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0;
    0	0	0	1	0	1	0	0	0	1	1	0	1	1	1	1	1	1;
    0	0	0	1	0	1	0	0	0	4	4	0	5	5	5	5	5	5;
    0	0	0	0.2	0	0.2	0	0	0	0.2	0.2	0	0.4	0.4	0.4	0.4	0.4	0.4];% Should be filled
    deltaT = 0.5;% Should be filled
    maxT= 30;% Should be filled
    

    %S=load('empiricalDataV2.mat');

    %Data = S.Data(j); % EmpIrical Data

    etha = [0	0.9849520456468426	0.9569323801755683	0.9360693435413082 0	0.9719917981623664 0	0.939826009009747	0.25981349991067826	0.925094636767112	0.9348569711104521	0.9219391473942454	0.925170479584359	0.9397671897793298	0.9391029060569026	0.9222574573184985	0.907234048786504	0.9401440943495923];
    maxNumber = floor(maxT/deltaT) ; % Number of steps

    S = length(initialization) ; % Number of states

    results = zeros(maxNumber,S) ;

    results(1,:) = initialization ; 

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
        end

    end



    S1=load('empiricalDataV1.mat');
    
    counter = counter + 1;
    if(counter == length(co))
        counter = 1;
    end
    
    color = co(counter,:);%rgb(colorvec_char(j));

    Data = S1.Data; % Empirical Data

    plot(Data(:,j),'o','Color',color);

    hold on;

    handle(j) = plot(results(1:2:end,j),'LineWidth',3,'Color',color);
    

    hold on;

end

leg = [];
for i = 1:1:length(initialization)
    if i<10
        leg = [leg;labs(i)] ;
    else
        leg = [leg;labs(i)] ;
end
Leg = legend(handle, leg);
set(Leg,'FontSize',14)
ylim( [min(min(results)) , max(max(results))] + 0.1 * [ min(min(results))- max(max(results)) , -min(min(results)) + max(max(results))]);
temp = get(gca,'XTick');
set(gca,'XTickLabel',num2cell(temp * 2*deltaT) , 'fontsize',14); 
set(gca,'XTick',temp);
xlabel('Time' , 'fontsize',14);
ylabel('States Value' ,'fontsize',14 ) ;
end
    

