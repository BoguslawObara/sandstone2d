function imsk = sandstone_microcracks_segmentation2d(im,s1,s2,nr)
%%  sandstone_microcracks_segmentation2d - microcracks segmentation
%   
%   REFERENCE:
%       Boguslaw Obara and Alena Kozusnikova and Jiri Scucka,
%       Automatic identification of microcracks observed on microscopic 
%       images of coarse-grained sandstone,
%       International Journal of Rock Mechanics and Mining Sciences,
%       48, 4, 681-686, 2011.
%
%   INPUT:
%       im      - image
%       s1      - size
%       s2      - size
%       nr      - number of rotations
%
%   OUTPUT:
%       imsk    - skeleton 
%
%   AUTHOR:
%       Boguslaw Obara

%% top-hat
immax = zeros(size(im),class(im));
for i=0:(180/nr):180-(180/nr)
    se = strel('line',s1,i);
    imtop = imtophat(im,se);
    immax = max(imtop,immax);
end

%% threshold
level = graythresh(immax);
imth = immax>level;

%% filter
immax = zeros(size(im))==1;
for i=0:(180/nr):180-(180/nr)
    se = strel('line',s2,1);
    ime = imerode(imth,se);
    imrec = imreconstruct(ime,imth);
    immax = max(immax,imrec);
end

%% skeleton
imsk = bwmorph(immax,'skel',Inf);
imsk = bwmorph(imsk,'spur',1);

end