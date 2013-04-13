%% Programm zur Analyse von Counter-Movement-Jumps
function jumpHeight = jheight3(trialName)
%% Initiale Einstellungen
testPlot = 1;
trialRate = 1000;
% trialName = 'sub_no_19_trial_2.csv';
trialDataRaw = csvread(trialName,5,4); % 5: erste Zeile mit relevanten Daten
trialDataRaw(:,2:end) = [];
trialTime = 0:length(trialDataRaw)-1; % in ms

%% Glätten
trialDataRaw = smooth(trialDataRaw,10);
%% Abschnitte bestimmen

% Körpergewicht bestimmen

bodyWeight = mean(trialDataRaw(50:500));

% Erster Abschnitt - Ausholbewegung

startImpulsTemp = find(trialDataRaw<bodyWeight-bodyWeight/6); % Punkt überschießen
startAreaReverse = trialDataRaw(startImpulsTemp(1):-1:1); % Vom temporären Punkt bis Anfang
startImpulsReverse = find(startAreaReverse>=bodyWeight); % Erstes Überschreiten von Gewicht
startImpuls = startImpulsTemp(1)-startImpulsReverse(1)+1; % Korrektur des Index
secondArea = trialDataRaw(startImpulsTemp(1)+1:end); % Vom übergeschossenem Punkt bis Ende
secondImpulsTemp = find(secondArea>=bodyWeight); % Finde erstes Körpergewicht
secondImpuls = startImpulsTemp(1)+secondImpulsTemp(1); % Korrektur des Index

% Zweiter Abschnitt - Bremskraftstoß

thirdArea = trialDataRaw(secondImpuls+10:end); % Überschreiten des Punktes bis Ende
thirdImpulsTemp = find(thirdArea<=bodyWeight); % kleiner gleich Körpergewicht
thirdImpuls = secondImpuls+10-1+thirdImpulsTemp(1); % Korrektur des Index
fourthImpulsTemp = find(trialDataRaw==0); % Null finden
fourthImpuls = fourthImpulsTemp(1); % Index speichern

%% Berechnungen

areaStart = trialDataRaw(startImpuls:secondImpuls)-bodyWeight;
areaMain  = trialDataRaw(secondImpuls:thirdImpuls)-bodyWeight;
areaEnd   = trialDataRaw(fourthImpuls:-1:thirdImpuls)-bodyWeight;

trapzStart  = trapz(areaStart);
trapzMain   = trapz(areaMain);
trapzEnd    = trapz(areaEnd);
trapzFinal  = (trapzStart + trapzMain + trapzEnd)/trialRate;
jumpHeight  = ((trapzFinal/(bodyWeight/9.81))^2)/(2*9.81);

%% Testplot
if testPlot == 1
%   figure
  hold on
  plot(trialTime,trialDataRaw)
%   plot(trialTime,trialDataSmooth,'-r')
  plot([trialTime(1) trialTime(end)],[bodyWeight bodyWeight],'-k')
  plot(trialTime(startImpulsTemp(1)),trialDataRaw(startImpulsTemp(1)),'xr')
  plot(trialTime(startImpuls),trialDataRaw(startImpuls),'xg')
  plot(trialTime(secondImpuls),trialDataRaw(secondImpuls),'xg')
  plot(trialTime(thirdImpuls),trialDataRaw(thirdImpuls),'xg')
  plot(trialTime(fourthImpuls),trialDataRaw(fourthImpuls),'xg')
end
% reverseTime = 0:length(startAreaReverse)-1;
% figure
% hold on
% plot(reverseTime, startAreaReverse)
% plot(reverseTime(startImpulsReverse(1)),startAreaReverse(startImpulsReverse(1)),'xr')

end