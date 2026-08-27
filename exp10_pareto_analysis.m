function res = exp10_pareto_analysis(cfg, fixedResults, resPolicy)
%EXP10_PARETO_ANALYSIS Trace la frontière Pareto overhead/NMSE.

try
    plot_pareto_front(fixedResults.table, resPolicy, fullfile(cfg.projectRoot, "results", "figures", "pareto_overhead_nmse.png"));
catch ME
    warning("Pareto non généré : %s", ME.message);
end

res = struct();
res.fixedTable = fixedResults.table;
res.adaptive = resPolicy;
end
