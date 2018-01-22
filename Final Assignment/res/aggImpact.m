function [agg] = aggImpact(input , parameters)
% calculating the agg-impact of a state based on the sum of impact of Effective states and the aggrigation function 
% inputs:
    % input: sum of impact of Effective states
    % parameters: this matrix shows the type of addridation function and
    % also its parameters if any)

agg = - 100 ;
if (parameters (1) >0 )
    agg = input * parameters (1);

end

if (parameters (2) > 0 )
    agg = input * parameters (2);
end

if (parameters (3) >0 )
    % To Check
    agg = input * parameters (3) / parameters(4);
end

if (parameters (5) >0 )
    agg = parameters (5) * 1/ (1 + exp(-parameters (6) * (input - parameters(7))));
end

if (parameters (8) > 0 )
    agg = parameters (8) * 1/ (1 + exp(-parameters (9) * (input - parameters(10)))) - 1/(1+exp( parameters(9)*parameters(10)));
end

disp(agg)
if (agg == -100)
    error('Error Number 1958 : A problem in aggImpact') ; 
end

if sum( parameters([1,2,3,5,8])) >1
    error ('Error Number 2567 : just one combination function is enough') ;
end

if sum( parameters([1,2,3,5,8])) <1
    error ('Error Number 2568 : one combination function is necessary') ;
end

agg = max(0,agg) ;
