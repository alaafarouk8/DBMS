#!/bin/bash
echo -e "-----------------------------------------------"
echo    "---------------Connect To DataBase-------------"
echo -e "-----------------------------------------------"
echo Enter The Name of the DataBase You Wanna Connect to 
read name 
if [[ -d DataBases/$name ]] ; 
then 
	echo "You are connected to $name Successfully"
       	cd DataBases/$name
	echo "Please Select one of these options"
        select choice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable Exit
 	do
        	case $choice in
                	CreateTable )
				createtable.sh
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
			Exit )
				exit ;;

                	*) echo Enter A valid Number
				;;
                	esac
done

else 
	echo $name is not found
fi 	
