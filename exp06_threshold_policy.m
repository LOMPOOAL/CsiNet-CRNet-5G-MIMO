function res = exp06_threshold_policy(cfg, fixedResults)
%EXP06_THRESHOLD_POLICY Évalue la politique adaptative à seuils.

res = evaluate_adaptive_policy(cfg, fixedResults);

try
    plot_policy_distribution(res.distribution, fullfile(cfg.projectRoot, "results", "figures", "policy_distribution.png"));
    plot_overhead_reduction(res, fullfile(cfg.projectRoot, "results", "figures", "overhead_reduction.png"));
catch ME
    warning("Figures politique non générées : %s", ME.message);
end
end
