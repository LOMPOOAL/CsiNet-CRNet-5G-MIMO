function res = exp04_cdl_a_nlos(cfg)
%EXP04_CDL_A_NLOS Scénario CDL-A NLOS.

n = cfg.nTrain + cfg.nVal + cfg.nTest;
data = generate_cdl_csi_dataset(cfg, n, "CDL-A", cfg.snrGridDB, cfg.velocitiesKmh);
splits = split_dataset(data, 0.70, 0.15, cfg.seed);
res = train_all_compression_ratios(splits, cfg);
end
