#!/bin/bash
echo -e "-------------------------------------"
echo    "-------- Welcome To Our DBMS---------"           
echo -e "-------------------------------------"
select choice in "Create DataBase" "List DataBases" "Connect To DataBases" "Drop DataBase" "Exit"
do 
	case $choice in
		"Create DataBase" )
		 	./createDB.sh
			;;
		"List DataBases" )
		    	ls DataBases
			;;
		"Connect To DataBases" )
		       source ./connectDB.sh
			;;
		"Drop DataBase" )
                        ./dropDB.sh
			;;
		"Exit" ) 
			echo -e "-------------------------------------"
			echo    "-------------Thank You---------------"           
			echo -e "-------------------------------------"
		        exit
			;;
		*) 
			echo "Enter Valid Number" 
			;;
	esac
done
