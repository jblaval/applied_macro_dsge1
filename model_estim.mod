// Estimate the parameters of the model using the previous data (first without modifying the model to see how it works)
// Optimal value of the scale parameter = 0.34798 (jscale)

// estimation(datafile = 'simul.mat', mode_compute=6, mh_jscale=0.34798);
// estimation(datafile = 'simul.mat', mode_compute=6);

// copyfile('model_simul\graphs', 'graphs & outputs\base')
// copyfile('model_simul\Output', 'graphs & outputs\base')






/*
// Perform sensitivity analysis on beta
beta_range = [0.25 0.5 0.65 0.7 0.7420 0.75 0.8 0.85 0.99];
// jscale_range = [0.4111 0.32926 0.30197 0.32862 0.30332 0.57917 0.32797 0.58971 0.34148]
// Optimal values for jscales [0.4111 (beta = 0.25); 0.32926 (beta = 0.5); 0.30197 (beta = 0.65); 0.32862 (beta = 0.70); 0.30332 (beta = 0.742); 
// 0.57917 (beta = 0.75); 0.32797 (beta = 0.80); 0.58971 (beta = 0.85) ; 0.34148 (beta = 0.99)]
results = struct();
for i=1:length(beta_range)
    constebeta = beta_range(i)

    estimated_params;
        // PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
        // PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
        stderr ea,0.4618,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr eb,0.1818513,0.025,5,INV_GAMMA_PDF,0.1,2;
        stderr eg,0.6090,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr eqs,0.46017,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr em,0.2397,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr epinf,0.1455,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr ew,0.2089,0.01,3,INV_GAMMA_PDF,0.1,2;
        crhoa,.9676 ,.01,.9999,BETA_PDF,0.5,0.20;
        crhob,.2703,.01,.9999,BETA_PDF,0.5,0.20;
        crhog,.9930,.01,.9999,BETA_PDF,0.5,0.20;
        crhoqs,.5724,.01,.9999,BETA_PDF,0.5,0.20;
        crhoms,.3,.01,.9999,BETA_PDF,0.5,0.20;
        crhopinf,.8692,.01,.9999,BETA_PDF,0.5,0.20;
        crhow,.9546,.001,.9999,BETA_PDF,0.5,0.20;
        cmap,.7652,0.01,.9999,BETA_PDF,0.5,0.2;
        cmaw,.8936,0.01,.9999,BETA_PDF,0.5,0.2;
        csadjcost,6.3325,2,15,NORMAL_PDF,4,1.5;
        csigma,1.2312,0.25,3,NORMAL_PDF,1.50,0.375;
        chabb,0.7205,0.001,0.99,BETA_PDF,0.7,0.1;
        cprobw,0.7937,0.3,0.95,BETA_PDF,0.5,0.1;
        csigl,2.8401,0.25,10,NORMAL_PDF,2,0.75;
        cprobp,0.7813,0.5,0.95,BETA_PDF,0.5,0.10;
        cindw,0.4425,0.01,0.99,BETA_PDF,0.5,0.15;
        cindp,0.3291,0.01,0.99,BETA_PDF,0.5,0.15;
        czcap,0.2648,0.01,1,BETA_PDF,0.5,0.15;
        cfc,1.4672,1.0,3,NORMAL_PDF,1.25,0.125;
        crpi,1.7985,1.0,3,NORMAL_PDF,1.5,0.25;
        crr,0.8258,0.5,0.975,BETA_PDF,0.75,0.10;
        cry,0.0893,0.001,0.5,NORMAL_PDF,0.125,0.05;
        crdy,0.2239,0.001,0.5,NORMAL_PDF,0.125,0.05;
        constepinf,0.7,0.1,2.0,GAMMA_PDF,0.625,0.1;//20;
        
        // WE DO NOT ESTIMATE BETA
        // constebeta,0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;//0.20;
        constelab,1.2918,-10.0,10.0,NORMAL_PDF,0.0,2.0;
        ctrend,0.3982,0.1,0.8,NORMAL_PDF,0.4,0.10;
        cgy,0.05,0.01,2.0,NORMAL_PDF,0.5,0.25;
        calfa,0.24,0.01,1.0,NORMAL_PDF,0.3,0.05;
    end;

    // Optimal values for jscales [0.4111 (beta = 0.25); 0.32926 (beta = 0.5); 0.30197 (beta = 0.65); 0.32862 (beta = 0.70); 
    // 0.57917 (beta = 0.75); 0.32797 (beta = 0.80); 0.58971 (beta = 0.85); 0.34953 (beta = 0.90); 0.42157 (beta = 0.95); 0.34148 (beta = 0.99)]
    // estimation(datafile = 'simul.mat', mode_compute=6, mh_jscale = jscale_range(i));
    estimation(datafile = 'simul.mat', mode_compute=6);

    path_graphs = 'graphs & outputs\beta\beta = ' + string(beta_range(i))

    copyfile('model_simul\graphs', path_graphs)
    copyfile('model_simul\Output', path_graphs)    

    //Table of results
    results(i).constebeta = constebeta;
    results(i).cgy = oo_.posterior_mean.parameters.cgy;
    results(i).constelab = oo_.posterior_mean.parameters.constelab;
    results(i).constepinf = oo_.posterior_mean.parameters.constepinf;
    results(i).cmaw = oo_.posterior_mean.parameters.cmaw;
    results(i).cmap = oo_.posterior_mean.parameters.cmap;
    results(i).calfa = oo_.posterior_mean.parameters.calfa;
    results(i).czcap = oo_.posterior_mean.parameters.czcap;
    results(i).csadjcost = oo_.posterior_mean.parameters.csadjcost;
    results(i).csigma = oo_.posterior_mean.parameters.csigma;
    results(i).chabb = oo_.posterior_mean.parameters.chabb;
    results(i).cfc = oo_.posterior_mean.parameters.cfc;
    results(i).cindw = oo_.posterior_mean.parameters.cindw;
    results(i).cprobw = oo_.posterior_mean.parameters.cprobw;
    results(i).cindp = oo_.posterior_mean.parameters.cindp;
    results(i).cprobp = oo_.posterior_mean.parameters.cprobp;
    results(i).csigl = oo_.posterior_mean.parameters.csigl;
    results(i).crpi = oo_.posterior_mean.parameters.crpi;
    results(i).crdy = oo_.posterior_mean.parameters.crdy;
    results(i).cry = oo_.posterior_mean.parameters.cry;
    results(i).crr = oo_.posterior_mean.parameters.crr;
    results(i).crhoa = oo_.posterior_mean.parameters.crhoa;
    results(i).crhob = oo_.posterior_mean.parameters.crhob;
    results(i).crhog = oo_.posterior_mean.parameters.crhog;
    results(i).crhoqs = oo_.posterior_mean.parameters.crhoqs;
    results(i).crhoms = oo_.posterior_mean.parameters.crhoms;
    results(i).crhopinf = oo_.posterior_mean.parameters.crhopinf;
    results(i).crhow = oo_.posterior_mean.parameters.crhow;
    results(i).ctrend = oo_.posterior_mean.parameters.ctrend;
end;

// Display results
for i=1:length(results)
    disp(['Time preference rate in percent = ' num2str(results(i).constebeta)]);
    disp(['Feedback technology on exogenous spending = ' num2str(results(i).cgy)]);
    disp(['Steady state hours = ' num2str(results(i).constelab)]);
    disp(['Steady state inflation rate = ' num2str(results(i).constepinf)]);
    disp(['Coefficient on MA term wage markup = ' num2str(results(i).cmaw)]);
    disp(['Coefficient on MA term price markup = ' num2str(results(i).cmap)]);
    disp(['Capital share = ' num2str(results(i).calfa)]);
    disp(['Capacity utilization cost = ' num2str(results(i).czcap)]);
    disp(['Investment adjustment cost= ' num2str(results(i).csadjcost)]);
    disp(['Risk aversion = ' num2str(results(i).csigma)]);
    disp(['External habit degree = ' num2str(results(i).chabb)]);
    disp(['Fixed cost share= ' num2str(results(i).cfc)]);
    disp(['Indexation to past wages = ' num2str(results(i).cindw)]);
    disp(['Calvo parameter wages = ' num2str(results(i).cprobw)]);
    disp(['Indexation to past prices = ' num2str(results(i).cindp)]);
    disp(['Calvo parameter prices = ' num2str(results(i).cprobp)]);
    disp(['Frisch elasticity = ' num2str(results(i).csigl)]);
    disp(['Taylor rule inflation feedback = ' num2str(results(i).crpi)]);
    disp(['Taylor rule output growth feedback = ' num2str(results(i).crdy)]);
    disp(['Taylor rule output level feedback = ' num2str(results(i).cry)]);
    disp(['Interest rate persistence = ' num2str(results(i).crr)]);
    disp(['Persistence productivity shock = ' num2str(results(i).crhoa)]);
    disp(['Persistence risk premium shock = ' num2str(results(i).crhob)]);
    disp(['Persistence spending shock = ' num2str(results(i).crhog)]);
    disp(['Persistence risk premium shock = ' num2str(results(i).crhoqs)]);
    disp(['Persistence monetary policy shock = ' num2str(results(i).crhoms)]);
    disp(['Persistence price markup shock = ' num2str(results(i).crhopinf)]);
    disp(['Persistence wage markup shock = ' num2str(results(i).crhow)]);
    disp(['Net growth rate in percent = ' num2str(results(i).ctrend)]);
end;

// Beware, this will erase the previous 'result_beta' matrix (but can be found again in "workspace.mat")
//save('result_beta.mat', 'results')

load('result_beta.mat');
results = struct2cell(results);
latex(sym(results))
*/




/*
// Perform sensitivity analysis on cindw (Indexation to past wages)
cindw_range = [0.01 0.15 0.25 0.30 0.3243 0.35 0.40 0.5 0.65];
// Optimal values for jscales [0.29675 (cindw = 0.01); 0.34137 (cindw = 0.15); 33.5688 (cindw = 0.25); 44.2593 (cindw = 0.30);
// 0.32624 (cindw = 0.3243); 0.3405 (cindw = 0.35); 1.1891 (cindw = 0.40); 0.30023 (cindw = 0.65); 
// jscale_range = [0.29675 0.34137 33.5688 44.2593 0.32624 0.3405 1.1891 0.30023]

results = struct();
for i=1:length(cindw_range)
    cindw = cindw_range(i);

    estimated_params;
        // PARAM NAME, INITVAL, LB, UB, PRIOR_SHAPE, PRIOR_P1, PRIOR_P2, PRIOR_P3, PRIOR_P4, JSCALE
        // PRIOR_SHAPE: BETA_PDF, GAMMA_PDF, NORMAL_PDF, INV_GAMMA_PDF
        stderr ea,0.4618,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr eb,0.1818513,0.025,5,INV_GAMMA_PDF,0.1,2;
        stderr eg,0.6090,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr eqs,0.46017,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr em,0.2397,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr epinf,0.1455,0.01,3,INV_GAMMA_PDF,0.1,2;
        stderr ew,0.2089,0.01,3,INV_GAMMA_PDF,0.1,2;
        crhoa,.9676 ,.01,.9999,BETA_PDF,0.5,0.20;
        crhob,.2703,.01,.9999,BETA_PDF,0.5,0.20;
        crhog,.9930,.01,.9999,BETA_PDF,0.5,0.20;
        crhoqs,.5724,.01,.9999,BETA_PDF,0.5,0.20;
        crhoms,.3,.01,.9999,BETA_PDF,0.5,0.20;
        crhopinf,.8692,.01,.9999,BETA_PDF,0.5,0.20;
        crhow,.9546,.001,.9999,BETA_PDF,0.5,0.20;
        cmap,.7652,0.01,.9999,BETA_PDF,0.5,0.2;
        cmaw,.8936,0.01,.9999,BETA_PDF,0.5,0.2;
        csadjcost,6.3325,2,15,NORMAL_PDF,4,1.5;
        csigma,1.2312,0.25,3,NORMAL_PDF,1.50,0.375;
        chabb,0.7205,0.001,0.99,BETA_PDF,0.7,0.1;
        cprobw,0.7937,0.3,0.95,BETA_PDF,0.5,0.1;
        csigl,2.8401,0.25,10,NORMAL_PDF,2,0.75;
        cprobp,0.7813,0.5,0.95,BETA_PDF,0.5,0.10;

        // WE DO NOT ESTIMATE CINDW
        // cindw,0.4425,0.01,0.99,BETA_PDF,0.5,0.15;
        cindp,0.3291,0.01,0.99,BETA_PDF,0.5,0.15;
        czcap,0.2648,0.01,1,BETA_PDF,0.5,0.15;
        cfc,1.4672,1.0,3,NORMAL_PDF,1.25,0.125;
        crpi,1.7985,1.0,3,NORMAL_PDF,1.5,0.25;
        crr,0.8258,0.5,0.975,BETA_PDF,0.75,0.10;
        cry,0.0893,0.001,0.5,NORMAL_PDF,0.125,0.05;
        crdy,0.2239,0.001,0.5,NORMAL_PDF,0.125,0.05;
        constepinf,0.7,0.1,2.0,GAMMA_PDF,0.625,0.1;//20;
        constebeta,0.7420,0.01,2.0,GAMMA_PDF,0.25,0.1;//0.20;
        constelab,1.2918,-10.0,10.0,NORMAL_PDF,0.0,2.0;
        ctrend,0.3982,0.1,0.8,NORMAL_PDF,0.4,0.10;
        cgy,0.05,0.01,2.0,NORMAL_PDF,0.5,0.25;
        calfa,0.24,0.01,1.0,NORMAL_PDF,0.3,0.05;
    end;

    // estimation(datafile = 'simul.mat', mode_compute=6, mh_jscale = jscale_range(i));
    estimation(datafile = 'simul.mat', mode_compute=6);

    path_graphs = 'graphs & outputs\cindw\cindw = ' + string(cindw_range(i))

    copyfile('model_simul\graphs', path_graphs)
    copyfile('model_simul\Output', path_graphs)    

    //Table of results
    results(i).cindw = cindw;
    results(i).cgy = oo_.posterior_mean.parameters.cgy;
    results(i).constelab = oo_.posterior_mean.parameters.constelab;
    results(i).constepinf = oo_.posterior_mean.parameters.constepinf;
    results(i).constebeta = oo_.posterior_mean.parameters.constebeta;
    results(i).cmaw = oo_.posterior_mean.parameters.cmaw;
    results(i).cmap = oo_.posterior_mean.parameters.cmap;
    results(i).calfa = oo_.posterior_mean.parameters.calfa;
    results(i).czcap = oo_.posterior_mean.parameters.czcap;
    results(i).csadjcost = oo_.posterior_mean.parameters.csadjcost;
    results(i).csigma = oo_.posterior_mean.parameters.csigma;
    results(i).chabb = oo_.posterior_mean.parameters.chabb;
    results(i).cfc = oo_.posterior_mean.parameters.cfc;
    results(i).cprobw = oo_.posterior_mean.parameters.cprobw;
    results(i).cindp = oo_.posterior_mean.parameters.cindp;
    results(i).cprobp = oo_.posterior_mean.parameters.cprobp;
    results(i).csigl = oo_.posterior_mean.parameters.csigl;
    results(i).crpi = oo_.posterior_mean.parameters.crpi;
    results(i).crdy = oo_.posterior_mean.parameters.crdy;
    results(i).cry = oo_.posterior_mean.parameters.cry;
    results(i).crr = oo_.posterior_mean.parameters.crr;
    results(i).crhoa = oo_.posterior_mean.parameters.crhoa;
    results(i).crhob = oo_.posterior_mean.parameters.crhob;
    results(i).crhog = oo_.posterior_mean.parameters.crhog;
    results(i).crhoqs = oo_.posterior_mean.parameters.crhoqs;
    results(i).crhoms = oo_.posterior_mean.parameters.crhoms;
    results(i).crhopinf = oo_.posterior_mean.parameters.crhopinf;
    results(i).crhow = oo_.posterior_mean.parameters.crhow;
    results(i).ctrend = oo_.posterior_mean.parameters.ctrend;
end;

// Display results
for i=1:length(results)
    disp(['Indexation to past wages = ' num2str(results(i).cindw)]);
    disp(['Feedback technology on exogenous spending = ' num2str(results(i).cgy)]);
    disp(['Steady state hours = ' num2str(results(i).constelab)]);
    disp(['Steady state inflation rate = ' num2str(results(i).constepinf)]);
    disp(['Time preference rate in percent = ' num2str(results(i).constebeta)]);
    disp(['Coefficient on MA term wage markup = ' num2str(results(i).cmaw)]);
    disp(['Coefficient on MA term price markup = ' num2str(results(i).cmap)]);
    disp(['Capital share = ' num2str(results(i).calfa)]);
    disp(['Capacity utilization cost = ' num2str(results(i).czcap)]);
    disp(['Investment adjustment cost= ' num2str(results(i).csadjcost)]);
    disp(['Risk aversion = ' num2str(results(i).csigma)]);
    disp(['External habit degree = ' num2str(results(i).chabb)]);
    disp(['Fixed cost share= ' num2str(results(i).cfc)]);
    disp(['Calvo parameter wages = ' num2str(results(i).cprobw)]);
    disp(['Indexation to past prices = ' num2str(results(i).cindp)]);
    disp(['Calvo parameter prices = ' num2str(results(i).cprobp)]);
    disp(['Frisch elasticity = ' num2str(results(i).csigl)]);
    disp(['Taylor rule inflation feedback = ' num2str(results(i).crpi)]);
    disp(['Taylor rule output growth feedback = ' num2str(results(i).crdy)]);
    disp(['Taylor rule output level feedback = ' num2str(results(i).cry)]);
    disp(['Interest rate persistence = ' num2str(results(i).crr)]);
    disp(['Persistence productivity shock = ' num2str(results(i).crhoa)]);
    disp(['Persistence risk premium shock = ' num2str(results(i).crhob)]);
    disp(['Persistence spending shock = ' num2str(results(i).crhog)]);
    disp(['Persistence risk premium shock = ' num2str(results(i).crhoqs)]);
    disp(['Persistence monetary policy shock = ' num2str(results(i).crhoms)]);
    disp(['Persistence price markup shock = ' num2str(results(i).crhopinf)]);
    disp(['Persistence wage markup shock = ' num2str(results(i).crhow)]);
    disp(['Net growth rate in percent = ' num2str(results(i).ctrend)]);
end;

// Beware, this will erase the previous 'result_cindw' matrix (but can be found again in "workspace.mat")
//save('result_cindw.mat', 'results')

//load('result_cindw.mat');
//results = struct2cell(results);
//latex(sym(results))
*/