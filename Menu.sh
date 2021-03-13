#display main menu with different options
#check if apache2 installed
#if installed the user can got to virtual hosts menu by click 3
function displayMainMenu
{
echo "-----------------Main Manu-------------------------------------------"	
echo "1-install apache2 web service"
echo "2-uninstall apache2 web service"
echo "3-virtual Host Adminstarte"
echo "4-quit"
echo "---------------------------------------------------------------------"
}


function displayVirtualHostMenu {
echo "----------------------------virtual Host Menu------------------------"	
echo "1-add vertiual host"
echo "2-delete vertiual host"
echo "3-enable vertiual host"
echo "4-disable vertiual host"
echo "5-list enabled virtual hosts"
echo "6-list all virtual hosts"
echo "7-Add Authentication"
echo "8-delete Authentication"
echo "9-back to Main Menue"
echo "10-quit"
echo "---------------------------------------------------------------------"
}

#-------------------------------------Virtual Main Menu Actions ---------------------------------------------------------------------#
function mainMenuActions
{
local choice
local FLAG=1
while [ ${FLAG} -eq 1 ]
do
	displayMainMenu
echo "Enter Your Choice"
read choice
case ${choice} in

"1")
      installWebserver ;;
"2")
      uninstallWebServer ;;
      
"3")   checkWebServer
       if [ ${?} -eq 0 ]
       then 
       virtualHostMenueAction
       else
       	echo "-----------------------------------------------------"
       	echo "You need to install apache2 first"
       	echo "-----------------------------------------------------"
       	mainMenuActions
       fi ;;
       
"4")   FLAG=0  exit 0 ;;
 *)
      echo "Invalid Choice";;
esac
       
done
}

#-------------------------------------Virtual host Menu Actions ---------------------------------------------------------------------#
function virtualHostMenueAction {
local choice
local FLAG=1
while [ ${FLAG} -eq 1 ]
do
	displayVirtualHostMenu
echo "Enter Your Choice"
read choice
case ${choice} in

"1") 
     addVertiualHost ;;
     
"2")
      deleteVirtualHost ;;
"3")  enableVirtualHost;;
        
"4") disableVirtualHost;;  

"5") listAllEnabledVirtualHost;;
    
"6")  listAllAvialabeVirtualHost;; 
       
"7")  addAuthentication;;
            

"8")  deleteAuthentication;;

"9") mainMenuActions ;;
                      
"10")    FLAG=0 
         exit 0 ;;
 *)
      echo "Invalid Choice";;
esac
       
done	

}