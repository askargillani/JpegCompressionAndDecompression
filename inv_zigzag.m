function [outputMatrix] = inv_zigzag(inputMatrix)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
flag=1;
count=0;
i=1;j=1;
ind = 1;
c=0;
outputMatrix=zeros(8,8);
while count<64
    if(flag==1)
        outputMatrix(i,j)=inputMatrix(ind,1);
        j=j+1;
        c=c+1;
        if(i==1)
            flag=2;
        elseif(i==8)
            flag=4;
        end
        count=count+1;
        if(c==inputMatrix(ind,2))
            ind=ind+1;
            c=0;
        end
    elseif(flag==2)
        if(i==8)
            flag=1;
        elseif(j==1)
            flag=3;
        else
            outputMatrix(i,j)=inputMatrix(ind,1);
            count=count+1;
            c=c+1;
            i=i+1;
            j=j-1;
        end
        if(c==inputMatrix(ind,2))
            ind=ind+1;
            c=0;
        end
    elseif(flag==3)
        outputMatrix(i,j)=inputMatrix(ind,1);
        i=i+1;
        c=c+1;
        count=count+1;
        if(j==1)
            flag=4;
        elseif(j==8)
            flag=2;
        end
        if(c==inputMatrix(ind,2))
            ind=ind+1;
            c=0;
        end
    elseif(flag==4)
        if(j==8)
            flag=3;
        elseif(i==1)
            flag=1;
        else
            outputMatrix(i,j)=inputMatrix(ind,1);
            count=count+1;
            c=c+1;
            i=i-1;
            j=j+1;
        end
        if(c==inputMatrix(ind,2))
            ind=ind+1;
            c=0;
        end
    end
    end
end

