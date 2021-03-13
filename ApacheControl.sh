#check if the apache installed
#install apache2
#uninstall apache2

function installWebserver {
checkWebServer 
local OUTPUT=$(echo ${?})
echo ${OUTPUT}
if [ ${OUTPUT} -eq 1 ]
then
sudo apt install apache2
echo "--------------------------------"
echo "Apache2 installed successfuly"
echo "---------------------------------"
else
	echo "-----------------------------------------------------"
    echo "Apache2 is already installed  in your machine"
    echo "-----------------------------------------------------"
fi
}

function uninstallWebServer {
checkWebServer
if [ ${?} -eq 0 ]
then
read -p "Are You sure You want to uninstall apache2[n/y]:" ANSWER
case ${ANSWER} in
"y")
       sudo service apache2 stop
       sudo apt purge apache2
       sudo autoremove
       echo "-----------------------------------------------------"
       echo "Apache2 has been uninstalled successfully"
       echo "-----------------------------------------------------"
         ;;
"n")      ;;

*)          echo "INVALIED CHOICE"
            uninstallWebServer
            ;;
esac
else 
	echo "-----------------------------------------------------"
	echo "Apache2 is Not installed in your Machine"
	echo "-----------------------------------------------------"
fi
}
