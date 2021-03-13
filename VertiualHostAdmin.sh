#check if Apache2 installed
#if not installed echo to the user it's not installed and ask if he want to install 
#add new virtual host
#deleted vertiual host check if it exists
#disable virtual host
#enable virtual host
function addVertiualHost {
read -p "Enter The domain name :" SITENAME
checkVertiualHostExists ${SITENAME}
if [ ${?} -eq 0 ]
then
echo "--------------------------------------------------------"	
echo "the Sitename is already exists please try Another one"
echo "---------------------------------------------------------"
addVertiualHost
else	
sudo mkdir -p /var/www/${SITENAME}.com/public_html
sudo chown -R $USER:$USER /var/www/${SITENAME}.com/public_html
sudo chmod -R 755 /var/www
echo "<html><head><title>Welcome to ${SITENAME}</title></head><body><h1>Success ${SITENAME} Home Page </h1></body></html>" >> /var/www/${SITENAME}.com/public_html/index.html
sudo cp defaultconf.conf /etc/apache2/sites-available/${SITENAME}.conf
sudo sed -i "s/sitename/${SITENAME}/g" /etc/apache2/sites-available/${SITENAME}.conf
sudo sed -i "/^#/i 127.0.1.1       ${SITENAME}.com" /etc/hosts
sudo a2ensite ${SITENAME}.conf
sudo service apache2 reload
echo "---------------------------------------------------------------"
echo "you can use http://${SITENAME}.com to test your virtual host"
echo "----------------------------------------------------------------"
fi
}

function deleteVirtualHost {
     
	          listAllAvialabeVirtualHost
	
	 read -p "Enter The name of the virtual Host you want to deleted :" SITENAME
	 checkVertiualHostExists ${SITENAME}
	 local OUTPUT=$(echo ${?})
	 if [ ${OUTPUT} -eq 0 ]
	 then
	     sudo rm /etc/apache2/sites-available/${SITENAME}.conf >/dev/null 2>&1
	 	 sudo rm -Rf /var/www/${SITENAME}.com >/dev/null 2>&1
	 	 sudo sed -i "/${SITENAME}.com/d" /etc/hosts
     echo "--------------------------------------------------"
     echo "Deleted Successfully " 
     echo "---------------------------------------------------"
 else 
 	echo "---------------------------------------------------"
 	echo "The virtual host is not Avilable in your machine"
 	echo "----------------------------------------------------"
 
 fi
}


function enableVirtualHost {

	          listAllAvialabeVirtualHost
 	
 read -p "Enter The name of the virtual Host you want to enable :" SITENAME
	 checkVertiualHostExists ${SITENAME}
	 local OUTPUT=$(echo ${?})
	 if [ ${OUTPUT} -eq 0 ]
	 then
	 	sudo a2ensite ${SITENAME}.conf
	 	sudo service apache2 reload
	 else
	 	echo "-----------------------------------------------------"
	 	echo "The virtual host is not Avilable in your machine"
	 	echo "-----------------------------------------------------"
	 	
	 fi
}

function disableVirtualHost {
	 
	          listAllAvialabeVirtualHost
	
	read -p "Enter The name of the virtual Host you want to disable :" SITENAME
	 checkVertiualHostExists ${SITENAME}
	 local OUTPUT=$(echo ${?})
	 if [ ${OUTPUT} -eq 0 ]
	 then
	 	sudo a2dissite ${SITENAME}.conf
	 	sudo service apache2 reload
	 else
	 	echo "-----------------------------------------------------"
	 	echo "The virtual host is not Avilable in your machine"
	 	echo "-----------------------------------------------------"
	 	
	 fi
	
}

function listAllEnabledVirtualHost {
	apache2ctl -S
}

function listAllAvialabeVirtualHost {
	echo "------------------------Avilable virtual hosts-----------------------------"
	  ls /etc/apache2/sites-available/ | awk 'BEGIN{FS="."}NF{NF--};1'
	  echo "-------------------------------------------------------------------------"
}

