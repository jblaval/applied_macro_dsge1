%%% Main file to execute

% Simulation 

dynare model_simul


% Store simulations

[temp] = get_simul_replications(M_, options_);
position = [4 5 6 1 3 7 2]; % positions of (dy dc dinve labobs pinfobs dw robs)
simul=struct();
simul.dy=squeeze(temp(position(1),:,:));
simul.dc=squeeze(temp(position(2),:,:));
simul.dinve=squeeze(temp(position(3),:,:));
simul.labobs=squeeze(temp(position(4),:,:));
simul.pinfobs=squeeze(temp(position(5),:,:));
simul.dw=squeeze(temp(position(6),:,:));
simul.robs=squeeze(temp(position(7),:,:));

save('simul.mat', 'simul');

dynare model_estim

