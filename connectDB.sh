#!/bin/bash
dropTable() {
	echo -e "-----------------------------------------------"
	echo    "-----------------Drop Table--------------------"
	echo -e "-----------------------------------------------"
	echo Enter The Name of the Table You Wanna Delete
	read name
	if [[ -f $name ]] ; then
        	rm $name
		rm $name.type
		rm $name.meta
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
		echo "Please Enter Primary Key"
		read PK
		while [[ $PK != "PK" ]]
		do
			echo "Please,just write PK"
			read PK
		done
		echo -n $PK >> $tableName.meta
		for (( i = 1 ; i <= NumberCol ; i++ ));
		do 
			echo "Enter Name of the Column $i"
			read ColName
			while [[ $ColName == *" "* ]]
			do
				echo "Column Name Cant Contain Spaces"
				echo "Please , Enter Column Name Again"
				read ColName
			done
			echo "Enter DataType of the Column $ColName"
			read ColDataType
			while [[ $ColDataType != int && $ColDataType != string ]];
			do
				echo "Wrong DataType, Please Enter Int Or String"
				read ColDataType
			done
			
			if [[ i -eq NumberCol ]] ; then
	      			echo 	$ColName >> $tableName
			        echo    $ColDataType>> $tableName.type
 		        
			
			else 
				echo -n $ColName":" >> $tableName
				echo -n $ColDataType":" >> $tableName.type
			fi
                   done
		   echo "---------------------------------------------------"
                        echo "------------Table has been created-----------------"
                        echo "---------------------------------------------------"

	fi
fi
}

Insert() {
echo "----------------Insert Into Table---------------"
echo "------------------------------------------------"

echo "Please , Enter Table Name You wanna insert to: "
read tbName
if [[ -f $tbName ]]; then
 	typeset -i cntColumns=`awk -F: '{print NF}' $tbName | head -1` ; #get number of columns in table
	for (( i=1 ; i <= cntColumns ; i++ ));
	do
		colname=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName | head -1` ;
		coltype=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName.type | head -1` ; 
		 flag=0;
		 while [[ $flag -eq 0 ]]; do
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
		echo "Sorry $tbName Doesn't Exist";
		echo "-------------------------------------------------"
			
fi  
}
update() {
echo "----------------Update From Table---------------"
echo "------------------------------------------------"
echo "Please, Enter Table Name you wanna update"
read tbName 
if [[ -f $tbName ]] ; then 
       echo "---------------------------------------------------------------------"
       echo "-----------------------------$tbName---------------------------------"
       echo "----------------------------------------------------------------------"
       typeset -i cntColumns=`awk -F: '{print NF}' $tbName | head -1` ; #get number of columns in table
       echo "---------------------------------------------------------------------"
       echo "-------------Table Coloums Names And Their Data Types----------------"
       PK=`awk  '{print $1}' $tbName.meta | head -1` ;
       echo -n $PK "-"
       for (( i = 1 ; i<=cntColumns ; i++ ))
       do 
	       colname=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName | head -1` ;
               coltype=`awk -v"n=$i" 'BEGIN{FS=":"}{print $n}' $tbName.type | head -1` ;
	       if [[ $i == $cntColumns ]] ; then
	            echo   $colname "-" $coltype 
	       else 
		   echo -n $colname "-" $coltype "||"
	       fi
       done
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
                                if [[ $oldValue != "" && $newValue != "" ]]; then
				sed -i "s/$oldValue/$newValue/" $tbName
				fi
				 #gawk -v oldval=$oldValue -v newval=$newValue -v colnum=$colNum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $tbName ;
				 echo $tbName "Updated Successfully"
		                 flag=1
		         fi

               done
        else
		echo $oldValue not found
	fi
else 
	echo $tbName not found 
fi

}
selectfunction()
{
	echo "select function"
}
deleteRecord() {

       echo "---------------------------------------"
       echo "-----------Delete Record--------------"
       echo "Please, Enter the record you wanna delete"
       read rowNum 
       while ! [[ $rowNum =~ ^[2-9]+$ ]]
       do
	       echo "Enter int"
	       read rowNum
       done
       cntLines=$(cat $tbName | wc -l ) #counter number of lines in file
       echo  $tbName "Befero Delete"
       echo "---------------------------------------------------------------------------"

       column -t -s ':'   $tbName
       echo "---------------------------------------------------------------------------"

        if test $cntLines -gt 0
                then
                    if test $rowNum -gt $cntLines
                        then
                            echo "this Record is out of boundary"
                    else
                        sed -i "${rowNum}d" $tbName
                        echo "Record deleted successfuly"
			 echo  $tbName "After Delete"
       		       echo "---------------------------------------------------------------------------"

       		       column -t -s ':'   $tbName
		       echo "---------------------------------------------------------------------------"

                    fi

       else
                    echo Sorry $tbName is Empty
		    echo "------------------------------------"
	fi
}
delete() {
echo "----------------Delete From Table---------------"
echo "------------------------------------------------"
echo "Please, Enter Table Name you wanna Delete from:"
read tbName
if [[ -f $tbName ]] ; then

	echo "Please , Select one of these Options" 
	select choice in "Delete Record" "Delete AllRecords" "Back" "Exit"
        do
                case $choice in
                        "Delete Record" )
                                deleteRecord
                                ;;
                        "Delete AllRecords" )
                                echo "---------------------------------------"
       				echo "-----------Delete All Record-----------"
       				echo "---------------------------------------"
			        echo  $tbName "Befero Delete"
				echo "---------------------------------------------------------------------------"

				column -t -s ':'   $tbName  
		                echo "---------------------------------------------------------------------------"
		                sed -i '2,$ d' $tbName
                         	echo "Records deleted successfully!"
		                echo "$tbName After Delete"
				echo "---------------------------------------------------------------------------"
				column -t -s ':' $tbName 
                                echo "---------------------------------------------------------------------------"


                                ;;
                        "Back" )
                              ./connectDB.sh
                                ;;
                        "Exit" )
                                exit ;;

                        *) echo "Enter A valid Number";;
                esac
        done

else
       echo $tbName Doesnt Exits ;
       echo "-----------------------------------------------"       
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
                        	Insert
				;;
			"Select From Table" )
				selectfunction
				;;
			"Delete From Table" )
				delete
				;;
                	"Update Table" )
				update
                        	;;
			"Exit" )
				exit ;;

                	*) echo "Enter A valid Number";;
                esac
	done

else 
	echo Sorry $name Doesnt Exits
	echo "-----------------------------------------"
fi 

