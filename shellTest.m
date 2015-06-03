load meat.mat

filename = '06_original.avi';
vObj = VideoReader(['/Users/wangkang/Documents/workspace/video/forged_sequences_avi/' filename]);
nFrames = vObj.NumberOfFrames;
fps = int32(vObj.FrameRate);
vH = vObj.Height;
vW = vObj.Width;
blocksize = 16;
bh = 2*vH/blocksize - 1;
bw = 2*vW/blocksize - 1;
[m, n] = size(meat);

mosaic = zeros(vH, vW);
fb = 1;
for i = 1:m
    for j = 1:n
        disp([i, j]);
        tmp =  meat{i,j};
        f = tmp{1};
        offsets = tmp{4};
        [h,w] = size(offsets);
        for m=1:w
            if offsets(m) == tmp{1}
                continue;
            end
            by = (tmp{2}-1)*blocksize/2+1;bx = (tmp{3}-1)*blocksize/2+1;
            mosaic(by:by+blocksize-1, bx:bx+blocksize-1) = 1;
        end
        if f~=fb
            disp(fb);
            imshow(mosaic, []);
            k = input('');
            mosaic(:,:) = 0;
        end
        fb = f;
    end
end

% function matchMatrix = slideWindow()
% 
% 
% end

