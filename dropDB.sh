#!/bin/bash
echo "Please , Enter the name of the data base you wanna delete"
read name
if [[ -d DataBases/$name ]]; 
then 
	rm -R DataBases/$name
	echo $name "has been deleted"	
        echo "-----------------------------------"
else
	echo $name "is not found"
	echo "-----------------------------------"
fi
