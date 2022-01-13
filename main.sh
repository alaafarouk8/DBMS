#!/bin/bash
# Color variables
export red="\033[1;31m"
export green="\033[1;32m"
export yellow="\033[1;33m"
export blue="\033[1;34m"
export purple="\033[1;35m"
export cyan="\033[1;36m"
export grey="\033[0;37m"
#clear the color after that
export clear="\033[m"
# create data base 
tput bold   #to make font bold
#*************************************************************************************#
#**************************function to create data base*******************************#

function createDB() {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "-----------------------Create DataBase----------------------------------"
echo  "------------------------------------------------------------------------"
echo Please ,Enter the Name of the DateBase
tput setaf 7
read dbName
if [[ ! -d DataBases ]] ; then 
	mkdir DataBases 
fi
if [[ -z $dbName ]] ;
then    tput setaf 1
        echo "Empty String"
        tput setaf 7
        createDB
elif [[ $dbName == *" "* ]] ;
then 
	tput setaf 1
	echo "Data Base Cant Contain Any Spaces"
	tput setaf 7
	createDB
elif [[ $dbName != +([a-zA-Z]*[a-zA-Z0-9_]) ]];
then
	tput setaf 1
        echo "Data Base Name Cant Contain Numbers or Special chars"
	tput setaf 7
	createDB
elif [[ -d DataBases/$dbName ]]; then
	tput setaf 1
        echo Database $dbNname already Exists
	tput setaf 7
	createDB
else
        mkdir DataBases/$dbName
	tput setaf 2
        echo Database was created successfully!
	echo  "------------------------------------------------------------------------"
	echo  "------------------------------------------------------------------------"
	tput setaf 7
	mainMenu
fi
}
#*************************************************************************************#
#**************************function to drop database**********************************#

function dropDB() {
	tput bold
	tput setaf 6
	echo    "------------------------------------------------------------------------"
	echo    "------------------------Delete DataBase---------------------------------"
	echo    "------------------------------------------------------------------------"
   if [ "$(ls -A DataBases)" ];
	then
	echo "Please , Enter the name of the data base you wanna delete"
	read name
	if [[ -z $name ]] ; then 
		tput setaf 1
		echo "Empty String"
		tput setaf 7
		dropDB
	fi
	if [[ -d DataBases/$name ]];
	then
        	rm -R DataBases/$name
		tput setaf 2
        	echo $name "Has been Deleted"   
	        mainMenu
	        echo "------------------------------------------------------------------------"
                tput setaf 7
	else
		tput setaf 1
        	echo $name "Is not Found"
		dropDB
                echo  "------------------------------------------------------------------------"

		tput setaf 7
         fi
     else 
	     tput setaf 3
	     echo "There are no Data bases to Delete"
	     echo  "------------------------------------------------------------------------"

	     tput setaf 7
    fi  	     

}
#*************************************************************************************#
#******************************function to create table*******************************#
createTable() {
tput setaf 6
echo    "------------------------------------------------------------------------"
echo    "--------------------------Create Table----------------------------------"
echo    "------------------------------------------------------------------------"
echo "Enter Table Name" 
read tableName
if [[ -z $tableName  ]];
then 
	tput setaf 1
	echo "Empty Input"
	createTable
elif [[ $tableName == *" "* ]];
then	
	tput setaf 1
	echo "Table Name Cant Contain Space"
	createTable 
elif [[  $tableName != +([a-zA-Z]*[a-zA-Z0-9_]) ]] ; then
	tput setaf 1
	echo "InCorrect Table Name"
	createTable
else 
	if [[ -f $tableName ]] ;
	then 
		tput setaf 1
		echo $tableName Table Already Exits
		createTable
	else    
		while true
		do
		tput setaf 6
		echo "Please,Enter Number of Columns: "
		read NumberCol
		if [[ $NumberCol =~ [^1-9] ]];
		then
                        tput setaf 1
			echo "Incorrect data, Input Should Be Number"
			tput setaf 7
		elif [[ -z $NumberCol ]] ;
		then   
			tput setaf 1
			echo "Empty Input"
                        tput setaf 7
		else
			break 
		fi
		done
		tput setaf 3
		echo "ATTENTION , First Column Must Be PRIMARY KEY !!"
		tput setaf 7
		for (( i = 1 ; i <= NumberCol ; i++ ));
		do      
			tput setaf 6
			while true
			do
				echo "Please, Column Name $i : "
				read ColName
				if [[  $ColName != +([a-zA-Z]*[a-zA-Z0-9_]) ]];
				then
					tput setaf 1
					echo "InCorrect Column Name"
				elif [[ $ColName == *" "* ]];
				then
					tput setaf 1
					echo "Column name cant contain any spaces"
				
				elif [[ -z $ColName ]] ;
				then
					tput setaf 1 
					echo "Empty Column Name"
		
				else 
					break ;
				fi
	        	done 
			tput setaf 6
			echo "Enter DataType of the Column $ColName"
			read ColDataType
			while [[ $ColDataType != int && $ColDataType != string ]];
			do      tput setaf 1
				echo "Wrong DataType, Please Enter Int Or String"
			
				read ColDataType
			done
			tput setaf 7
			touch $tableName
			touch $tableName.type
			if [[ i -eq NumberCol ]] ; then
	      		        echo 	$ColName >> $tableName
			        echo    $ColDataType>> $tableName.type


			else
				echo -n $ColName":" >> $tableName
				echo -n $ColDataType":" >> $tableName.type
			fi
			
		done

		        tput setaf 2
			echo "------------------------------------------------------------------------"
                        echo "-----------------------Table has been created---------------------------"
                        echo "------------------------------------------------------------------------"
                        tput setaf 7
	fi
fi
}
#*************************************************************************************#
#**************************function to drop tables************************************#

#function Drop Tables
function dropTable() {
tput setaf 6
echo    "------------------------------------------------------------------------"
echo    "----------------------------Drop Table----------------------------------"
echo    "------------------------------------------------------------------------"
echo "Please , Enter Table Name You Wanna Drop"
read tbName
if [[ -z $tbName ]] ; then
       	tput setaf 1
        echo "Empty String"
        tput setaf 7
        dropTable
fi
if [[ -f $tbName ]];
then
        rm $tbName
        rm $tbName.type
        tput setaf 2
	echo $tbName "Table Has been Deleted"
	echo "------------------------------------------------------------------------"
	tput setaf 7
else
	tput setaf 1
	echo $tbName " Table Is not Found"
	echo "------------------------------------------------------------------------"
	tput setaf 7
	dropTable
fi
}
#*************************************************************************************#
#**************************function to insert into table******************************#
function insert() {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "--------------------------Insert Into Table-----------------------------"           
echo  "------------------------------------------------------------------------"
echo Enter Table Name You Wanna insert Into 
read tbName
tput setaf 7
if [[ -f $tbName ]]; then
 	typeset -i cntColumns=`awk -F: '{print NF}' $tbName | head -1` ; #get number of columns in table
	tput setaf 3
        echo -n "ATTENTION FOR INSERTION," 
        tput setaf 1
        echo "PRIMARY KEY MUST BE UNIQUE" 
	for (( i=1 ; i <= $cntColumns ; i++ ));
	do
		colname=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName | head -1` ;
		coltype=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName.type | head -1` ; 
	        if [[ $i -eq 1 ]] ;
	         then
			check=0
			while [[ $check -eq 0 ]] ;
			do
			        tput setaf 6
                                echo "Enter Value for $colname Column: "
                                read value
			   if ! grep -q "$value" "$tbName";then
				   if [[ $coltype = "int" && "$value" = +([0-9]) || $coltype = "string" && "$value" = +([a-zA-Z]) ]]; then		
		   			   echo -n  $value":" >> $tbName;
				    fi
				   check=1
		            fi	
                       done                                 
	      fi
	      while [[ $flag -eq 0 && $i -gt 1 ]]; do
		        tput setaf 6 
		 	echo "Enter Value for $colname Column: "
		 	read value
			if [[ $coltype = "int" && "$value" = +([0-9]) || $coltype = "string" && "$value" = +([a-zA-Z]) ]]; then
			 		if [[ $i == $cntColumns ]]; then
			 			echo $value >> $tbName;
			 		else
			 			echo -n  $value":" >> $tbName;
			 		fi
			 	flag=1;
			 fi
		 done
	 done
else	        
	        tput setaf 1
		echo  "------------------------------------------------------------------------"
		echo "Sorry $tbName Doesn't Exist";
		echo "-------------------------------------------------------------------------"
		tput setaf 7 
fi  
}
#*************************************************************************************#
#**************************function to select from table******************************#
function select_function() {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "--------------------------Select From Table-----------------------------"           
echo  "------------------------------------------------------------------------"
echo Enter Table Name You Wanna Select from : 
read tbName
tput setaf 7
if [[ -f $tbName ]] ; then
        tput setaf 6
        echo "Please , Select one of these Options"
        select choice in "Select Record" "Select AllRecords" "Select Column"  "Exit"
        do
                case $choice in
                        "Select Record" )

                               echo "Enter a Search Value to Select Record"
			       read value
			       if [[ -z $value ]] ; then
				       tput setaf 1
				       echo "Empty Input"
				       select_function
				       tput setaf 7
			       else
				        echo "------------------------------------------------------------------------"
					tput setaf 2
					column -t -s ':' $tbName.type
			       	        awk -F':' "/$value/" $tbName | cat
                               		echo "------------------------------------------------------------------------"
			                tput setaf 7
			       fi
                                ;;
                        "Select AllRecords" )
				tput setaf 2
                                echo "------------------------------------------------------------------------"
				echo "------------------------Select All Records------------------------------"
                                echo "------------------------------------------------------------------------"
                                column -t -s ':' $tbName.type
				column -t -s ':' $tbName
                                echo "------------------------------------------------------------------------"
                                ;;
			"Select Column" )
			       tput setaf 6
			       echo "Enter Column Number you wanna select"
                               read value
                               while ! [[ $value =~ ^[1-9]+$ ]]
       			       do
				        tput setaf 1
               				echo "Column Number Must be Integer"
               				read value
			       done
			       tput setaf 2
			       cut -d':' -f$value $tbName
			       echo "----------------------------------------------------------------------------"
                               echo "----------------------------------------------------------------------------"
                               echo "----------------------------------------------------------------------------"
			       ;;
                        "Exit" )
                                exit ;;

                        *)     
				tput setaf 1 
			       	echo "Please, Enter valid Number"
				tput setaf 7
				;;
                esac
        done

else
       echo $tbName Table Doesnt Exits ;
       echo "----------------------------------------------------------------------------"
fi

}
#*************************************************************************************#
#**************************function to Update in table*******************************#
function updatetable() {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "--------------------------Update in Table-------------------------------"           
echo  "------------------------------------------------------------------------"
echo Enter Table Name You Wanna Select from : 
read tbName
if [[ -f $tbName ]] ; then
tput setaf 7
typeset -i cntColumns=`awk -F: '{print NF}' $tbName | head -1` ; #get number of columns in table
       tput setaf 2
       echo "------------------------------------------------------------------------"
       echo "------------------------------------------------------------------------"
       echo "--------------Table Coloums Names And Their Data Types------------------"
       column -t -s ':' $tbName.type
       column -t -s ':' $tbName
       tput setaf 6
       echo "Enter Column Number you wanna update in"
       read colNum
       while [[ $colNum -gt $cntColumns || $colNum -lt 1 && colNum != +([0-9]) ]] ;
       do
	      echo " Valid Number. Please , Enter Column Number Correctly"
	      read colNum
       done
       echo "Please the Old Value you wanna update"
       read oldValue
       if grep "${oldValue}" $tbName
       then
	       if [[ $oldValue =~ ^[0-9]+$ ]];
		then
              		oldValueDt="int"
       		 else
              		oldValueDt="string"
       		 fi
	       flag=0
	       while [[ $flag -eq 0 ]]; do
                        echo "Enter The New Value of $oldValue: "
                        read newValue
                         if [[ $newValue =~ ^[0-9]+$ ]];
			 then
              			newValueDt="int"
       			 else
              			newValueDt="string"
		         fi
			 if [[ $newValueDt != $oldValueDt ]] ;
			 then
				 echo "incorrect data type"
		         else
				if [[ colNum -eq 1 ]] ;
				then
					if ! grep -q "$newValue" "$tbName";then
 						if [[ $oldValue != "" && $newValue != "" ]]; then
							#awk '{gsub(/"$oldValue"/, "$newValue", $colNum)}1' $tbName
 							sed -i "s/$oldValue/$newValue/$colNum" $tbName
							flag=1
							echo $tbName "Updated Successfully"
							tput setaf 2
						       echo "------------------------------------------------------------------------"
    						       echo "------------------------------------------------------------------------"
       						       echo "--------------------------Table After Updating--------------------------"
       						       column -t -s ':' $tbName.type
       						       column -t -s ':' $tbName

						fi
					else 
						flag=0
					fi
				elif [[ colNum -gt 1 ]] ;
				then
					 sed -i "s/$oldValue/$newValue/g" $tbName
				 	 #gawk -v oldval=$oldValue -v newval=$newValue -v colnum=$colNum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $tbName ;
				 	echo $tbName "Updated Successfully"
	                				 echo "------------------------------------------------------------------------"
                                                       echo "------------------------------------------------------------------------"
                                                       echo "--------------------------Table After Updating--------------------------"
                                                       column -t -s ':' $tbName.type
                                                       column -t -s ':' $tbName

		                 	flag=1
				
				fi
			 fi
               done
        else
		tput setaf 1
		echo Sorry , $oldValue not found
		updatetable
        fi
else

	echo Sorry, $tbName Table not found
fi
}
#*************************************************************************************#
#**************************function to delete from************************************#

deleteRecord() {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "----------------------------Delete Record-------------------------------"           
echo  "------------------------------------------------------------------------"
echo "Please, Enter the record you wanna delete"
read rowNum 
while ! [[ $rowNum =~ ^[2-9]+$ ]] 
do
	       tput setaf 1
	       echo "Record number Should Be Integer"
	       read rowNum
done
       cntLines=$(cat $tbName | wc -l ) #counter number of lines in file
       tput setaf 2
       echo  $tbName "Befero Delete"
       echo  "------------------------------------------------------------------------"
       echo "-------------------------------------------------------------------------"
       column -t -s ':'  $tbName.type
       column -t -s ':'   $tbName
       echo "-------------------------------------------------------------------------"
        if test $cntLines -gt 0
                then
                    if test $rowNum -gt $cntLines
                        then
			    tput setaf 1
                            echo "this Record is out of boundary"
			    tput setaf 7
                    else
                        sed -i "${rowNum}d" $tbName
			tput setaf 2
                        echo "Record deleted successfuly"
		       echo  $tbName "After Delete"
		       echo  "------------------------------------------------------------------------"
       		       column -t -s ':' $tbName.type
		       column -t -s ':'   $tbName
		       echo  "-------------------------------------------------------------------------"
                   fi
       else
	            tput setaf 1
                    echo Sorry $tbName Table is Empty
		    echo  "------------------------------------------------------------------------"
		    tput setaf 7
	fi
}
delete() {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "----------------------------Delete Record-------------------------------"           
echo  "------------------------------------------------------------------------"
echo "Please, Enter Table Name you wanna Delete from:"
read tbName
if [[ -f $tbName ]] ; then

	echo "Please , Select one of these Options" 
	select choice in "Delete Record" "Delete AllRecords" "Exit"
        do
                case $choice in
                        "Delete Record" )
                                deleteRecord
                                ;;
                        "Delete AllRecords" )
				tput setaf 4
                                echo "------------------------------------------------------------------------"
       				echo "----------------------------Delete All Record---------------------------"
       				echo "------------------------------------------------------------------------"
			        echo  $tbName "Befero Delete"
                                column -t -s ':'   $tbName.type
				column -t -s ':'   $tbName  
		                echo "---------------------------------------------------------------------------"
		                sed -i '2,$ d' $tbName
				tput setaf 2
                         	echo "Records deleted successfully!"
		                echo "$tbName After Delete"
				column -t -s ':' $tbName.type
				column -t -s ':' $tbName 
                                echo "---------------------------------------------------------------------------"
                                ;;
                        "Exit" )
                                exit ;;

                        *)      tput setaf 1
			       	echo "Enter A valid Number"
				tput setaf 7
				;;

                esac
        done

else
       echo "------------------------------------------------------------------------"
       tput setaf 1
       echo Sorry $tbName Table Doesnt Exits ;
       echo "------------------------------------------------------------------------"       
fi

}
#*************************************************************************************#
#**************************function to connect to database****************************#

function connectDB {
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "--------------------------Connect Data Base-----------------------------"           
echo  "------------------------------------------------------------------------"
echo Enter The Name of the DataBase You Wanna Connect to 
read name
tput setaf 7
if [[ -d DataBases/$name ]] ;
then
        tput setaf 2
        echo "You are connected to $name Successfully"
        tput setaf 7
        cd DataBases/$name
        tput setaf 6
        echo "Please Select one of these options"
        select choice in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Update Table" "Delete From Table"  "Exit"
        do
                case $choice in
                        "Create Table" )
                                createTable
                                ;;
                        "List Tables" )
                                if [ -z "$(ls -A )" ]; then
                                	tput setaf 1
                                	echo "--------------------------There are no Tables---------------------------"
                                	tput setaf 7
                                else
                                	tput setaf 2
					echo "------------------------------------------------------------------------"
					echo "----------------------------------Our Tables----------------------------"
                                	echo "------------------------------------------------------------------------"
                                	ls 
                                	tput setaf 7

                        	fi
                                ;;
                        "Drop Table" )
                                dropTable
                                ;;
			"Insert Into Table" )
				insert
				;;
			"Select From Table" )
				select_function 
				;;
			"Update Table")
				updatetable 
				;;

			"Delete From Table")
				delete 
				;;
                        "Exit" )
                                exit ;;

                        *) echo "InValid Number";;
                esac
        done

else
        tput setaf 1
        echo Sorry , $name Doesnt Exits
	echo  "------------------------------------------------------------------------"
        echo  "------------------------------------------------------------------------"
	connectDB
	tput setaf 7


fi
}
#*************************************************************************************#
#***************************************our  main menu*******************************#

function mainMenu() {
tput bold 
tput setaf 6
echo  "------------------------------------------------------------------------"
echo  "----------------------Welcome To Our DBMS-------------------------------"           
echo  "------------------------------------------------------------------------"
        
select choice in "Create DataBase" "List DataBases" "Connect To DataBases" "Drop DataBase" "Exit"
do 
	case $choice in
		"Create DataBase" )
		 	createDB
			;;
		"List DataBases" )
			if [ -z "$(ls -A DataBases)" ]; then
				tput setaf 1
   				echo    "----------------------There are no Data Bases--------------------------"
				tput setaf 7
				mainMenu
			else 
				tput setaf 2
   				echo    "-----------------------------------------------------------------------"
                                echo    "--------------------------Our Data Base--------------------------------"
                                echo    "-----------------------------------------------------------------------"
				ls DataBases
				mainMenu
				tput setaf 7

			fi
			;;
		"Connect To DataBases" )
		        connectDB
			;;
		"Drop DataBase" )
                         dropDB
			;;
		"Exit" ) 
			tput setaf 3
			echo  "------------------------------------------------------------------------"
	                echo  "------------------------------------------------------------------------"
			echo  "-------------------------------Thank You--------------------------------"           
			echo  "------------------------------------------------------------------------"
			echo  "------------------------------------------------------------------------"
		        exit
			tput setaf 7
			;;
		*) 
			tput setaf 1
			echo "InValid Number note -> valid numbers from 1 to 5" 
			tput setaf 7
			;;
	esac
done
}


mainMenu 
