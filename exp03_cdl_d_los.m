function res = exp03_cdl_d_los(cfg)
%EXP03_CDL_D_LOS Scénario CDL-D LOS.

n = cfg.nTrain + cfg.nVal + cfg.nTest;
data = generate_cdl_csi_dataset(cfg, n, "CDL-D", cfg.snrGridDB, cfg.velocitiesKmh);
splits = split_dataset(data, 0.70, 0.15, cfg.seed);
res = train_all_compression_ratios(splits, cfg);
end
