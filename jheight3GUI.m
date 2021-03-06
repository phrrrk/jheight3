function varargout = jheight3GUI(varargin)
% JHEIGHT3GUI MATLAB code for jheight3GUI.fig
%      JHEIGHT3GUI, by itself, creates a new JHEIGHT3GUI or raises the existing
%      singleton*.
%
%      H = JHEIGHT3GUI returns the handle to a new JHEIGHT3GUI or the handle to
%      the existing singleton*.
%
%      JHEIGHT3GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JHEIGHT3GUI.M with the given input arguments.
%
%      JHEIGHT3GUI('Property','Value',...) creates a new JHEIGHT3GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jheight3GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jheight3GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
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

% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jheight3GUI

% Last Modified by GUIDE v2.5 22-Apr-2013 10:41:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jheight3GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @jheight3GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before jheight3GUI is made visible.
function jheight3GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jheight3GUI (see VARARGIN)

% Choose default command line output for jheight3GUI
handles.output = hObject;
handles.fileList = hObject;
handles.fileList = 0;
handles.getFile = hObject;
handles.getFile = 0;
handles.getPath = hObject;
handles.getPath = 0;
handles.fileCell = hObject;
handles.fileCell = 0;
handles.weightRange = hObject;
handles.weightRange = [50 1050]; 
handles.startImpuls = hObject;
handles.startImpuls = 0;
handles.secondImpuls = hObject;
handles.secondImpuls = 0;
handles.thirdImpuls = hObject;
handles.thirdImpuls = 0;
handles.fourthImpuls = hObject;
handles.fourthImpuls = 0;
handles.startImpulsTemp = hObject;
handles.startImpulsTemp = 0;
handles.bodyWeight = hObject;
handles.bodyWeight = 0;
handles.jumpHeight = hObject;
handles.jumpHeight = 0;
handles.saveList = hObject;
handles.saveList = 0;

set(handles.rbStartImpuls,'Value',0);
set(handles.rbSecondImpuls,'Value',0);
set(handles.rbThirdImpuls,'Value',0);
set(handles.rbFourthImpuls,'Value',0);
set(handles.rbStartImpulsTemp,'Value',1);
set(handles.editWeightStart,'String',num2str(handles.weightRange(1)));
set(handles.editWeightEnd,'String',num2str(handles.weightRange(2)));

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes jheight3GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jheight3GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pbBack.
function pbBack_Callback(hObject, eventdata, handles)
% hObject    handle to pbBack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getFile      = handles.getFile;
fileCell     = handles.fileCell;
getPath      = handles.getPath;
weightRange  = handles.weightRange;
startImpuls  = 0;
secondImpuls = 0;
thirdImpuls  = 0;
fourthImpuls = 0;
startImpulsTemp = 0;

for i = 1:length(fileCell)
  k = strfind(fileCell{1,i}, getFile);
  if k == 1
  currentFile = i;
  break
  end
end

if getFile ~= 0
  % DEFAULTS wieder setzen
  cla
  if currentFile == 1
    newFilename = fileCell{1,length(fileCell)};
  else
    newFilename = fileCell{1,currentFile-1};
  end
  
  while newFilename == 0
    currentFile = currentFile-1;
    if currentFile < 1
      currentFile = length(fileCell);
    end
    newFilename = fileCell{1,currentFile};
  end
  
  [jumpHeight, bodyWeight] = jheight3([getPath newFilename], weightRange, startImpuls, ...
                                      secondImpuls, thirdImpuls, fourthImpuls,startImpulsTemp, 1);
  jumpHeight = jumpHeight*100;
  bodyWeight = bodyWeight/9.81;
  jumpHeightString = num2str(jumpHeight,'% 10.2f');
  bodyWeightString = num2str(bodyWeight,'% 10.2f');
  set(handles.txtFile, 'String', newFilename);
  set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
  set(handles.txtBodyWeight, 'String', ['Körpergewicht: ' bodyWeightString ' kg']);

  
  % Werte setzen
  
end
handles.getFile = newFilename;
handles.bodyWeight = bodyWeight;
handles.weightRange = weightRange;
handles.startImpuls = startImpuls;
handles.secondImpuls = secondImpuls;
handles.thirdImpuls = thirdImpuls;
handles.fourthImpuls = fourthImpuls;
handles.startImpulsTemp = startImpulsTemp;
handles.jumpHeight = jumpHeight;

guidata( hObject, handles );

% --- Executes on button press in pbNext.
function pbNext_Callback(hObject, eventdata, handles)
% hObject    handle to pbNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getFile      = handles.getFile;
fileCell     = handles.fileCell;
getPath      = handles.getPath;
weightRange  = handles.weightRange;
startImpuls  = 0;
secondImpuls = 0;
thirdImpuls  = 0;
fourthImpuls = 0;
startImpulsTemp = 0;

for i = 1:length(fileCell)
  k = strfind(fileCell{1,i}, getFile);
  if k == 1
  currentFile = i;
  break
  end
end

if getFile ~= 0
  % DEFAULTS wieder setzen
  cla
  if currentFile == length(fileCell)
    newFilename = fileCell{1,1};
  else
    newFilename = fileCell{1,currentFile+1};
  end
  
  while newFilename == 0
    currentFile = currentFile+1;
    if currentFile > length(fileCell)
      currentFile = 1;
    end
    newFilename = fileCell{1,currentFile};
  end
  
  [jumpHeight bodyWeight] = jheight3([getPath newFilename], weightRange, startImpuls, ...
                                     secondImpuls, thirdImpuls, fourthImpuls,startImpulsTemp, 1);
  jumpHeight = jumpHeight*100;
  bodyWeight = bodyWeight/9.81;
  jumpHeightString = num2str(jumpHeight,'% 10.2f');
  bodyWeightString = num2str(bodyWeight,'% 10.2f');
  set(handles.txtFile, 'String', newFilename);
  set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
  set(handles.txtBodyWeight, 'String', ['Körpergewicht: ' bodyWeightString ' kg']);
  
end
handles.getFile = newFilename;
handles.bodyWeight = bodyWeight;
handles.weightRange = weightRange;
handles.startImpuls = startImpuls;
handles.secondImpuls = secondImpuls;
handles.thirdImpuls = thirdImpuls;
handles.fourthImpuls = fourthImpuls;
handles.startImpulsTemp = startImpulsTemp;
handles.jumpHeight = jumpHeight;

guidata( hObject, handles );

% --- Executes on button press in pbDir.
function pbDir_Callback(hObject, eventdata, handles)
% hObject    handle to pbDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
weightRange  = handles.weightRange;
startImpuls  = 0;
secondImpuls = 0;
thirdImpuls  = 0;
fourthImpuls = 0;
startImpulsTemp = 0;

[getFile getPath] = uigetfile({'*.csv;*.CSV;','CSV Files (*.csv,*.CSV)'}, 'Pick a file');
cla

fileList = dir(getPath);
fileCell  = struct2cell(fileList);
% Einträge 0 setzen, die nicht CSV sind
for knj = 1:length(fileList)
  knjj = length( fileCell{1,knj} );
  if knjj < 3 || strcmpi(fileCell{1,knj}(end-2:end), 'CSV') == 0 
    fileCell{1,knj} = 0;
  end
end

[jumpHeight bodyWeight] = jheight3([getPath getFile], weightRange, startImpuls, ...
                                   secondImpuls, thirdImpuls, fourthImpuls, startImpulsTemp, 1);
jumpHeight = jumpHeight * 100;
bodyWeight = bodyWeight / 9.81;
jumpHeightString = num2str(jumpHeight,'% 10.2f');
bodyWeightString = num2str(bodyWeight,'% 10.2f');
set(handles.txtFile, 'String', getFile);
set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
set(handles.txtBodyWeight, 'String', ['Körpergewicht: ' bodyWeightString ' kg']);


handles.fileList = fileList;
handles.fileCell = fileCell;
handles.getFile = getFile;
handles.getPath = getPath;
handles.bodyWeight = bodyWeight;
handles.weightRange = weightRange;
handles.startImpuls = startImpuls;
handles.secondImpuls = secondImpuls;
handles.thirdImpuls = thirdImpuls;
handles.fourthImpuls = fourthImpuls;
handles.startImpulsTemp = startImpulsTemp;
handles.jumpHeight = jumpHeight;

guidata(hObject, handles);



function editWeightStart_Callback(hObject, eventdata, handles)
% hObject    handle to editWeightStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWeightStart as text
%        str2double(get(hObject,'String')) returns contents of editWeightStart as a double
handles.weightRange(1) = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editWeightStart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWeightStart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editWeightEnd_Callback(hObject, eventdata, handles)
% hObject    handle to editWeightEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editWeightEnd as text
%        str2double(get(hObject,'String')) returns contents of editWeightEnd as a double
handles.weightRange(2) = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function editWeightEnd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editWeightEnd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in rbStartImpuls.
function rbStartImpuls_Callback(hObject, eventdata, handles)
% hObject    handle to rbStartImpuls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbStartImpuls
set(handles.rbSecondImpuls,'Value',0);
set(handles.rbThirdImpuls,'Value',0);
set(handles.rbFourthImpuls,'Value',0);
set(handles.rbStartImpulsTemp,'Value',0);

% --- Executes on button press in rbSecondImpuls.
function rbSecondImpuls_Callback(hObject, eventdata, handles)
% hObject    handle to rbSecondImpuls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbSecondImpuls
set(handles.rbStartImpuls,'Value',0);
set(handles.rbThirdImpuls,'Value',0);
set(handles.rbFourthImpuls,'Value',0);
set(handles.rbStartImpulsTemp,'Value',0);

% --- Executes on button press in rbThirdImpuls.
function rbThirdImpuls_Callback(hObject, eventdata, handles)
% hObject    handle to rbThirdImpuls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbThirdImpuls
set(handles.rbStartImpuls,'Value',0);
set(handles.rbSecondImpuls,'Value',0);
set(handles.rbFourthImpuls,'Value',0);
set(handles.rbStartImpulsTemp,'Value',0);

% --- Executes on button press in rbFourthImpuls.
function rbFourthImpuls_Callback(hObject, eventdata, handles)
% hObject    handle to rbFourthImpuls (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbFourthImpuls
set(handles.rbStartImpuls,'Value',0);
set(handles.rbSecondImpuls,'Value',0);
set(handles.rbThirdImpuls,'Value',0);
set(handles.rbStartImpulsTemp,'Value',0);

% --- Executes on button press in pbSet.
function pbSet_Callback(hObject, eventdata, handles)
% hObject    handle to pbSet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getFile      = handles.getFile;
getPath      = handles.getPath;
weightRange  = handles.weightRange;
startImpuls  = handles.startImpuls;
secondImpuls = handles.secondImpuls;
thirdImpuls  = handles.thirdImpuls;
fourthImpuls = handles.fourthImpuls;
startImpulsTemp = handles.startImpulsTemp;

but = 0;
while but == 0
  [x,y,but] = ginput2(1);
  x = round(x);
  y = round(y);
  if get(handles.rbStartImpuls,'Value') == 1
    startImpuls = x;
  elseif get(handles.rbSecondImpuls,'Value') == 1
    secondImpuls = x;
  elseif get(handles.rbThirdImpuls,'Value') == 1
    thirdImpuls = x;
  elseif get(handles.rbFourthImpuls,'Value') == 1
    fourthImpuls = x;
  elseif get(handles.rbStartImpulsTemp,'Value') == 1
    startImpulsTemp = x;
  end
  
  cla
  [jumpHeight bodyWeight] = jheight3([getPath getFile], weightRange, startImpuls, ...
                                     secondImpuls, thirdImpuls, fourthImpuls,startImpulsTemp, 1);
  jumpHeight = jumpHeight*100;
  bodyWeight = bodyWeight/9.81;
  jumpHeightString = num2str(jumpHeight,'% 10.2f');
  bodyWeightString = num2str(bodyWeight,'% 10.2f');
  set(handles.txtFile, 'String', getFile);
  set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
  set(handles.txtBodyWeight, 'String', ['Körpergewicht: ' bodyWeightString ' kg']);
end
handles.startImpuls = startImpuls;
handles.secondImpuls = secondImpuls;
handles.thirdImpuls = thirdImpuls;
handles.fourthImpuls = fourthImpuls;
handles.bodyWeight = bodyWeight;
handles.weightRange = weightRange;
handles.startImpuls = startImpuls;
handles.secondImpuls = secondImpuls;
handles.thirdImpuls = thirdImpuls;
handles.fourthImpuls = fourthImpuls;
handles.startImpulsTemp = startImpulsTemp;
handles.jumpHeight = jumpHeight;
handles.getFile = getFile;

guidata( hObject, handles );

% --- Executes on button press in rbStartImpulsTemp.
function rbStartImpulsTemp_Callback(hObject, eventdata, handles)
% hObject    handle to rbStartImpulsTemp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rbStartImpulsTemp
set(handles.rbStartImpuls,'Value',0);
set(handles.rbSecondImpuls,'Value',0);
set(handles.rbThirdImpuls,'Value',0);
set(handles.rbFourthImpuls,'Value',0);


% --- Executes on button press in pbRefresh.
function pbRefresh_Callback(hObject, eventdata, handles)
% hObject    handle to pbRefresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getFile      = handles.getFile;
fileCell     = handles.fileCell;
getPath      = handles.getPath;
weightRange  = handles.weightRange;
startImpuls  = handles.startImpuls;
secondImpuls = handles.secondImpuls;
thirdImpuls  = handles.thirdImpuls;
fourthImpuls = handles.fourthImpuls;
startImpulsTemp = handles.startImpulsTemp;

cla
[jumpHeight bodyWeight] = jheight3([getPath getFile], weightRange, startImpuls, ...
                                   secondImpuls, thirdImpuls, fourthImpuls, startImpulsTemp, 1);
jumpHeight = jumpHeight*100;
bodyWeight = bodyWeight/9.81;
jumpHeightString = num2str(jumpHeight,'% 10.2f');
bodyWeightString = num2str(bodyWeight,'% 10.2f');
set(handles.txtFile, 'String', getFile);
set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
set(handles.txtBodyWeight, 'String', ['Körpergewicht: ' bodyWeightString ' kg']);


handles.bodyWeight = bodyWeight;
handles.weightRange = weightRange;
handles.startImpuls = startImpuls;
handles.secondImpuls = secondImpuls;
handles.thirdImpuls = thirdImpuls;
handles.fourthImpuls = fourthImpuls;
handles.startImpulsTemp = startImpulsTemp;
handles.jumpHeight = jumpHeight;
handles.getFile = getFile;

guidata(hObject, handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
saveList = handles.saveList;
fileCell = handles.fileCell;
sizeFileCell = size(saveList);
if saveList ~= 0
  for i = 1:sizeFileCell(2)
    saveString = char(fileCell(saveList(2,i)));
    saveListCell{i,1} = saveString;
    saveListCell{i,2} = saveList(1,i);
    saveListCell{i,3} = saveList(3,i);
  end
  c = clock;
  saveString = [date '_' num2str(c(4)) num2str(c(5)) '_Sprunghoehe.xls'];
  xlswrite(saveString, saveListCell);
end

delete(hObject);


% --- Executes on button press in pbSave.
function pbSave_Callback(hObject, eventdata, handles)
% hObject    handle to pbSave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Sprunghöhe, Name, 
jumpHeight = handles.jumpHeight;
getFile = handles.getFile;
saveList = handles.saveList;
fileCell = handles.fileCell;
weightRange = handles.weightRange;
weightRangeSingleValue = weightRange(2)-weightRange(1);

numberForFileame = find(strcmp(fileCell,getFile) == 1);
if saveList == 0
  saveList(1,1) = jumpHeight;
  saveList(2,1) = numberForFileame;
  saveList(3,1) = weightRangeSingleValue; 
else 
  testForExistingFile = find(saveList == numberForFileame);
  if isempty(testForExistingFile) == 1
    endOfList = size(saveList);
    saveList(1,endOfList(2)+1) = jumpHeight;
    saveList(2,endOfList(2)+1) = numberForFileame;
    saveList(3,endOfList(2)+1) = weightRangeSingleValue;
  else
    saveList(testForExistingFile-1) = jumpHeight;
    saveList(testForExistingFile+1) = weightRangeSingleValue;
  end
    
end
handles.saveList = saveList;
guidata(hObject, handles);