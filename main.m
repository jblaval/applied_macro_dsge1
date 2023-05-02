%%% Main file to execute

% Simulation 

dynare model_simul


% Store simulations

[temp] = get_simul_replications(M_, options_);
position = [4 5 6 1 3 7 2]; % positions of (dy dc dinve labobs pinfobs dw robs) in the "var" block
simulations=struct();
simulations.dy=squeeze(temp(position(1),:,:));
simulations.dc=squeeze(temp(position(2),:,:));
simulations.dinve=squeeze(temp(position(3),:,:));
simulations.labobs=squeeze(temp(position(4),:,:));
simulations.pinfobs=squeeze(temp(position(5),:,:));
simulations.dw=squeeze(temp(position(6),:,:));
simulations.robs=squeeze(temp(position(7),:,:));

%in the 'simulations'object, there are in lines the periods, in columns the
%simulations
save('simulations.mat', 'simulations');
%save('simul.mat', 'dy', 'dc', 'dinve', 'labobs', 'pinfobs', 'dw', 'robs');

%% First estimation: debunk the first layer of uncertainty around the estimation, 
% the one that is due to the difference in the series due to the different simulations

% We first focus on the estimations of 9 parameters, to reduce time
% computation : calfa, chabb, cindw, constebeta, constepinf, crhoa, crhog, crr, ctrend

for i=1:200
    dy = simulations.dy(:, i);
    dc = simulations.dc(:, i);
    dinve = simulations.dinve(:, i);
    labobs = simulations.labobs(:, i);
    pinfobs = simulations.pinfobs(:, i);
    dw = simulations.dw(:, i);
    robs = simulations.robs(:, i);
    save('simul.mat', 'dy', 'dc', 'dinve', 'labobs', 'pinfobs', 'dw', 'robs');
  try
    dynare model_estim1
    save(strcat('results_simul' + string(i)' + '.mat'), 'results_simul');
  catch
    fprintf('Inconsistent data in iteration %i, skipped.\n', i);
  end
end

load('results_simul1.mat');
results = results_simul(1);
for i=2:40
  try
    load(strcat('results_simul' + string(i)' + '.mat'))
    results(i) = results_simul(i);
  catch
    fprintf('Inconsistent data in iteration %i, skipped.\n', i);
  end
end

% Delete all empty lines
results = results(all(~cellfun(@isempty,struct2cell(results))));

% Format for export
table_results = struct2table(results);

table_statdesc = varfun(@(x) [mean(x); std(x); min(x); max(x)],table_results); 
table_statdesc.Properties.RowNames = {'mean' 'std' 'min' 'max'};
table_statdesc.Properties.VariableNames = extractAfter(table_statdesc.Properties.VariableNames,'Fun_');

writetable(table_statdesc,'table_statdesc.xlsx');
tbl2latex('table_statdesc.xlsx')

table_meanResults = varfun(@mean, table_results, 'InputVariables', @isnumeric);

calfa_true = 0.24;
chabb_true = 0.6361;
cindw_true = 0.3243;
constebeta_true = 0.742;
constepinf_true = 0.7;
crhoa_true = 0.9977;
crhog_true = 0.9957;
crr_true = 0.8762;
ctrend_true = 0.3982;
table_trueValue = table(calfa_true, chabb_true, cindw_true, constebeta_true, ... 
                constepinf_true, crhoa_true, crhog_true, crr_true, ctrend_true);

relativeErrors = 1 - table_meanResults{1,:}./table_trueValue{1,:};

table_relativeErrors = array2table(relativeErrors, 'VariableNames', ...
    {'calfa_re', 'chabb_re', 'cindw_re', 'constebeta_re', 'constepinf_re', ... 
   'crhoa_re', 'crhog_re', 'crr_re', 'ctrend_re'});

latexTable = tbl2latex(table_relativeErrors);

writetable(table_relativeErrors,'table_relativeErrors.xlsx');
tbl2latex('table_relativeErrors.xlsx')


%% Second estimation: debunk the second layer of uncertainty around the estimation, 
% the one that is due to the calibration error

dynare model_estim2

load('result_beta.mat');
table_resultbeta = struct2table(results);
writetable(table_resultbeta,'table_resultbeta.xlsx');
tbl2latex('table_resultbeta.xlsx')


load('result_cindw.mat');
table_resultcindw = struct2table(results);
writetable(table_resultcindw,'table_resultcindw.xlsx');
tbl2latex('table_resultcindw.xlsx')

