

chars=char(97:122);

for ns=1:length(chars)%imwrite(tempImage, 'z-l.jpg')
    
    imageName=[chars(ns),'-l.jpg'];
    
    letterImage=imread(imageName);
    letterImage=imresize(letterImage,[70,30],'bicubic');
     %letterImage = rgb2gray(letterImage);
 letterImage(letterImage < 128) = 1;
 letterImage(letterImage >= 128) = 0; % Pay attention to the order
 letterImage = logical(letterImage);
%     imwrite(letterImage, [chars(ns),'-l.jpg'])
    letterStruct=struct('letter',chars(ns),'array',letterImage);
    letterArray(ns)=letterStruct;
end
for ns=1:length(chars)%imwrite(tempImage, 'z-l.jpg')
    
    imageName=[chars(ns),'-u.jpg'];
    
    letterImage=imread(imageName);
    letterImage=imresize(letterImage,[70,30],'bicubic');
     %letterImage = rgb2gray(letterImage);
 letterImage(letterImage < 128) = 1;
 letterImage(letterImage >= 128) = 0; % Pay attention to the order
 letterImage = logical(letterImage);
%     imwrite(letterImage, [chars(ns),'-l.jpg'])
    letterStruct=struct('letter',[chars(ns),'-u'],'array',letterImage);
    letterArray(ns+26)=letterStruct;
end
imageFileName='1.jpg';%two other sets image.jpg sentence.jpg
[output,minVector]=RecognizeCharacters(imageFileName);
image = imread(imageFileName);
originalImage = image;
%image =  double(image);
image = rgb2gray(image);
image(image < 128) = 1;
image(image >= 128) = 0; % Pay attention to the order
image = logical(image); 
[row,col] = size(minVector);
LetterCoords = [];
imshow(originalImage);
dots = [];

% all non two part character label
for d=1:1:row
        imshow(image(minVector(d,1):minVector(d,3),minVector(d,2):minVector(d,4),:));
        tempLetter=imresize(image(minVector(d,1):minVector(d,3),minVector(d,2):minVector(d,4),:),[70,30],'bicubic');
        minSum=inf;
        minIndex=0;
        for ns=1:length(chars)*2
            ns
            curSum=sum(sum((letterArray(ns).array(1:70,1:30,1)-tempLetter(1:70,1:30,1)).^2));
            
            if(curSum<minSum)
                minIndex=ns;
                minSum=curSum;
            end
        end
        
        disp(letterArray(minIndex).letter);
        i=0;
        
end