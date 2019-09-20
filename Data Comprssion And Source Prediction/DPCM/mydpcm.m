function [Sout,diafores,a]=mydpcm(y,p,N)

	Lb=length(y);

	%ypologismos syntelestwn filtrou
	for i=1:p
		s=sum(y((p+1:Lb-1)+1).*y((p+1:Lb-1)+1-i));
		r(i)=s/(Lb-p);
	end

	for i=1:p
		for j=1:p
			s=sum(y((p+1:Lb-1)-i).*y((p+1:Lb-1)-j));
			R(i,j)=s/(Lb-p);
		end
	end
	a=R\r';
	
	%kvantisi syntelestwn
	anew=my_quantizer(a,8,-2,2);
	disp(anew);
	%ta prota p simeia ta pername apo kvatnsimo kai vazoume tis times sti
	%mnimi
	memory=my_quantizer(y(1:p),N,-3.5,3.5);
	%oi arxikes diafores einai 0
	diafores(1:p)=0;
	%arxiki exodo oi protes times
	%pou theorountai idies ston dekti
	Sout(1:p)=memory;
	for i=p+1:Lb
		%pernoume tin provlepsi
		yp=sum(anew.*memory);
		%diafora me provlepsi sto poso
		diafores(i)=y(i)-yp;
		%kvantismos tis diaforas
		ynd=my_quantizer(diafores(i),N,-3,3);
		%provlepsi ston pompo
		yp2=sum(anew.*memory);
		%allagi tis mnimis
		memory(2:p)=memory(1:p-1);
		memory(1)=yp2+ynd;
		Sout(i)=yp+ynd;
    end
    
    
end





