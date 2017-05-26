function varargout = UI(varargin)
% UI MATLAB code for UI.fig
%      UI, by itself, creates a new UI or raises the existing
%      singleton*.
%
%      H = UI returns the handle to a new UI or the handle to
%      the existing singleton*.
%
%      UI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI.M with the given input arguments.
%
%      UI('Property','Value',...) creates a new UI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before UI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to UI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help UI

% Last Modified by GUIDE v2.5 24-May-2017 12:34:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @UI_OpeningFcn, ...
                   'gui_OutputFcn',  @UI_OutputFcn, ...
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


% --- Executes just before UI is made visible.
function UI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to UI (see VARARGIN)

% Choose default command line output for UI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes UI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = UI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile({'*.jpg';'*.png';'*.gif';'*.*'},'File Selector');
 if isequal(filename,0)
else
   disp(['User selected ', fullfile(pathname, filename)])
 end

FDetect = vision.CascadeObjectDetector; 
 
EyeDetect = vision.CascadeObjectDetector('EyePairBig');

NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);


MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16); 

I = imread(fullfile(pathname, filename));

%detect face
Face = step(FDetect,I);
Eye = step(EyeDetect,I);
Nose=step(NoseDetect,I);
Mouth=step(MouthDetect,I);
ctr = 0;


figure,
imshow(I); 

%hold on
for i = 1:size(Face,1)
    a = rectangle('Position',Face(i,:),'LineWidth',5,'LineStyle','-','EdgeColor','r');
    RGB = insertShape(I,'rectangle',a.Position,'LineWidth',5);
    I = RGB;
    ctr = ctr+1;
end
b = rectangle('Position',Eye,'LineWidth',4,'LineStyle','-','EdgeColor','b');
RGB = insertShape(I,'rectangle',b.Position,'LineWidth',5);
I = RGB;
ctr = ctr+1;
for i = 1:size(Nose,1)
    c = rectangle('Position',Nose(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','b');
    RGB = insertShape(I,'rectangle',c.Position,'LineWidth',5);
    I = RGB;
    ctr = ctr+1;
end
for i = 1:size(Mouth,1)
    d = rectangle('Position',Mouth(i,:),'LineWidth',4,'LineStyle','-','EdgeColor','r');
    RGB = insertShape(I,'rectangle',d.Position,'LineWidth',5);
    I = RGB;
    ctr = ctr+1;
end

%hold off

if ctr >= 4
    atas = [a.Position(1) 0 a.Position(3) a.Position(2)];
    RGB = insertShape(I,'rectangle', atas,'LineWidth',5);
	I = RGB;
    
    kiriA = [a.Position(1)-100 a.Position(2) 100 a.Position(4)];
    RGB = insertShape(I,'rectangle', kiriA,'LineWidth',5);
	I = RGB;
    
    kananA = [a.Position(1)+a.Position(3) a.Position(2) 100 a.Position(4)];
    RGB = insertShape(I,'rectangle', kananA,'LineWidth',5);
	I = RGB;
    
    kiriB = [kiriA(1) kiriA(2)+kiriA(4) kiriA(3) kiriA(4)];
    RGB = insertShape(I,'rectangle', kiriB,'LineWidth',5);
	I = RGB;
    
    kananB = [kananA(1) kananA(2)+kananA(4) kananA(3) kananA(4)];
    RGB = insertShape(I,'rectangle', kananB,'LineWidth',5);
	I = RGB;
end

%hold off

figure,imshow(I);



%end detect face