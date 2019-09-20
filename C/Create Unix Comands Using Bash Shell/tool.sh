#!/bin/bash


# ./tool.sh
if [ -z "$*" ]; then

	echo "1046077"
fi




#A ./tool.sh -f <file>
if [ -r $2 ] && [ -z "$3" ] && [ "-f" = "$1" ]; then

	#grep to chech if our lne begins winth # and pass the output to awk (i do this for every comand)
        grep -v '^#' $2 | awk -F "|" '{ print $0 }'	

fi 




#B
# ./tool.sh -f <file> -id <id>
if  [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "-id" ]; then

		#PASS ARGUMENT $4(id) to awk to find it in our file so we use variable idi
		idi=$4
	grep -v '^#' $2 | awk -v var=$idi -F "|" '{ if (var==$1) print $3" "$2" "$5 }' 

# ./tool.sh -id <id> -f <file>
elif [ "$1" == "-id" ] && [ "$3" == "-f" ] && [ -r $4 ]; then 

		#pass argument $2(id input) to awk to find it in our file so we use idi variable
		idi=$2
	grep -v '^#' $4	| awk -v var=$idi -F "|" '{ if(var==$1) print $3" "$2" "$5 }' 

fi




#C
# ./tool.sh --firstnames -f <file>
if [ "$1" == "--firstnames" ] && [ "$2" == "-f" ] && [ -r $3 ]; then

	#pass awk output to sort function to modify my output in alphabetical order
	grep -v '^#' $3 | awk -F "|" '{ print $3 }' | sort | uniq
# ./tool.sh -f <file> --firstnames
elif [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--firstnames" ]; then

	#pass awk output to sort to modify it 
	grep -v '^#' $2 | awk -F "|" '{ print $3 }' | sort | uniq
fi




#D
# ./tool.sh --lastnames -f <file>
if [ "$1" == "--lastnames" ] && [ "$2" == "-f" ] && [ -r $3 ]; then

	 #pass wak output to sort to modify my output lastnames
	grep -v '^#' $3 | awk -F "|" '{ print $2 }' | sort | uniq
# ./tool.sh -f <file> --lastnames
elif [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--lastnames" ]; then

	#pass awk output to sort to modify my output lastnames
	grep -v '^#' $2 | awk -F "|" '{ print $2 }' | sort | uniq
fi




#E
# ./tool.sh --born-since <date1> --born-until <date2> -f <file>
if [ "$1" == "--born-since" ] && [ "$3" == "--born-until" ] && [ "$5" == "-f" ] && [ -r $6 ]; then

	#make these to variables to pass the arguments to awk then we use them to the if statemant to check if the date is between the limits and we print  
        sinced=$2
	untild=$4
        grep -v '^#' $6 | awk -v sincedate=$sinced -v untildate=$untild -F "|" '{ if($5>=sincedate && $5<=untildate) print $0 }'
# ./tool.sh --born-since <date1> -f <file> --born-until <date2> 
elif [ "$1" == "--born-since" ] && [ "-f" == "$3" ] && [ -r $4 ] && [ "$5" == "--born-until" ]; then

	sinced=$2
	untild=$6
	grep -v '^#' $4 | awk -v sincedate=$sinced -v untildate=$untild -F "|" '{ if($5>=sincedate && $5<=untildate) print $0 }'
# ./tool.sh --born-until <date1> --born-since <date2> -f <file>
elif [ "$1" == "--born-until" ] && [ "$3" == "--born-since" ] && [ "$5" == "-f" ] && [ -r $6 ]; then 

	sinced=$4
	untild=$2
	grep -v '^#' $6 | awk -v sincedate=$sinced -v untildate=$untild -F "|" '{ if($5>=sincedate && $5<=untildate) print $0 }'
# ./tool.sh --born-until <date1> -f <file> --born-since <date2>
elif [ "$1" == "--born-until" ] && [ "$3" == "-f" ] && [ -r $4 ] && [ "$5" == "--born-since" ]; then

	sinced=$6
	untild=$2
	grep -v '^#' $4 | awk -v sincedate=$sinced -v untildate=$untild -F "|" '{ if($5>=sincedate && $5<=untildate) print $0 }'
# ./tool.sh -f <file> --born-since <date1> --born-until <date2>
elif [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--born-since" ] && [ "$5" == "--born-until" ]; then

	sinced=$4
	untild=$6
	grep -v '^#' $2 | awk -v sincedate=$sinced -v untildate=$untild -F "|" '{ if($5>=sincedate && $5<=untildate) print $0 }'
# ./tool.sh -f <file> --born-until <date1> --born-since <date2>
elif [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--born-until" ] && [ "$5" == "--born-since" ]; then

	sinced=$6
	untild=$4
	grep -v '^#' $2 | awk -v sincedate=$sinced -v untildate=$untild -F "|" '{ if($5>=sincedate && $5<=untildate) print $0 }'
# ./tool.sh -f <file> --born-since <date>
elif [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--born-since" ]; then

	#now we dont need the until variable
	sinced=$4
	grep -v '^#' $2 | awk -v sincedate=$sinced -F "|" '{ if($5>=sincedate) print $0 }'
# ./tool.sh --born-since <date> -f <file>
elif [ "$1" == "--born-since" ] && [ "$3" == "-f" ] && [ -r $4 ]; then 

	sinced=$2
	grep -v '^#' $4 | awk -v sincedate=$sinced -F "|" '{ if($5>=sincedate) print $0 }'
# ./tool.sh -f <file> --born-until <date>
elif [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--born-until" ]; then

	#now we domt need the since var
	untild=$4
	grep -v '^#' $2 | awk -v untildate=$untild -F "|" '{ if($5<=untildate) print $0 }'
# ./tool.sh --born-until <date> -f <file>
elif [ "$1" == "--born-until" ] && [ "$3" == "-f" ] && [ -r $4 ]; then

	untild=$2
	grep -v '^#' $4 | awk -v untildate=$untild -F "|" '{ if($5<=untildate) print $0 }'
fi




# ./tool.sh -f <file> --browsers
if [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--browsers" ]; then

	grep -v '^#' $2 | awk -F "|" '{ print $8 }' | sort | uniq -c | sed -r 's/\s+//' | awk '{ print $2" "$1 }' | sed 's/  / /'
# ./tool.sh -f <file> --browsers
elif [ "$1" == "--browsers" ] && [ "$2" == "-f" ] && [ -r $3 ]; then 

        grep -v '^#' $3 | awk -F "|" '{ print $8 }' | sort | uniq -c | sed 's/^     //' | awk '{ print $2" "$1 }' | sed 's/  / /'

fi




if [ "$1" == "-f" ] && [ -r $2 ] && [ "$3" == "--edit" ]; then 

	newval=$6
        column=$5
	idi=$4
        grep -v '^#' $2 | awk -v myidi=$idi -v mycolumn=$column -v mynewval=$newval -F "|" 
          	'{ if(myidi==$1){
	print "a"
		    for(i=2;i<=NF; i++){
			
			if(mycolumn=="lastName"||mycolumn=="firstName"||mycolumn=="gender"||mycolumn=="birthday"||mycolumn=="joinDate"||mycolumn=="IP"||mycolumn=="browser")
	                 {     $i=mynewval
			echo $i
			}
	            }
                } }'        
#echo "$myout" > $2
fi
