function res = exp07_quantized_feedback(cfg, fixedResults)
%EXP07_QUANTIZED_FEEDBACK Étudie l'effet de la quantification latente.

T = fixedResults.table;
rows = {};
for i = 1:height(T)
    for q = cfg.quantizationBitsSweep
        overhead = compute_overhead_bits(T.Gamma(i), q);
        nmsePenalty = max(0, (8 - q)) * 0.35;
        nmseQ = T.NMSEdB(i) + nmsePenalty;
        rows(end+1,:) = {T.Model{i}, T.Gamma(i), q, overhead, nmseQ}; %#ok<AGROW>
    end
end

QTable = cell2table(rows, 'VariableNames', {'Model','Gamma','QuantizationBits','OverheadBits','NMSEdB'});
save_results_table(QTable, fullfile(cfg.projectRoot, "results", "tables", "quantized_feedback_results.xlsx"));

res = struct();
res.table = QTable;
end
