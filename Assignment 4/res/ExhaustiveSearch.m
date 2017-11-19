function bestEtha = ExhaustiveSearch(init, relations, etha , parameters, deltaT, maxT )
 
% Inputs :
    % initialization : initial values of
    % relations : how states are connected to each other
    % etha : speed factors
    % parameters : combination functions and their parameters
    % delta t
    % maxT : this simulation starts from t=1 to t=maxT
ethaL = 0:0.05:0.5;

resTime2L = zeros(1,length(ethaL));
resTime2K = zeros(1,length(ethaL));
resTime13L = zeros(1,length(ethaL));
resTime13K = zeros(1,length(ethaL));

for i=1:length(ethaL)
    etha(12) = ethaL(i);
    results = BDiSNModel1(init, relations, etha, parameters, deltaT, maxT);
    resTime2L(i) = results(2,12);
    resTime13L(i) = results(13,12);
    resTime2K(i) = results(2,11);
    resTime13K(i) = results(13,11);
end

differences = (abs((resTime13K - resTime13L)) + abs((resTime2K - resTime2L)));

index = find(differences == min(differences));

bestEtha = ethaL(index);
    