%read the words from "kwords.txt" an save each letter to a cell array
fileID = fopen("kwords.txt",'r');
C = textscan(fileID,"%c");
fclose(fileID);
%use of unique allows to know every single letter of our file 
letters=unique(C{1,1});
%find the symbols which are not included to dictionary 
%when a is found then break cause the following letters are the symbols of
%dict
%symbols(',-,etc.) and Caps are greater than lowercase so unique put them
%in the first places of letters array
for k=1:length(letters)
    if strcmp(letters(k),"a")
        break
    else
        not_used_syms(k)=letters(k);
    end
end

i=1;
%delete all the symbols that are not in the dictionary 
while i<=length(C{1,1})
    for j=1:length(not_used_syms)
        if strcmp(C{1,1}(i),not_used_syms(j))
            C{1,1}(i)=[];
        end
    end
    i=i+1;
end


%initialise symbols and probabilities for the dictionary
sym={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};


k=1;
for i=1:length(sym)
    for j=1:length(sym)
        new_sym{k}(1)=strcat(sym{i}(1),sym{j}(1));
        k=k+1;
    end
end

i=1;
x=1;
while i<=length(C{1,1})
   sig{x}=strcat(C{1,1}(i),C{1,1}(i+1));
   temp(x)=sig{x}(1);
   x=x+1;
   i=i+2;
end

new_p=zeros(1,length(new_sym));


for j=1:length(new_sym)
    num_of_each_sym(j)=length(strfind(temp,new_sym{j}));
    new_p(j)=num_of_each_sym(j)/length(temp);
end

new_p(1)=new_p(1)+0.0004;
%create dict - encode - decode the remaining symbols which are included to
%the dictionary 
dict=myhuffmandict1(new_sym,new_p);
enco=huffmanenco1(sig,dict);
deco=huffmandeco1(enco,dict);


