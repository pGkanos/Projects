function A=Mx_Make_77(mx_id,n)

    if strcmp(mx_id,'had')
        A=hadamard(n);
    elseif strcmp(mx_id,'trihad')
        A=triu(hadamard(n));
    elseif strcmp(mx_id,'toep')
        A=toeplitz([4,-1,zeros(1,n-2)]);
    elseif strcmp(mx_id,'mc')
        A=rand(n);
        for i=1:n
            for j=1:n
                if i==j
                    %initialize the elements of the diag
                    A(i,j)=1+i^1;
                else
                    %initialize the other elemnts of matrix A
                    A(i,j)=1/abs(i-j)^2;
                end
            end
        end
    elseif strcmp(mx_id,'wathen')
        A=gallery('wathen',n,n-1);
    elseif strcmp(mx_id,'CollegeMSG')
        % n is not needed
         load('CollegeMsg.mat');
         A=Problem.A;
    else
        disp("wrong input");
        A=[];
         
    end
