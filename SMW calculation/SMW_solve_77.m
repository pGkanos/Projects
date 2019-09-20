function x=SMW_solve_77(A,b,M,P,Q,sdir)
    
    %initialize the starting diagonal matrix M and the matrix C
    M=diag(diag(A));
    C=A-M;
    
    %cheking the number of arguments and the content of sdir
    if isequal(nargin,5) || ~(strcmp(sdir,'rowwise') || strcmp(sdir,'colwise'))
        disp("k");
    elseif strcmp(sdir,'colwise')
        %we will use the columns of P ---> P=[C(:,1),C(:,2)...C(:,n)]
        P=C;
        %Q->Identical Matrix
        Q=eye(size(A));
        %calculate the first x0. xo=inv(M)*b
        x0=M\b;
        %calculate the first P. P_new=inv(M)*P
        P=M\P;
        %Interate through the size of A to calculate the new A0 every time
        %and calculate the new x0
        for i=1:size(A)-1
            A0=Q-(P(:,i)*Q(:,i)')/(1+Q(:,i)'*P(:,i));
            %nested for is used to calculate the new P elements (Blass-2)
            %insted of P=A0*P because that way Blass-3 was demanded
            %which means more operations
            for j=i+1:size(A)
            P(:,j)=A0*P(:,j);
            end
            x0=x0-(Q(:,i)'*x0)/(1+Q(:,i)'*P(:,i))*P(:,i);
        end
        %calculate the last x0 and pass it to the output
        %must be out of loops because of 'out of bounds' error 
        x0=x0-(Q(:,end)'*x0)/(1+Q(:,end)'*P(:,end))*P(:,end);
        x=x0;
        %rowwise
        %it's exactly the same as the colwise i just change the contents of
        %P and Q and used the as before because Q is identical so P*Q = Q*P
    elseif strcmp(sdir,'rowwise')
        P=eye(size(A));
        Id=eye(size(A));
        Q=C;
    
        x0=M\b;
        Q=M\Q;
        Q=Q';
               
        for i=1:size(A)-1
            A0=Id-(P(:,i)*Q(:,i)')/(1+Q(:,i)'*P(:,i));
            for j=i+1:size(A)
            P(:,j)=A0*P(:,j);
            end
            x0=x0-(Q(:,i)'*x0)/(1+Q(:,i)'*P(:,i))*P(:,i);
        end
        x=x0-(Q(:,end)'*x0)/(1+Q(:,end)'*P(:,end))*P(:,end);
	else
		x=(M+P*Q')\b;
   end
