function res = exp01_smoke_test(cfg)
%EXP01_SMOKE_TEST Validation rapide de la chaîne complète.

n = max(60, cfg.miniBatchSize*3);
data = generate_synthetic_rayleigh_dataset(cfg, n, 0.5);
splits = split_dataset(data, 0.70, 0.15, cfg.seed);

gamma = 1/16;
k = latent_dim_from_gamma(gamma);
lgraph = build_csinet(cfg.inputSize, k);

tr = train_autoencoder_model(lgraph, splits.XTrain, splits.XVal, "smoke_CsiNet_gamma_1_16", cfg);
ev = evaluate_model_nmse_cosine(tr.net, splits.XTest, cfg);

res = struct();
res.nmseDB = ev.nmseDB;
res.cosine = ev.cosine;
res.trainingTimeSec = tr.trainingTimeSec;

T = table(gamma, k, compute_overhead_bits(gamma, cfg.quantizationBits), ev.nmseDB, ev.cosine, ...
    'VariableNames', {'Gamma','LatentDim','OverheadBits','NMSEdB','CosineSimilarity'});
save_results_table(T, fullfile(cfg.projectRoot, "results", "tables", "smoke_test_results.xlsx"));
end
