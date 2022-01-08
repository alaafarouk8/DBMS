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
createTable() {
echo -e "-----------------------------------------------"
echo    "--------------- Craete Table ------------------"
echo -e "-----------------------------------------------"
echo "Enter Table Name" 
read tableName
if [[ $tableName != +([a-zA-Z]*[a-zA-Z0-9_]) ]];
then 
	echo "Table Name Cant Contain Numbers or Special chars"
	createTable
elif [[ $tableName == *" "* ]];
then	
	echo "Table Name Cant Contain Space"
	createTable 
else 
	if [[ -f $tableName ]] ;
	then 
		echo $tableName Already Exits
		createTable
	else 
		touch $tableName
		echo $tableName Created Successfully
		echo "Please, Enter The Number of Columns"
		read NumberCol
		for (( i = 1 ; i <= NumberCol ; i++ ));
		do 
			echo "Enter Name of the Column $i"
			read ColName
			echo "Enter DataType of the Column $ColName"
			read ColDataType
			while [[ $ColDataType != int && $ColDataType != string ]];
			do
				echo "Wrong DataType, Please Enter Int Or String"
				read ColDataType
			done
	      		echo $ColName":" >> $tableName 
	        	echo $ColDataType":"  >> $tableName
 		done
	fi
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
				createTable
                        	;;
                	"List Tables" )
				echo "------------------------------"
				echo "-------------Tables-----------"
				echo "------------------------------"
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

