function cfg = config_rl(cfg)
%CONFIG_RL Paramètres RL optionnels.

cfg.enableRL = false;
cfg.rlLambdaOverhead = 0.35;
cfg.rlMaxEpisodes = 100;
cfg.rlMaxStepsPerEpisode = 100;
cfg.rlDiscountFactor = 0.95;
end
