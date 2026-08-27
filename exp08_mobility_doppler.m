function res = exp08_mobility_doppler(cfg)
%EXP08_MOBILITY_DOPPLER Génère des datasets par vitesse UE.

rows = {};
for v = cfg.velocitiesKmh
    data = generate_cdl_csi_dataset(cfg, min(200, cfg.nTest), cfg.profiles, cfg.snrGridDB, v);
    [snrEst, profEst] = estimate_snr_and_profile(data.HComplex(:,:,1));
    rows(end+1,:) = {v, snrEst, char(profEst), size(data.X,4)}; %#ok<AGROW>
end

T = cell2table(rows, 'VariableNames', {'VelocityKmh','EstimatedSNRdB','EstimatedProfile','NumSamples'});
save_results_table(T, fullfile(cfg.projectRoot, "results", "tables", "mobility_doppler_summary.xlsx"));
res = struct("table", T);
end
