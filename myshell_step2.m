clear;
load 06ROFH.mat;
filename = '06_original.avi';
vObj = VideoReader(['/Users/wangkang/Documents/workspace/video/forged_sequences_avi/' filename]);
nFrames = vObj.NumberOfFrames;
fps = int32(vObj.FrameRate);
step = int32(fps/4);
vH = vObj.Height;
vW = vObj.Width;
blocksize = 16;
bh = 2*vH/blocksize - 1;
bw = 2*vW/blocksize - 1;
% ROFH 
meat = cell(0);
icount = 1;
fcount = 1;
for f = 1:step:nFrames-2*step+1
    for i = 1:bh
        for j = 1:bw
            for m = 1:bh
                for n= 1:bw
                    cc = normxcorr2(reshape(ROFH(i,j,f:f+2*step-1), 1, 2*step), reshape(ROFH(m,n,:), 1, nFrames-1));
                    offsets = int32(find(cc>0.985)) - 2*step + 1;
                    if ~isempty(offsets)
                        [h,w] = size(offsets);
                        if w == 1 && offsets(1) == f
                            continue;
                        end
                        meat{fcount, icount} = {f, i, j, offsets, m, n};
                        icount = icount + 1;
                    end
                end
            end
                        
        end
    end
    fcount = fcount + 1;
    icount = 0;
end