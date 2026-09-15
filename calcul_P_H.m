function P_H = calcul_P_H()

clearvars -except P_H
clc

cfg = config();

if ~exist(cfg.outputData,'file')
    error( ...
        'Dataset introuvable : %s', ...
        cfg.outputData);
end

S = load(cfg.outputData,'data');

data = S.data;

YTest = data.YTest;

fprintf('\n');

fprintf('Dimensions du jeu de test :\n');

fprintf('YTest : %s\n', ...
    mat2str(size(YTest)));

Ntest = size(YTest,4);

P_H = 0;

for i = 1:Ntest

    Hi = YTest(:,:,:,i);

    P_H = P_H + ...
        sum(abs(Hi(:)).^2);

end

P_H = P_H / Ntest;

fprintf('\n');

fprintf('Nombre de tests = %d\n', ...
    Ntest);

fprintf('P_H = %.10f\n', ...
    P_H);

end
