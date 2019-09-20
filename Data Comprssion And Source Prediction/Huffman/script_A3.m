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
%count number of each letter included in the "kwords.txt"(only the remaining a-z)
%calculate the probabilities 
temp=C{1,1};
temp=temp.';
sym={"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"};
num_of_each_sym=zeros(1,length(sym));
p=zeros(1,length(sym));
for j=1:length(sym)
    num_of_each_sym(j)=length(strfind(temp,sym{j}));
    p(j)=num_of_each_sym(j)/length(temp);
end
p(1)=p(1)+0.0001;

%create dict - encode - decode the remaining symbols which are included to
%the dictionary 
dict=myhuffmandict1(sym,p)
sig=C{1,1};
enco=huffmanenco1(sig,dict);
deco=huffmandeco1(enco,dict);

