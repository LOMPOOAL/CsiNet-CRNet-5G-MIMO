function [net,info,result] = train_csinetwork( ...
    gamma,k,isCRNet,data,cfg,runIndex)

if nargin < 6
    runIndex = 1;
end

requiredData = { ...
    'XTrain', ...
    'YTrain', ...
    'XVal', ...
    'YVal', ...
    'XTest', ...
    'YTest'};

for i = 1:numel(requiredData)

    if ~isfield(data,requiredData{i})

        error( ...
            'Champ data.%s manquant.', ...
            requiredData{i});

    end

end

requiredCfg = { ...
    'epochs', ...
    'miniBatchSize', ...
    'initialLearnRate', ...
    'seed'};

for i = 1:numel(requiredCfg)

    if ~isfield(cfg,requiredCfg{i})

        error( ...
            'Champ cfg.%s manquant.', ...
            requiredCfg{i});

    end

end

runSeed = cfg.seed + runIndex - 1;

rng(runSeed,'twister');

lgraph = build_network( ...
    gamma, ...
    k, ...
    isCRNet, ...
    cfg);

net = dlnetwork(lgraph);

XTrain = single(data.XTrain);
YTrain = single(data.YTrain);

XVal = single(data.XVal);
YVal = single(data.YVal);

nTrain = size(XTrain,4);

nVal = size(XVal,4);

bestNet = net;

bestValLoss = inf;

bestEpoch = 0;

patience = 5;

minDelta = 1e-6;

epochsWithoutImprovement = 0;

averageGrad = [];

averageSqGrad = [];

iteration = 0;

info.TrainingLoss = ...
    zeros(cfg.epochs,1);

info.ValidationLoss = ...
    zeros(cfg.epochs,1);

info.BestEpoch = 0;

info.RunSeed = runSeed;

tic

for epoch = 1:cfg.epochs

    order = randperm(nTrain);

    trainLossSum = 0;

    trainCount = 0;

    for first = 1:cfg.miniBatchSize:nTrain

        last = min( ...
            first + cfg.miniBatchSize - 1, ...
            nTrain);

        idx = order(first:last);

        dlX = dlarray( ...
            XTrain(:,:,:,idx), ...
            'SSCB');

        dlY = dlarray( ...
            YTrain(:,:,:,idx), ...
            'SSCB');

        [loss,gradients] = ...
            dlfeval( ...
            @modelLoss, ...
            net, ...
            dlX, ...
            dlY);

        iteration = iteration + 1;

        [net,averageGrad,averageSqGrad] = ...
            adamupdate( ...
            net, ...
            gradients, ...
            averageGrad, ...
            averageSqGrad, ...
            iteration, ...
            cfg.initialLearnRate);

        lossValue = double( ...
            gather(extractdata(loss)));

        nBatch = numel(idx);

        trainLossSum = ...
            trainLossSum + ...
            lossValue*nBatch;

        trainCount = ...
            trainCount + nBatch;

    end

    trainLoss = ...
        trainLossSum/trainCount;

    valLoss = ...
        computeValidationLoss( ...
        net, ...
        XVal, ...
        YVal, ...
        cfg.miniBatchSize);

    info.TrainingLoss(epoch) = ...
        trainLoss;

    info.ValidationLoss(epoch) = ...
        valLoss;

    fprintf( ...
        'Epoch %d/%d | Train %.8g | Val %.8g\n', ...
        epoch, ...
        cfg.epochs, ...
        trainLoss, ...
        valLoss);

    if valLoss < bestValLoss - minDelta

        bestValLoss = valLoss;

        bestNet = net;

        bestEpoch = epoch;

        epochsWithoutImprovement = 0;

    else

        epochsWithoutImprovement = ...
            epochsWithoutImprovement + 1;

    end

    if epochsWithoutImprovement >= patience

        fprintf( ...
            'Arret anticipe a l epoch %d.\n', ...
            epoch);

        break

    end

end

trainingTime = toc;

net = bestNet;

lastEpoch = max(bestEpoch,1);

info.TrainingLoss = ...
    info.TrainingLoss(1:lastEpoch);

info.ValidationLoss = ...
    info.ValidationLoss(1:lastEpoch);

info.BestEpoch = bestEpoch;

info.TrainingTimeSeconds = ...
    trainingTime;

result = evaluate_model( ...
    net, ...
    data.XTest, ...
    data.YTest, ...
    cfg);

if isCRNet

    architectureName = 'CRNet';

else

    architectureName = 'CsiNet';

end

result.Architecture = ...
    string(architectureName);

result.Gamma = gamma;

result.LatentDimension = k;

result.BestEpoch = bestEpoch;

result.TrainingTimeSeconds = ...
    trainingTime;

if isfield(cfg,'modelDir')

    modelFile = fullfile( ...
        cfg.modelDir, ...
        sprintf( ...
        '%s_gamma_%0.2f_k_%d.mat', ...
        architectureName, ...
        gamma, ...
        k));

    save( ...
        modelFile, ...
        'net', ...
        'info', ...
        'result', ...
        'cfg', ...
        'gamma', ...
        'k', ...
        '-v7.3');

end

end


function valLoss = computeValidationLoss( ...
    net,XVal,YVal,batchSize)

nVal = size(XVal,4);

sumLoss = 0;

count = 0;

for first = 1:batchSize:nVal

    last = min( ...
        first + batchSize - 1, ...
        nVal);

    dlX = dlarray( ...
        XVal(:,:,:,first:last), ...
        'SSCB');

    dlY = dlarray( ...
        YVal(:,:,:,first:last), ...
        'SSCB');

    dlYPred = predict(net,dlX);

    err = dlYPred - dlY;

    loss = mean(err.^2,'all');

    batchLoss = double( ...
        gather(extractdata(loss)));

    nBatch = last-first+1;

    sumLoss = ...
        sumLoss + batchLoss*nBatch;

    count = count + nBatch;

end

valLoss = sumLoss/count;

end
