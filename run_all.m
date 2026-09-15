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

fprintf('Dataset : %s\n', ...
    cfg.outputData);

fprintf( ...
    'Train / Validation / Test : %d / %d / %d\n', ...
    cfg.Ntrain, ...
    cfg.Nval, ...
    cfg.Ntest);

switch mode

    case "check"

        if ~exist(cfg.outputData,'file')

            error( ...
                'Dataset absent : %s', ...
                cfg.outputData);

        end

        S = load( ...
            cfg.outputData, ...
            'data');

        data = S.data;

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

        P_H = calcul_P_H();

        fprintf('\nP_H = %.10f\n',P_H);


    case "generate"

        generate_dataset_3gpp(cfg);


    case "train"

        if ~exist(cfg.outputData,'file')

            error( ...
                'Dataset absent. Execute run_all("generate") d abord.');

        end

        S = load( ...
            cfg.outputData, ...
            'data');

        data = S.data;

        for i = 1:numel(cfg.gammaValues)

            gamma = cfg.gammaValues(i);

            k = cfg.latentDimensions(i);

            fprintf('\n');
            fprintf( ...
                '===== CsiNet gamma %.4f =====\n', ...
                gamma);

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

            train_csinetwork( ...
                gamma, ...
                k, ...
                true, ...
                data, ...
                cfg, ...
                1);

        end


    case "quantization"

        run_quantization_demo();


    case "all"

        run_all("check");

        run_all("train");

        run_all("quantization");


    otherwise

        error( ...
            ['Mode inconnu. Utiliser : ', ...
             'check, generate, train, quantization ou all.']);

end

end
