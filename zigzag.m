function [outputMatrix] = zigzag(inputMatrix)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
flag=1;
count=1;
i=1;j=1;
ind = 1;
outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
while count<64
    if flag == 1
       j=j+1;
       if(inputMatrix(i,j)==outputMatrix(ind,1))
           outputMatrix(ind,2)=outputMatrix(ind,2)+1;
       end
       if(inputMatrix(i,j)~=outputMatrix(ind,1))
           ind=ind+1;
           outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
       end
       count=count+1;
       flag=4;
    end
    if flag==4
        while(i<8 && j>1 )
            i=i+1;
            j=j-1;
            if(inputMatrix(i,j)==outputMatrix(ind,1))
                outputMatrix(ind,2)=outputMatrix(ind,2)+1;
            end
            if(inputMatrix(i,j)~=outputMatrix(ind,1))
                ind=ind+1;
                outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
            end
            count=count+1;
        end
        flag=2;
        if(i==8)
           flag=5;
        end
    end
    if flag==2
        i=i+1;
        if(inputMatrix(i,j)==outputMatrix(ind,1))
           outputMatrix(ind,2)=outputMatrix(ind,2)+1;
        end
        if(inputMatrix(i,j)~=outputMatrix(ind,1))
           ind=ind+1;
           outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
        end
        count=count+1;
        flag=3;
    end
    if flag==3
        while(i>1 && j<8 )
            i=i-1;
            j=j+1;
            if(inputMatrix(i,j)==outputMatrix(ind,1))
                outputMatrix(ind,2)=outputMatrix(ind,2)+1;
            end
            if(inputMatrix(i,j)~=outputMatrix(ind,1))
                ind=ind+1;
                outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
            end
            count=count+1;
        end
        flag=1;
        if j==8
            flag=6;
        end
    end
    if flag==5
        j=j+1;
        if(inputMatrix(i,j)==outputMatrix(ind,1))
           outputMatrix(ind,2)=outputMatrix(ind,2)+1;
        end
        if(inputMatrix(i,j)~=outputMatrix(ind,1))
           ind=ind+1;
           outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
        end
        count=count+1;
        flag=3;
    end
    if flag == 6
        i=i+1;
        if(inputMatrix(i,j)==outputMatrix(ind,1))
           outputMatrix(ind,2)=outputMatrix(ind,2)+1;
        end
        if(inputMatrix(i,j)~=outputMatrix(ind,1))
           ind=ind+1;
           outputMatrix(ind,1:2)=[inputMatrix(i,j),1];
        end
        count=count+1;
        flag=4;
    end
end 
end

