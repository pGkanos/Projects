%interate over p from 4 to 8
for p=4:8
%for each p call mydpcm for N=1,2,3
    for N=1:3
      [Sout,d,a]=mydpcm(x,p,N);
      %calculate Mean Squared Error for each N
      %save them to err array
      err(N)=immse(x,Sout.');
    end
    %create the plot for the err array for each p
    plot(err);
    hold on;
end
hold off;