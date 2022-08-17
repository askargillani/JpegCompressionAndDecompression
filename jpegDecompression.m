function [outputMatrix] = jpegDecompression(link)
fileid=fopen(link);
format = '%d';
runEnc = fscanf(fileid,format);

i_rows = runEnc(1);
i_columns = runEnc(2);
rows = runEnc(3);
columns = runEnc(4);


linesRead=0;
i=5;


p_y=[];
p_cb=[];
p_cr=[];

uq_y=[];
uq_cb=[];
uq_cr=[];

u_y=[];
u_cb=[];
u_cr=[];

inv_y=[];
inv_cb=[];
inv_cr=[];

co=0;
ii=1;
jj=1;
check=0;
while(linesRead<((rows*columns)/64) )
    %getting runlengthVector
    %display(ii+" "+(ii+7)+" "+(jj)+" "+(jj+7));
    count=0;
    rm_y = [];
    index=1;
    check=check+1;

    while(count~=64)
        rm_y(index,1)=runEnc(i);
        i=i+1;
        rm_y(index,2)=runEnc(i);
        i=i+1;
        count=count+rm_y(index,2);
        index=index+1;
    end
    count=0;
    rm_cb = [];
    index=1;
    while(count~=64)
        rm_cb(index,1)=runEnc(i);
        i=i+1;
        rm_cb(index,2)=runEnc(i);
        i=i+1;
        count=count+rm_cb(index,2);
        index=index+1;
    end

    count=0;
    rm_cr = [];
    index=1;
    while(count~=64)
        rm_cr(index,1)=runEnc(i);
        i=i+1;
        rm_cr(index,2)=runEnc(i);
        i=i+1;
        count=count+rm_cr(index,2);
        index=index+1;
    end
    %-----------------------------------------------------
    %now constructing post quantization matrix
    p_y(ii:ii+7,jj:jj+7)=inv_zigzag(rm_y);
    p_cb(ii:ii+7,jj:jj+7)=inv_zigzag(rm_cb);
    p_cr(ii:ii+7,jj:jj+7)=inv_zigzag(rm_cr);
    %-----------------------------------------------------
%     %now constructing unquantized matrix
    uq_y(ii:ii+7,jj:jj+7)=unquantizeY(p_y(ii:ii+7,jj:jj+7));
    uq_cb(ii:ii+7,jj:jj+7)=unquantizeCbcr(p_cb(ii:ii+7,jj:jj+7));
    uq_cr(ii:ii+7,jj:jj+7)=unquantizeCbcr(p_cr(ii:ii+7,jj:jj+7));
    %-----------------------------------------------------
    %inverse dct
    inv_y(ii:ii+7,jj:jj+7)=idct2(uq_y(ii:ii+7,jj:jj+7));
    inv_cb(ii:ii+7,jj:jj+7)=idct2(uq_cb(ii:ii+7,jj:jj+7));
    inv_cr(ii:ii+7,jj:jj+7)=idct2(uq_cr(ii:ii+7,jj:jj+7));
    %-----------------------------------------------------
    if(jj+7==columns)
        ii=ii+8;
        jj=1;
    else
        jj=jj+8;
    end
    
    
    
    linesRead=linesRead+1;
end

u_y=inv_y(1:i_rows,1:i_columns);
u_cb=inv_cb(1:i_rows,1:i_columns);
u_cr=inv_cr(1:i_rows,1:i_columns);

img=zeros(i_rows,i_columns,3);
my=[];
mcb=[];
mcr=[];

my=int16(u_y(1:end,1:end))+128;
mcb=int16(u_cb(1:end,1:end)+128);
mcr=int16(u_cr(1:end,1:end)+128);

img(1:end,1:end,1) = my(1:end,1:end);
img(1:end,1:end,2) = mcb(1:end,1:end);
img(1:end,1:end,3) = mcr(1:end,1:end);



img=uint8(img);


img = ycbcr2rgb(img);

imgr=img(1:end,1:end,1);
imgg=img(1:end,1:end,2);
imgb=img(1:end,1:end,3);


outputMatrix =img;


end