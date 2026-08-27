function res = exp09_rl_policy(cfg, fixedResults)
%EXP09_RL_POLICY Entraîne et évalue une politique RL simplifiée.

agent = train_rl_gamma_policy(cfg, fixedResults);
save(fullfile(cfg.projectRoot, "results", "models", "rl_gamma_policy.mat"), "agent");
res = evaluate_rl_policy(agent, cfg, fixedResults);
end
