function res = exp02_synthetic_baseline(cfg)
%EXP02_SYNTHETIC_BASELINE Baseline Rayleigh corrélé.

n = cfg.nTrain + cfg.nVal + cfg.nTest;
data = generate_synthetic_rayleigh_dataset(cfg, n, 0.5);
splits = split_dataset(data, 0.70, 0.15, cfg.seed);

outputFile = fullfile(cfg.projectRoot, "data", "processed", "synthetic_baseline_splits.mat");
save(outputFile, "splits", "-v7.3");

res = struct();
res.dataFile = outputFile;
res.nSamples = n;
res.labels = data.labels;
end
