#!/bin/bash
echo enter name of the datebase
read name
if [[ -d DataBases/$name ]]; then
	echo $name already Exists
else
	mkdir DataBases/$name
        echo Database created successfully
fi
