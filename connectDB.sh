#!/bin/bash
echo Enter The name of the DataBase You Wanna Connect 
read name 
if [[ -d DataBases/$name ]] ; 
then 
	echo "You are connected to $name Successfully"
       	./menuTables.sh
	cd DataBases/$name
        ls
else 
	echo $name is not found
fi 	
