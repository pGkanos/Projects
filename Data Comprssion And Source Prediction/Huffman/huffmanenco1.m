function x=huffmanenco1(signal,dict)
    
    s=string(signal);
    %d=string(dict);
    count=0;
    for i=1:length(signal)
        for j=1:length(dict)
            for k=1:length(dict{j,2})
                if strcmp(s{i},dict{j,1})
                    count=count+1;
                    x(count)=dict{j,2}(1,k);
                end
            end
        end
    end
                              
end

