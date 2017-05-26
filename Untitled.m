I = imread('panjang.jpg');


RGB = insertShape(I,'circle',[150 280 35],'LineWidth',5);

pos_triangle = [183 297 302 250 316 297];
pos_hexagon = [340 163 305 186 303 257 334 294 362 255 361 191];
RGB = insertShape(RGB,'FilledPolygon',{pos_triangle,pos_hexagon},...
    'Color', {'white','green'},'Opacity',0.7);
I = RGB;
imshow(I);
