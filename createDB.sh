#!/bin/bash
echo -e "-----------------------------------------------"
echo    "---------------Create DataBase-----------------"
echo -e "-----------------------------------------------"
echo Enter the Name of the DateBase
read name
if [[ -d DataBases/$name ]]; then
	echo $name already Exists
else
	mkdir DataBases/$name
        echo Database created successfully
fi
