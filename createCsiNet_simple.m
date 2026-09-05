function lgraph = createCsiNet_simple(inputSize, latentDim)
    % Crée un CsiNet simple SANS FunctionLayer
    
    layers = [
        imageInputLayer(inputSize, 'Name', 'input', 'Normalization', 'none')
        
        convolution2dLayer([3, 3], 8, 'Padding', 'same', 'Name', 'conv1')
        batchNormalizationLayer('Name', 'bn1')
        reluLayer('Name', 'relu1')
        
        convolution2dLayer([3, 3], 16, 'Padding', 'same', 'Name', 'conv2')
        batchNormalizationLayer('Name', 'bn2')
        reluLayer('Name', 'relu2')
        
        convolution2dLayer([3, 3], 32, 'Padding', 'same', 'Name', 'conv3')
        batchNormalizationLayer('Name', 'bn3')
        reluLayer('Name', 'relu3')
        
        flattenLayer('Name', 'flatten')
        fullyConnectedLayer(latentDim, 'Name', 'fc_latent')
        
        fullyConnectedLayer(64 * 32 * 2, 'Name', 'fc_decoder')
        reluLayer('Name', 'relu_decoder')
        
        % Utiliser une couche fully connected pour le reshape
        fullyConnectedLayer(64 * 32 * 2, 'Name', 'fc_final')
        
        regressionLayer('Name', 'output')
    ];

    lgraph = layerGraph(layers);
end