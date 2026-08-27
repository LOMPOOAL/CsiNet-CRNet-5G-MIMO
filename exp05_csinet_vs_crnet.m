function res = exp05_csinet_vs_crnet(cfg)
%EXP05_CSINET_VS_CRNET Comparaison CsiNet/CRNet pour les trois gamma.

n = cfg.nTrain + cfg.nVal + cfg.nTest;

if cfg.generateCDL
    data = generate_cdl_csi_dataset(cfg, n, cfg.profiles, cfg.snrGridDB, cfg.velocitiesKmh);
else
    data = generate_synthetic_rayleigh_dataset(cfg, n, 0.5);
end

splits = split_dataset(data, 0.70, 0.15, cfg.seed);
save(fullfile(cfg.projectRoot, "data", "splits", "latest_splits.mat"), "splits", "-v7.3");

res = train_all_compression_ratios(splits, cfg);

try
    plot_nmse_vs_snr(res.table, fullfile(cfg.projectRoot, "results", "figures", "nmse_fixed_rates.png"));
catch ME
    warning("Figure NMSE non générée : %s", ME.message);
end
end
