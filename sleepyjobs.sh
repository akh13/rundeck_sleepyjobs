#!/bin/bash

### Rundeck token. Make this with your admin-enabled user in the user panel.

TOKEN="2VZVIasdiOUdfuif399JDSgmRD8dLT8zsd32P"

### domain for your rundeck server.

DOMAIN="domain.com"

### hostnames of the rundeck servers

SERVER="server01"

# reads from the $rdjobs file and assigns to $RDJARRAY

declare -a rdjobs

# Load file into array.
let i=0
while IFS=$'\n' read -r line_data; do
    rdjobs[i]="${line_data}"
    ((++i))
done < rdjobs.txt

# Make array into a comma-delimited string and load into a var.

rdcsv=$(IFS=,; echo "${rdjobs[*]}")

echo job string is $rdcsv.
echo ""
echo ""
while true; do
    read -p "Do you wish to (E)nable or (S)top these jobs? (type E or S) to continue " es
    case $es in
        
        [Ee]* ) curl --insecure \
                -H "X-RunDeck-Auth-Token:$TOKEN" \
                -H "Content-Type: application/json" \
                --data "{"ids": [ "$rdcsv"]}" \
                -X POST "https://$SERVER.$DOMAIN/api/21/jobs/execution/enable"
                exit 0;;

        [Ss]* ) curl --insecure \
                -H "X-RunDeck-Auth-Token:$TOKEN" \
                -H "Content-Type: application/json" \
                --data "{"ids": [ "$rdcsv"]}" \
                -X POST "https://$SERVER.$DOMAIN/api/21/jobs/execution/disable"
                exit 0;;

        * ) echo "Please choose either E or S, or ctrl+c to break";;
       
    esac
done	

}
