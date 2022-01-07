#!/bin/bash
select choice in CreateDataBase ListDataBases ConnectToDataBases DropDataBase
do 
	case $choice in
		CreateDataBase )
		 	./createDB.sh
			;;
		ListDataBases )
		    	ls DataBases
			;;
		ConnectToDataBases )
			./connectDB.sh
			;;
		DropDataBase )
                        ./dropDB.sh
			;;
		* ) 
			exit
			;;
	esac
done
