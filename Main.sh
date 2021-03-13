#!/bin/bash
source Menu.sh
source ApacheControl.sh
source validation.sh
source VertiualHostAdmin.sh
source authentication.sh 
echo "-----------------------Note------------------------------------------------------"
echo "Most of the options in this Script Need to Run by the root or user in sudo group "
echo "----------------------------------------------------------------------------------"

checkIfRootOrInSudoGroup
if [ ${?} -eq 0 ]
then 
	mainMenuActions
	 
else	
     echo "You are not a root or in the sudo group"
	exit 1
fi