function cfg = config_channels(cfg)
%CONFIG_CHANNELS Paramètres radio et canaux 5G.

cfg.carrierFrequency = 3.5e9;
cfg.bandwidthHz = 100e6;
cfg.subcarrierSpacing = 30e3;
cfg.sampleRate = 122.88e6;
cfg.delaySpreadCDLA = 100e-9;
cfg.delaySpreadCDLD = 30e-9;
cfg.arraySizeTx = [4 8 1 1 1];
cfg.arraySizeRx = [1 1 1 1 1];
cfg.spatialCorrelationLOS = 0.95;
cfg.spatialCorrelationNLOS = 0.70;
end
