function [saved] = jpegCompression(link)
saved=0;
s=imread(link);
rows = size(s,1);
columns = size(s,2);
i_rows=rows;
i_columns=columns;
sr=[];
sg=[];
sb=[];


if(mod(rows,8)~=0)
    rows = rows + ( 8 - mod(rows,8));
end
if(mod(columns,8)~=0)
    columns = columns+(8 - mod(columns,8));
end


S = uint8(zeros(rows,columns,3));

S(1:i_rows,1:i_columns,:) = s(1:i_rows,1:i_columns,:)+S(1:i_rows,1:i_columns,:);
s=S;
% sr=s(1:end,1:end,1);
% sg=s(1:end,1:end,2);
% sb=s(1:end,1:end,3);
ycbcr = int16(rgb2ycbcr(s))-128;


dy=[];
qy=[];
dcb=[];
qcb=[];
dcr=[];
qcr=[];

%individual y,cb and cr transformation
ly=int16(ycbcr(1:end,1:end,1));
lcb=int16(ycbcr(1:end,1:end,2));
lcr=int16(ycbcr(1:end,1:end,3));


y=ly;
cb=lcb;
cr=lcr;


zigzagY = [];
zigzagCb = [];
zigzagCr = [];

link1=link;
link1=split(link,'.');
link1=link1(1);
link1=link1+".cmp";
fileId = fopen(link1,'w');
fprintf(fileId,"%d %d %d %d",i_rows,i_columns,rows,columns);
fprintf(fileId,"\n");
for i=1:8:rows
    for j=1:8:columns
        %dct transformation of
        
        dy(i:(i+7),j:(j+7))=dct2(y(i:(i+7),j:(j+7)));
        dcb(i:(i+7),j:(j+7))=dct2(cb(i:(i+7),j:(j+7)));
        dcr(i:(i+7),j:(j+7))=dct2(cr(i:(i+7),j:(j+7)));
        
        %quantization of dcts
        qy(i:(i+7),j:(j+7))= quantizeY(dy(i:(i+7),j:(j+7)));
        qcb(i:(i+7),j:(j+7))=quantizeCbcr(dcb(i:(i+7),j:(j+7)));
        qcr(i:(i+7),j:(j+7))=quantizeCbcr(dcr(i:(i+7),j:(j+7)));
        
        
        %zigzag coefficients
        zigzagY = zigzag(qy(i:(i+7),j:(j+7)));
        zigzagCb = zigzag(qcb(i:(i+7),j:(j+7)));
        zigzagCr = zigzag(qcr(i:(i+7),j:(j+7)));

        for h=1:size(zigzagY)
            fprintf(fileId,"%d ",zigzagY(h,1));
            fprintf(fileId,"%d ",zigzagY(h,2));
        end
        fprintf(fileId,"\n");
        
        for h=1:size(zigzagCb)
            fprintf(fileId,"%d ",zigzagCb(h,1));
            fprintf(fileId,"%d ",zigzagCb(h,2));
        end
        fprintf(fileId,"\n");
        
        for h=1:size(zigzagCr)
            fprintf(fileId,"%d ",zigzagCr(h,1));
            fprintf(fileId,"%d ",zigzagCr(h,2));
        end
        fprintf(fileId,"\n");
    end
end

fclose(fileId);
saved=1;
end