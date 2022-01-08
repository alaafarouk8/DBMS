#!/bin/bash
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


