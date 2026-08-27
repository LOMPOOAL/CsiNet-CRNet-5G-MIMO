function cfg = config_training(cfg)
%CONFIG_TRAINING Hyperparamètres d'entraînement.

cfg.initialLearnRate = 1e-3;
cfg.learnRateDropFactor = 0.5;
cfg.learnRatePatience = 5;
cfg.earlyStoppingPatience = 10;
cfg.l2Regularization = 1e-5;
cfg.validationFrequency = 20;
cfg.lossFunction = "mse";
cfg.shuffle = "every-epoch";
end
