#!/bin/bash 
echo Enter the name of the database you wanna see tables
read name 
if [[ -d $name ]] 
	cd DataBases/$name
        echo List Of Tables 
	ls 
else 
	echo $name is not found 
fi 
