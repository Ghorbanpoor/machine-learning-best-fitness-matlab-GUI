function [gmdh]=main(X,Y)

% global gmdh X Y

%% Load Data

data.Inputs=X';
data.Targets=Y';

Inputs = data.Inputs;
Targets = data.Targets;

nData = size(Inputs,2);
Perm = randperm(nData);

% Train Data
pTrain = 0.85;
nTrainData = round(pTrain*nData);
TrainInd = Perm(1:nTrainData);
TrainInputs = Inputs(:,TrainInd);
TrainTargets = Targets(:,TrainInd);

% Test Data
pTest = 1 - pTrain;
nTestData = nData - nTrainData;
TestInd = Perm(nTrainData+1:end);
TestInputs = Inputs(:,TestInd);
TestTargets = Targets(:,TestInd);

%% Create and Train GMDH Network

params.MaxLayerNeurons = 15;   % Maximum Number of Neurons in a Layer
params.MaxLayers = 4;          % Maximum Number of Layers
params.alpha = 0.6;            % Selection Pressure (in Layers)
params.pTrain = 0.85;          % Train Ratio (vs. Validation Ratio)
gmdh = GMDH(params, TrainInputs, TrainTargets);

%% Evaluate GMDH Network

Outputs = ApplyGMDH(gmdh, Inputs);
TrainOutputs = Outputs(:,TrainInd);
TestOutputs = Outputs(:,TestInd);

end

%% Show Results

% disp('Type "gmdh.Layers" to see the layers'' info.');
% disp(' ');
% 
% figure;
% PlotResults(TrainTargets, TrainOutputs, 'Train Data');
% 
% figure;
% PlotResults(TestTargets, TestOutputs, 'Test Data');
% 
% figure;
% PlotResults(Targets, Outputs, 'All Data');
% 
% if ~isempty(which('plotregression'))
%     figure;
%     plotregression(TrainTargets, TrainOutputs, 'Train Data', ...
%                    TestTargets, TestOutputs, 'TestData', ...
%                    Targets, Outputs, 'All Data');
% end
