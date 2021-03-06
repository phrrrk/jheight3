function [jumpHeight, bodyWeight] = jheight3(trialName, weightRange, startImpuls, secondImpuls, thirdImpuls, fourthImpuls, startImpulsTemp, doPlot)
  %JHEIGHT3 calculates the height (in m) of a counter-movement-jump based on force
  %data in the z-direction.
  % 
  %   [jumpHeight, bodyWeight] = jheight3(trialName, weightRange, startImpuls, ...
  %                                       secondImpuls, thirdImpuls, ...
  %                                       fourthImpuls, startImpulsTemp, doPlot)
  %
% This content is released under the MIT License.
%
% Copyright (C) 2013 Falko Döhring
% 
% Permission is hereby granted, free of charge, to any person obtaining a copy of
% this software and associated documentation files (the "Software"), to deal in the
% Software without restriction, including without limitation the rights to use,
% copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
% Software, and to permit persons to whom the Software is furnished to do so,
% subject to the following conditions:
% 
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
% 
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
% INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
% PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
% HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
% OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
% SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

%% Initiale Einstellungen
testPlot = doPlot;
trialRate = 1000;
% trialName = 'sub_no_19_trial_2.csv';
trialDataRaw = csvread(trialName,5,4); % 5: erste Zeile mit relevanten Daten
trialDataRaw(:,2:end) = [];
trialTime = 0:length(trialDataRaw)-1; % in ms

%% Glätten
trialDataRaw = smooth(trialDataRaw,10);
%% Abschnitte bestimmen

% Körpergewicht bestimmen

bodyWeight = mean(trialDataRaw(weightRange(1):weightRange(2)));

% Erster Abschnitt - Ausholbewegung
if startImpulsTemp == 0
  startImpulsTemp = find(trialDataRaw<bodyWeight-bodyWeight/6); % Punkt überschießen
end
  startAreaReverse = trialDataRaw(startImpulsTemp(1):-1:1); % Vom temporären Punkt bis Anfang
  startImpulsReverse = find(startAreaReverse>=bodyWeight); % Erstes Überschreiten von Gewicht
if startImpuls == 0
  startImpuls = startImpulsTemp(1)-startImpulsReverse(1)+1; % Korrektur des Index
end
  secondArea = trialDataRaw(startImpulsTemp(1)+1:end); % Vom übergeschossenem Punkt bis Ende
  secondImpulsTemp = find(secondArea>=bodyWeight); % Finde erstes Körpergewicht
if secondImpuls == 0
  secondImpuls = startImpulsTemp(1)+secondImpulsTemp(1); % Korrektur des Index
end

% Zweiter Abschnitt - Bremskraftstoß
  thirdArea = trialDataRaw(secondImpuls+10:end); % Überschreiten des Punktes bis Ende
  thirdImpulsTemp = find(thirdArea<=bodyWeight); % kleiner gleich Körpergewicht
if thirdImpuls == 0
  thirdImpuls = secondImpuls+10-1+thirdImpulsTemp(1); % Korrektur des Index
end
  fourthImpulsTemp = find(trialDataRaw==0); % Null finden
if fourthImpuls == 0
  fourthImpuls = fourthImpulsTemp(1); % Index speichern
end
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
  % Plotsettings
  lineWidthPlot = 1;
  axisTop = max(trialDataRaw)+20;
  axisEnd = trialTime(end);
  textPosX = 32;
  textPosY = 32;
  hold on
  axis([0 axisEnd 0 axisTop(1)]);
  xlabel('Zeit (ms)','fontsize',18);
  ylabel('Kraft (N)','fontsize',18);
  
  % Plots
  plot([trialTime(1) trialTime(end)],[bodyWeight bodyWeight],'Color', [0.7,0.7,0.7])
  plot(trialTime,trialDataRaw,'Linewidth',lineWidthPlot)
  plot(trialTime(weightRange(1):weightRange(2)),trialDataRaw(weightRange(1):weightRange(2)), '-m','Linewidth',lineWidthPlot)
%   plot(trialTime,trialDataSmooth,'-r')
  plot(trialTime(startImpulsTemp(1)),trialDataRaw(startImpulsTemp(1)),'xr','Linewidth',lineWidthPlot)
  text(trialTime(startImpulsTemp(1))+textPosX,trialDataRaw(startImpulsTemp(1))+textPosY,'H');
  plot(trialTime(startImpuls),trialDataRaw(startImpuls),'ok','Linewidth',lineWidthPlot)
  text(trialTime(startImpuls)+textPosX,trialDataRaw(startImpuls)+textPosY,'1');
  plot(trialTime(secondImpuls),trialDataRaw(secondImpuls),'ok','Linewidth',lineWidthPlot)
  text(trialTime(secondImpuls)+textPosX,trialDataRaw(secondImpuls)+textPosY,'2');
  plot(trialTime(thirdImpuls),trialDataRaw(thirdImpuls),'ok','Linewidth',lineWidthPlot)
  text(trialTime(thirdImpuls)+textPosX,trialDataRaw(thirdImpuls)+textPosY,'3');
  plot(trialTime(fourthImpuls),trialDataRaw(fourthImpuls),'ok','Linewidth',lineWidthPlot)
  text(trialTime(fourthImpuls)+textPosX,trialDataRaw(fourthImpuls)+textPosY,'4');
end
% reverseTime = 0:length(startAreaReverse)-1;
% figure
% hold on
% plot(reverseTime, startAreaReverse)
% plot(reverseTime(startImpulsReverse(1)),startAreaReverse(startImpulsReverse(1)),'xr')

end