function cfg = config_master(mode)
%CONFIG_MASTER Configuration centrale du projet.

arguments
    mode (1,1) string {mustBeMember(mode, ["quick","standard","full"])} = "quick"
end

cfg = struct();
cfg.mode = mode;
cfg.seed = 42;
cfg.useGPU = true;
cfg.enableParallel = true;
cfg.enable5GToolboxPreferred = true;

cfg.Nt = 32;
cfg.Nr = 1;
cfg.NcRaw = 1024;
cfg.Na = 32;
cfg.inputSize = [32 32 2];

cfg.compressionRatios = [1/4 1/8 1/16];
cfg.quantizationBits = 8;
cfg.quantizationBitsSweep = [4 6 8 10];

cfg.snrGridDB = 0:5:30;
cfg.profiles = ["CDL-A","CDL-D"];
cfg.profileLabels = ["NLOS","LOS"];
cfg.velocitiesKmh = [3 30 120 350];

switch mode
    case "quick"
        cfg.nTrain = 200;
        cfg.nVal = 50;
        cfg.nTest = 50;
        cfg.nPolicyScenarios = 1000;
        cfg.maxEpochs = 2;
        cfg.miniBatchSize = 32;
        cfg.generateCDL = false;
    case "standard"
        cfg.nTrain = 8000;
        cfg.nVal = 1500;
        cfg.nTest = 1500;
        cfg.nPolicyScenarios = 10000;
        cfg.maxEpochs = 40;
        cfg.miniBatchSize = 64;
        cfg.generateCDL = true;
    case "full"
        cfg.nTrain = 70000;
        cfg.nVal = 15000;
        cfg.nTest = 15000;
        cfg.nPolicyScenarios = 50000;
        cfg.maxEpochs = 200;
        cfg.miniBatchSize = 128;
        cfg.generateCDL = true;
end
end
