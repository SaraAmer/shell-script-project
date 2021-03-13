#0 the apache is not installed in the machine
#1 the apache is installed in this machine 
function checkWebServer {
sudo service apache2 restart >/dev/null 2>&1
if [ ${?} -eq 0 ]  
then
     return 0; #already exist
else
     return 1
fi
}
#0 the virstual host exists
#1 the virtual host is not exist

function checkVertiualHostExists {
local VIRTUAL=${1}
local FILE=/etc/apache2/sites-available/${VIRTUAL}.conf
if [[ -f $FILE ]]  
then
	return 0
else
return 1
fi	
}
function checkIfSiteHasAuthentication {
	local VIRTUAL=${1}
local FILE=/var/www/${VIRTUAL}.com/public_html/.htaccess
if [[ -f $FILE ]]  
then
	return 0
else
return 1
fi
}
#0 the .httpasswd exists
#1 the .httasswd is not exist

function checkIfhtpassisexist {
	local HTPASS=/etc/apache2/.htpasswd
	if [[ -f $HTPASS ]]  
then
	
	return 0
else
	
    return 1
fi	
}

function checkIfRootOrInSudoGroup {

	sudo -l -U ${USER} >/dev/null 2>&1
	if [ ${?} -eq 0 ]
	then 
	   return 0 
	else
	     return 1	
	 fi    
}