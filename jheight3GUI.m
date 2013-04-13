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
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jheight3GUI

% Last Modified by GUIDE v2.5 13-Apr-2013 01:08:47

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
handles.fileCell = 9;

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
getFile   = handles.getFile;
fileCell  = handles.fileCell;
getPath   = handles.getPath;

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
  
  jumpHeight = jheight3([getPath newFilename])*100;
  jumpHeightString = num2str(jumpHeight,'% 10.2f');
  set(handles.txtFile, 'String', ['Datei:   ' newFilename]);
  set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
  
  % Werte setzen
  
end
handles.getFile = newFilename;
guidata( hObject, handles );

% --- Executes on button press in pbNext.
function pbNext_Callback(hObject, eventdata, handles)
% hObject    handle to pbNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
getFile   = handles.getFile;
fileCell  = handles.fileCell;
getPath   = handles.getPath;

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
  
  jumpHeight = jheight3([getPath newFilename])*100;
  jumpHeightString = num2str(jumpHeight,'% 10.2f');
  set(handles.txtFile, 'String', ['Datei:   ' newFilename]);
  set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);
  
  % Werte setzen
  
end
handles.getFile = newFilename;
guidata( hObject, handles );

% --- Executes on button press in pbDir.
function pbDir_Callback(hObject, eventdata, handles)
% hObject    handle to pbDir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[getFile getPath] = uigetfile({'*.csv;*.CSV;','CSV Files (*.csv,*.CSV)'}, 'Pick a file');
cla

fileList = dir(getPath);
fileCell  = struct2cell(fileList);
% Einträge 0 setzen, die nicht JPG sind
for knj = 1:length(fileList)
  knjj = length( fileCell{1,knj} );
  if knjj < 3 || strcmpi(fileCell{1,knj}(end-2:end), 'CSV') == 0 
    fileCell{1,knj} = 0;
  end
end

jumpHeight = jheight3([getPath getFile])*100;
jumpHeightString = num2str(jumpHeight,'% 10.2f');
set(handles.txtFile, 'String', ['Datei:   ' getFile]);
set(handles.txtJumpHeight, 'String', ['Sprunghöhe: ' jumpHeightString ' cm']);

handles.fileList = fileList;
handles.fileCell = fileCell;
handles.getFile = getFile;
handles.getPath = getPath;
guidata(hObject, handles);
