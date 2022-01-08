#!/bin/bash
dropTable() {
	echo -e "-----------------------------------------------"
	echo    "-----------------Drop Table--------------------"
	echo -e "-----------------------------------------------"
	echo Enter The Name of the Table You Wanna Delete
	read name
	if [[ -f $name ]] ; then
        	rm $name
        	echo $name Deleted Successfully
	else
        	echo $name not found
	fi

}



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
        select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select From Table" "Delete From Table" "Update Table" "Exit"
 	do
        	case $choice in
                	"Create Table" )
				touch file
                        	;;
                	"List Tables" )
                       		ls
                        	;;
                	"Drop Table" )
			        dropTable
				;;
                	"Insert into Table" )
                        	;;
                	"Select From Table" )
                        	;;
                	"Delete From Table" )
                        	;;
                	"Update Table" )
                        	;;
			"Exit" )
				exit ;;

                	*) echo "Enter A valid Number";;
                esac
	done

else 
	echo $name is not found
fi 

