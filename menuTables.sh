#!/bin/bash
echo "Please Select one of these options"
select choice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable
do 
	case $choice in
		CreateTable ) 
			;;
	        ListTables ) 
                       ls 
			;; 
		DropTables )
			;;
		InsertTntoTable ) 
			;; 
		SelectFromTable ) 
			;;
		DeleteFromTable ) 
			;;
		UpdateTable ) 
			;;
	        *) exit ;;
		esac 
done

