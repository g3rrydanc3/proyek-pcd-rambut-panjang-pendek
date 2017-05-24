I = imread('amuba.jpg');
I = I(:,:,1);
I = (I<32);
I = imdilate(I, [1 1 1;1 1 1; 1 1 1]);

I = bwmorph(I, 'skel', Inf);
I = bwmorph(I, 'spur', 10);
%ujung = bwmorph(I, 'endpoints');
%imshow(ujung);

imshow(I)

[label, num] = bwlabel(I);
imshow(label+1, [0 0 0; 1 0 0; 0 1 0; 0 0 1])

for i = 1:num
    pulau = (label==i)
    ujung = bwmorph(pulau, 'endpoints');
    jum = sum(sum(ujung));
    s = sprintf('Amuba ke %d memiliki %d sungut', i, jum);
    display(s);
end

imshow(label+1, [0 0 0; 1 0 0; 0 0 1])
    