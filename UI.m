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
 
I = imread(fullfile(pathname, filename));

% I = I(:, :, 1);
% bw = edge(I)
% figure, imshow(I)
%  figure, imshow(bw);
I = rgb2gray(I);
BW = imbinarize(I);

C = bwareaopen(BW, 7500);
gambar = 1-C;

bw2 = bwmorph(gambar, 'spur', 5000);
D = edge(bw2);
figure, imshow(D)
 
% title('Eyes Detection');

%H=imrect(gca);
%pos=wait(H);
%close all
%I(pos(1,2):pos(1,2)+pos(1,4),pos(1,1):pos(1,1)+pos(1,3))=0;
%figure, imshow(H);
%Eyes=imcrop(I,BB);
%figure,imshow(Eyes);

% Ieye = Ieye(:,:,1);
% figure;
% imshow(Ieye);
% Ieye = (eyeI<32);
% Ieye = imdilate(Ieye, [1 1 1;1 1 1; 1 1 1]);
% figure;
% imshow(Ieye);
% 
% BW3 = bwmorph(Ieye,'skel',Inf);
% ujung = bwmorph(BW3, 'thin');
% figure
% imshow(ujung)
% 
% 
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% BW3 = imdilate(BW3, [1 1 1;1 1 1; 1 1 1]);
% figure
% imshow(BW3)
% %ujung = bwmorph(I, 'endpoints');
% % %imshow(ujung);
% % figure;
% % imshow(I)
% % 
% % [label, num] = bwlabel(I);
% % imshow(label+1, [0 0 0; 1 0 0; 0 1 0; 0 0 1])
% 
% % for i = 1:num
% %     pulau = (label==i);
% %     ujung = bwmorph(pulau, 'endpoints');
% %     jum = sum(sum(ujung));
% %     s = sprintf('Amuba ke %d memiliki %d sungut', i, jum);
% %     display(s);
% %     set(handles.text4, 'String', s);
% % end
% % 
% % figure;
% % imshow(label+1, [0 0 0; 1 0 0; 0 0 1])
% %     
