%---------------------------------------------------->
function [yn] = my_quantizer(y, N, min_value,max_value)

	M = 2^N;
	Delta = (max_value-min_value)/M;
	centers=max_value-Delta/2-Delta*((1:M)-1);

	%perioxi ektos oriwn
	y1=(y<=min_value)*(min_value+Delta/2)+(y>=max_value)*(max_value-Delta/2);

	%perioxi entos oriwn
	y2=(y>min_value & y<max_value).*y;

	% to sima mesa sta oria diamorfomeno
	y=y1+y2;

	%kvanda
	Q=floor((max_value-y)/Delta)+1;
	%times apo ta kvanta
	yn=centers(Q);
end

%--------------------------------------------->

