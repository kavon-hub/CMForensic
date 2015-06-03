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
% mosaic = zeros(bh, bw);
offset = 0;
for i = 1:m
    for j = 1:n
        evidence = false;
        tmp =  meat{i,j};
        if isempty(tmp)
            break;
        end
        offsets = tmp{4};
        offset = size(offsets, 2);
        w = size(offsets, 2);
        if w==1
            continue;
        end
        for t=1:w
            if offsets(t) == tmp{1}
                continue;
            else
                evidence = true;
                break;
            end
        end
        if evidence
%             by = tmp{2};bx = tmp{3};
%             mosaic(by, bx) = offset;
            by = (tmp{2}-1)*blocksize/2+1;bx = (tmp{3}-1)*blocksize/2+1;
            mosaic(by:by+blocksize-1, bx:bx+blocksize-1) = 1;
        end
        offset = 0;
    end
%     if ((i-1)*fps/4+1) >= 181
        disp((i-1)*fps/4+1);
%         disp(mosaic);
        imshow(mosaic, []);
        k = input('');
        mosaic(:,:) = 0;
%     end
end
% 
% function matchMatrix = slideWindow(ROFH)
% [m, n] = size(ROFH);
% 
% matchMatrix = zeros(vH, vW);
% 
% end

