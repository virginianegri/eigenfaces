function varargout = imageSelector(varargin)
% IMAGESELECTOR MATLAB code for imageSelector.fig
%      IMAGESELECTOR, by itself, creates a new IMAGESELECTOR or raises the existing
%      singleton*.
%
%      H = IMAGESELECTOR returns the handle to a new IMAGESELECTOR or the handle to
%      the existing singleton*.
%
%      IMAGESELECTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMAGESELECTOR.M with the given input arguments.
%
%      IMAGESELECTOR('Property','Value',...) creates a new IMAGESELECTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before imageSelector_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to imageSelector_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help imageSelector

% Last Modified by GUIDE v2.5 24-May-2019 17:54:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @imageSelector_OpeningFcn, ...
                   'gui_OutputFcn',  @imageSelector_OutputFcn, ...
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


% --- Executes just before imageSelector is made visible.
function imageSelector_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to imageSelector (see VARARGIN)

% Choose default command line output for imageSelector
handles.output = hObject;

%% Fill listbox with all images to classify
allFileNames = [];
index = 1;
for dirs=1:6
    currDir = sprintf('%1d',dirs);
    files = dir(fullfile(pwd,currDir,'*.bmp'));
    for x = 1 : length(files)
        [im1a, map1] = imread(fullfile(pwd,currDir,files(x).name));
        im1 = ind2rgb(im1a,map1);
        im1 = rgb2gray(im1);
        handles.images{index} = im1;
        index = index + 1;
        allFileNames = [allFileNames; files(x).name];
    end
end
set(handles.listbox1,'string',allFileNames);
guidata(hObject, handles);
% End filling

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes imageSelector wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = imageSelector_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.output = hObject;
index = get(handles.listbox1,'value');
imgToDisplay = handles.images{index};
axes(handles.axes2);
imshow(imgToDisplay);

%% Classify image using eigenfaces
[class, outputImage] = classifyImage(handles.images{index});

%% Display image and class
classString = sprintf('%1d',class);
set(handles.text5, 'String', classString);
axes(handles.axes1);
imshow(outputImage);

guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
