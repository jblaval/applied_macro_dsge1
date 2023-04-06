% Simulate with the "correct" parameters => simulated data are stored in simult.mat, while parameters are stored 
% in  model_simul/Output/model_simul_mode.mat

constebeta_mean = 0.7420;
dynare model_simul


% Test : change beta 
constebeta_mean = 0.5;
dynare model_simul
