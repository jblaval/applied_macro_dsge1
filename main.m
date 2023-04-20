%%% Main file to execute

% Simulation 

dynare model_simul


% Store simulations

[simul] = get_simul_replications(M_, options_);
position = [4 5 6 1 3 7 2] // positions of (dy dc dinve labobs pinfobs dw robs)
simul = simul([4 5 6 1 3 7 2],:,:);
save('simul.mat', simul(position,:,:));

dynare model_estim

