function deco = huffmandeco1(comp, dict)
    i=1;
    k=0;
    
    %interate the comp with step i+length(temp)
    while i<=length(comp)
        
        %make each raw of the second col of cell array dict (binary code) to simple
        %array-->temp
        %compare temp with the i:i+length(temp)-1 of comp
        %if they are equal put the letter to the k position of the deco
        
        for j=1:length(dict)
            temp=cell2mat(dict(j,2));
            %check the limits of the array
            %we do this for the last interation because we will pass the
            %limit
            if i+length(temp)-1>length(comp)
                continue
            else
                en=i+length(temp)-1;
            end
            if isequal(comp(i:en),temp)
                 k=k+1;
                deco{k}=dict{j,1};
                i=i+length(temp);
                break
            end
        end
    end
end

