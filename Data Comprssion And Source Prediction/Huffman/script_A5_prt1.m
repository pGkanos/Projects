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
p=[0.07529,0.01173,0.02463,0.03934,0.12045,0.01909,0.01696,0.05775,0.06328,0.00153,0.03553,0.03706,0.02087,0.0643,0.07188,0.0161,0.00095,0.05668,0.06008,0.08618,0.02439,0.00659,0.05051,0.0015,0.03659,0.00074];
new_p=zeros(1,length(p)*length(p));

k=1;
for i=1:length(sym)
    for j=1:length(sym)
        new_sym{k}(1)=strcat(sym{i}(1),sym{j}(1));
        new_p(k)=p(i)*p(j);
        k=k+1;
    end
end

i=1;
x=1;
while i<=length(C{1,1})
   sig{x}=strcat(C{1,1}(i),C{1,1}(i+1));
   x=x+1;
   i=i+2;
end

%create dict - encode - decode the remaining symbols which are included to
%the dictionary 
dict=myhuffmandict1(new_sym,new_p);
enco=huffmanenco1(sig,dict);
deco=huffmandeco1(enco,dict);


