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
clc;
clear all;
[filename, pathname] = uigetfile({'*.jpg';'*.jpeg';'*.png';'*.gif';'*.*'},'File Selector');
 if isequal(filename,0)
else
   disp(['User selected ', fullfile(pathname, filename)])
 end

FDetect = vision.CascadeObjectDetector; 
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',16);
MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',16); 

I = imread(fullfile(pathname, filename));
Foto = I;
%detect face
Face = step(FDetect,I);
Eye = step(EyeDetect,I);
Nose=step(NoseDetect,I);
Mouth=step(MouthDetect,I);
ctr = 0;

figure,imshow(I);

hold on
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
%end detect face
%hold off

if ctr >= 1
    atas = [a.Position(1) 0 a.Position(3) a.Position(2)];
    RGB = insertShape(I,'rectangle', atas,'LineWidth',5);
	I = RGB;
    
    kiriA = [a.Position(1)-25 a.Position(2) 25 a.Position(4)];
    RGB = insertShape(I,'rectangle', kiriA,'LineWidth',5);
	I = RGB;
    
    kananA = [a.Position(1)+a.Position(3) a.Position(2) 25 a.Position(4)];
    RGB = insertShape(I,'rectangle', kananA,'LineWidth',5);
	I = RGB;
    
    kiriB = [kiriA(1) kiriA(2)+kiriA(4) kiriA(3) kiriA(4)];
    RGB = insertShape(I,'rectangle', kiriB,'LineWidth',5);
	I = RGB;
    
    kananB = [kananA(1) kananA(2)+kananA(4) kananA(3) kananA(4)];
    RGB = insertShape(I,'rectangle', kananB,'LineWidth',5);
	I = RGB;
    
    figure, imshow(I);
end

hold off
kotak1 = imcrop(I, atas);
kotak2 = imcrop(I, kiriA);
kotak3 = imcrop(I, kananA);
kotak4 = imcrop(I, kiriB);
kotak5 = imcrop(I, kananB);

dominantRedValue1 = mean2(kotak1(:, :, 1));
dominantGreenValue1 = mean2(kotak1(:, :, 2));
dominantBlueValue1 = mean2(kotak1(:, :, 3));

dominantRedValue2 = mean2(kotak2(:, :, 1));
dominantGreenValue2 = mean2(kotak2(:, :, 2));
dominantBlueValue2 = mean2(kotak2(:, :, 3));

dominantRedValue3 = mean2(kotak3(:, :, 1));
dominantGreenValue3 = mean2(kotak3(:, :, 2));
dominantBlueValue3 = mean2(kotak3(:, :, 3));

dominantRedValue4 = mean2(kotak4(:, :, 1));
dominantGreenValue4 = mean2(kotak4(:, :, 2));
dominantBlueValue4 = mean2(kotak4(:, :, 3));

dominantRedValue5 = mean2(kotak5(:, :, 1));
dominantGreenValue5 = mean2(kotak5(:, :, 2));
dominantBlueValue5 = mean2(kotak5(:, :, 3));

if dominantRedValue1+60 >= dominantRedValue2 || dominantRedValue1-60 >= dominantRedValue2 || dominantRedValue1+60 >= dominantRedValue3 || dominantRedValue1-60 >= dominantRedValue3
    if dominantGreenValue1+60 >= dominantGreenValue2 || dominantGreenValue1-60 >= dominantGreenValue2 || dominantGreenValue1+60 >= dominantGreenValue3 || dominantGreenValue1-60 >= dominantGreenValue3
        if dominantBlueValue1+60 >= dominantBlueValue2 || dominantBlueValue1-60 >= dominantBlueValue2 || dominantBlueValue1+60 >= dominantBlueValue3 || dominantBlueValue1-60 >= dominantBlueValue3
            if dominantRedValue2+60 >= dominantRedValue4 || dominantRedValue2-60 >= dominantRedValue4 || dominantRedValue3+60 >= dominantRedValue5 || dominantRedValue3-60 >= dominantRedValue5
                if dominantGreenValue2+60 >= dominantGreenValue4 || dominantGreenValue2-60 >= dominantGreenValue4 || dominantGreenValue3+60 >= dominantGreenValue5 || dominantGreenValue3-60 >= dominantGreenValue5
                    if dominantBlueValue2+60 >= dominantBlueValue4 || dominantBlueValue2-60 >= dominantBlueValue4 || dominantBlueValue3+60 >= dominantBlueValue5 || dominantBlueValue3-60 >= dominantBlueValue5
                        figure, imshow(Foto)
                        title('Rambut Panjang');
                    else
                        figure, imshow(Foto)
                        title('Rambut Pendek');
                    end
                else
                    figure, imshow(Foto)
                    title('Rambut Pendek');
                end
            else
                figure, imshow(Foto)
                title('Rambut Pendek');
            end
        else
            figure, imshow(Foto)
            title('Rambut Pendek');
        end
    else
        figure, imshow(Foto)
        title('Rambut Pendek');
    end
else
    figure, imshow(Foto)
    title('Rambut Pendek');
end

display(dominantRedValue1)
display(dominantRedValue2+60)