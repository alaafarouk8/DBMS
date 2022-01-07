#!/bin/bash
echo here is database
ls DataBases
echo enter the name of the data base you wanna delete
read name
if [[ -d DataBases/$name ]]; 
then 
	rm -d DataBases/$name
       echo database has been deleted	
else
	echo database is not found
fi
