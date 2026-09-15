function run_all(mode)

if nargin < 1
    mode = "check";
end

mode = lower(string(mode));

cfg = config();

fprintf('\n');
fprintf('============================================\n');
fprintf(' CSI Reproductibilite MATLAB R2024a\n');
fprintf('============================================\n');

fprintf('Dataset : %s\n', cfg.outputData);

fprintf( ...
    'Train / Validation / Test : %d / %d / %d\n', ...
    cfg.Ntrain, ...
    cfg.Nval, ...
    cfg.Ntest);

switch mode

    case "check"

        fprintf('\n');
        fprintf('============================================\n');
        fprintf(' VERIFICATION DU PIPELINE\n');
        fprintf('============================================\n');

        if ~exist(cfg.outputData, 'file')

            error( ...
                'Dataset absent : %s', ...
                cfg.outputData);

        end

        S = load( ...
            cfg.outputData, ...
            'data');

        if ~isfield(S, 'data')

            error( ...
                'La variable "data" est absente du dataset.');

        end

        data = S.data;

        requiredFields = { ...
            'XTrain', ...
            'XVal', ...
            'XTest', ...
            'YTrain', ...
            'YVal', ...
            'YTest'};

        for i = 1:numel(requiredFields)

            if ~isfield(data, requiredFields{i})

                error( ...
                    'Champ data.%s absent.', ...
                    requiredFields{i});

            end

        end

        fprintf('\nDimensions :\n');

        fprintf('XTrain : %s\n', ...
            mat2str(size(data.XTrain)));

        fprintf('XVal   : %s\n', ...
            mat2str(size(data.XVal)));

        fprintf('XTest  : %s\n', ...
            mat2str(size(data.XTest)));

        fprintf('YTrain : %s\n', ...
            mat2str(size(data.YTrain)));

        fprintf('YVal   : %s\n', ...
            mat2str(size(data.YVal)));

        fprintf('YTest  : %s\n', ...
            mat2str(size(data.YTest)));

        assert( ...
            isequal(size(data.XTrain), [64 32 2 100000]), ...
            'Dimension XTrain incorrect.');

        assert( ...
            isequal(size(data.XVal), [64 32 2 20000]), ...
            'Dimension XVal incorrect.');

        assert( ...
            isequal(size(data.XTest), [64 32 2 20000]), ...
            'Dimension XTest incorrect.');

        assert( ...
            isequal(size(data.YTrain), [64 32 2 100000]), ...
            'Dimension YTrain incorrect.');

        assert( ...
            isequal(size(data.YVal), [64 32 2 20000]), ...
            'Dimension YVal incorrect.');

        assert( ...
            isequal(size(data.YTest), [64 32 2 20000]), ...
            'Dimension YTest incorrect.');

        fprintf('\nVerification des dimensions : OK\n');

        P_H = calcul_P_H();

        fprintf('\n');
        fprintf('P_H = %.10f\n', P_H);

        fprintf('\n');
        fprintf('============================================\n');
        fprintf(' VERIFICATION TERMINEE AVEC SUCCES\n');
        fprintf('============================================\n');


    case "generate"

        fprintf('\n');
        fprintf('============================================\n');
        fprintf(' GENERATION DU DATASET 3GPP\n');
        fprintf('============================================\n');

        data = generate_dataset_3gpp(cfg);

        save( ...
            cfg.outputData, ...
            'data', ...
            '-v7.3');

        fprintf('\nDataset sauvegarde : %s\n', ...
            cfg.outputData);


    case "train"

        fprintf('\n');
        fprintf('============================================\n');
        fprintf(' ENTRAINEMENT DES MODELES\n');
        fprintf('============================================\n');

        if ~exist(cfg.outputData, 'file')

            error( ...
                ['Dataset absent. Executez ', ...
                 'run_all("generate") d abord.']);

        end

        S = load( ...
            cfg.outputData, ...
            'data');

        if ~isfield(S, 'data')

            error( ...
                'La variable "data" est absente du dataset.');

        end

        data = S.data;

        for i = 1:numel(cfg.gammaValues)

            gamma = cfg.gammaValues(i);

            k = cfg.latentDimensions(i);

            fprintf('\n');
            fprintf( ...
                '===== CsiNet gamma %.4f =====\n', ...
                gamma);

            [netCsiNet, infoCsiNet, resultCsiNet] = ...
                train_csinetwork( ...
                    gamma, ...
                    k, ...
                    false, ...
                    data, ...
                    cfg, ...
                    1);

            fprintf('\n');
            fprintf( ...
                '===== CRNet gamma %.4f =====\n', ...
                gamma);

            [netCRNet, infoCRNet, resultCRNet] = ...
                train_csinetwork( ...
                    gamma, ...
                    k, ...
                    true, ...
                    data, ...
                    cfg, ...
                    1);

            modelDir = fileparts(cfg.outputData);

            modelDir = fullfile( ...
                fileparts(modelDir), ...
                '03_models');

            if ~exist(modelDir, 'dir')
                mkdir(modelDir);
            end

            save( ...
                fullfile( ...
                    modelDir, ...
                    sprintf('CsiNet_gamma_%g.mat', gamma)), ...
                'netCsiNet', ...
                'infoCsiNet', ...
                'resultCsiNet', ...
                '-v7.3');

            save( ...
                fullfile( ...
                    modelDir, ...
                    sprintf('CRNet_gamma_%g.mat', gamma)), ...
                'netCRNet', ...
                'infoCRNet', ...
                'resultCRNet', ...
                '-v7.3');

            fprintf('\nModeles sauvegardes pour gamma %.4f\n', ...
                gamma);

        end

        fprintf('\n');
        fprintf('Entrainement termine.\n');


    case "quantization"

        fprintf('\n');
        fprintf('============================================\n');
        fprintf(' QUANTIFICATION DU CODE LATENT\n');
        fprintf('============================================\n');

        run_quantization_demo();


    case "all"

        fprintf('\n');
        fprintf('============================================\n');
        fprintf(' PIPELINE COMPLET\n');
        fprintf('============================================\n');

        run_all("check");

        run_all("train");

        run_all("quantization");


    otherwise

        error( ...
            ['Mode inconnu. Utiliser : ', ...
             'check, generate, train, quantization ou all.']);

end

end
