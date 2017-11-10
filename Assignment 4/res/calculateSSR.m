function SSR = calculateSSR(P)

initialization = ; % Should Be filled 
relations =  ; % Should be filled
parameters = ;% Should be filled
delta_t = ;% Should be filled
maxT=;% Should be filled
Data = ; % Emperical Data
etha = ;

etha(12) = P(1); % Missing parameters are equal to the input of this function



newResutls = BDiSNModel1(initialization, relations, etha , parameters, delta_t, maxT ) ;

SSR = nansum (nansum ((newResutls - Data) .^2 )) ;

%%%%%%%%%%%