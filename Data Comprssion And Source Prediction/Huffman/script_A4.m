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

dict=myhuffmandict1(new_sym,new_p);
nums=randsrc(1,5000,[(1:26*26); new_p]);
sig=new_sym(nums);
enco=huffmanenco1(sig,dict);
dec=huffmandeco1(enco,dict);



