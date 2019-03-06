#!/bin/bash
#########################################################
User="sewerrat"
ip_address_location="IP:LOCATION"
file_name=$(date +%Y-%m-%d)
directory_to_bkp=$1
#########################################################

make_tar(){
tar -cvzf bkp."$file_name".tar.gz "$directory_to_bkp" | (pv -p --timer --rate --bytes >"$file_name".tar.gz)
#tar -cvzf bkp."$file_name".tar.gz "$directory_to_bkp"
# tar -czf - ./Downloads/ | (pv -p --timer --rate --bytes > backup.tgz)

scp_tar
}

scp_tar(){




echo "scooping file"

	scp bkp."$file_name".tar.gz "$User"@"$ip_address_location"

echo "scooping to server done"

delete_tar
}




delete_tar(){

echo "deleting local file"

	rm bkp.$file_name.tar.gz
	rm $file_name.tar.gz
echo "deleting local file done"

echo "Completed backup"
}


if [ $# -eq 0 ]
  then
    echo "No specific directory, aborting"
  else
   #echo $1
    make_tar

fi

