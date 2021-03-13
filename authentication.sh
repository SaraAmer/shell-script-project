#add authentication for a specific vertiual host
#delete authentication from a specific vertiual host
function addAuthentication {
	 read -p "Enter The name of the virtual Host you want to add authentication on :" SITENAME
	 checkVertiualHostExists ${SITENAME}
	 local OUTPUT=$(echo ${?})
	 if [ ${OUTPUT} -eq 0 ]  #exist
	 then
     checkIfSiteHasAuthentication ${SITENAME}
     if [ ${?} -eq 0 ]
     	then
     	echo "------------------------------------------"	
     	echo "This Site already has Authentication on "
     	echo "------------------------------------------"
     	else		

    authenticationUserOption
     sudo sed -i 's/AllowOverride None/AllowOverride All/g' /etc/apache2/apache2.conf
     sudo cp defaultauthentication /var/www/${SITENAME}.com/public_html/.htaccess
      echo "The authentication on ${SITENAME} added successfully"

      fi   
	 else
	 	echo "--------------------------------------------------"
	 	echo "The virtual host is not Avilable in your Machine"
	 	echo "----------------------------------------------------"
	 fi
}
#------------------------------delete authentication---------------------------------------------------
function deleteAuthentication {
   	 read -p "Enter The name of the virtual Host you want to add authentication off :" SITENAME
	 checkVertiualHostExists ${SITENAME}	
	 local OUTPUT=$(echo ${?})
	 if [ ${OUTPUT} -eq 0 ]  #exist
	 then
	 	checkIfSiteHasAuthentication ${SITENAME}
	 	  if [ ${?} -eq 0 ]
        then
         sudo rm /var/www/${SITENAME}.com/public_html/.htaccess
         echo "The authentication on ${SITENAME} deleted successfully"
     else   
            echo "------------------------------------------"
     		echo "This Site already has Authentication off"
     		echo "-------------------------------------------"
     	fi

	  else
	  	echo "-----------------------------------------------------"
	 	echo "The virtual host is not Avilable in your Machine"
	 	echo "-----------------------------------------------------"
	 fi
}

#-----------------------------------------add new user to authentication---------------------------------------------------------------------

function userMenue {
	echo "-------------------------------------------------------------------------------"
	echo "1- Add New Use"
	echo "2-use old user"
	echo "-------------------------------------------------------------------------------"
}

function authenticationUserOption {
	 
     checkIfhtpassisexist
     if [ ${?} -eq 0 ] #passfile already exists
     then
         userMenue
     echo "Enter Your Choice"
    read choice
    case ${choice} in
             

    "1")   read -p "Enter The user name :" USERName 
           sudo htpasswd /etc/apache2/.htpasswd ${USERName}  
              ;;
     "2");;
                  
      esac

     else
     sudo apt-get update 
     sudo apt-get install apache2 apache2-utils 
     	read -p "Enter The user name :" USERName
     sudo htpasswd -c /etc/apache2/.htpasswd ${USERName}
     fi

}

   
     	
     
     	 
