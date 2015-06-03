filename = '06_original.avi';
vObj = VideoReader(['/Users/wangkang/Documents/workspace/video/forged_sequences_avi/' filename]);
nFrames = vObj.NumberOfFrames;
fps = vObj.FrameRate;
vH = vObj.Height;
vW = vObj.Width;
blocksize = 16;
bh = 2*vH/blocksize - 1;
bw = 2*vW/blocksize - 1;

ROFH = zeros(bh, bw, nFrames-1);
for i=2:nFrames
    disp(i);
    frame1 = rgb2gray(read(vObj, i-1));
    frame2 = rgb2gray(read(vObj, i));
    
    f1gray = im2double(frame1);
    f2gray = im2double(frame2);
    [u,v] = HierarchicalLK(f1gray, f2gray, 3, 4, 2, 0);
    fv = sqrt(u.^2+v.^2);

    for m=1:bh
        for n=1:bw
            indexH = (m-1)*blocksize/2+1;
            indexW = (n-1)*blocksize/2+1;
            of = sum(sum(fv(indexH:indexH+blocksize-1,indexW:indexW+blocksize-1)));
            ROFH(m, n, i-1) = of;
        end
    end 
end



save('06ROFH.mat', 'ROFH', 'fps');
