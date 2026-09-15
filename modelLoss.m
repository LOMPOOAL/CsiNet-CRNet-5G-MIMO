function [loss, gradients] = modelLoss(net, dlX, dlY)
% MODELLOSS
% Calcule la MSE et les gradients du reseau.

dlYPred = forward(net, dlX);

err = dlYPred - dlY;

loss = mean(err.^2, 'all');

gradients = dlgradient(loss, net.Learnables);

end
