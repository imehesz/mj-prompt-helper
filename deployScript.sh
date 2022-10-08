#!/bin/bash

PRODUSER="";
PRODSERVER=""
PRODPORT=""
SOURCEFOLDER=""
PRODDESTINATION=""

ERRORSTRING="Error. Please make sure you've indicated correct parameters";

if [ $# -eq 0 ]
    then
        echo $ERRORSTRING;
elif [ $1 == "live" ]
    then
        if [[ -z $2 ]]
            then
                echo "Running dry-run"
                rsync --dry-run -az --force --delete --progress --exclude-from=rsync_exclude.txt -e "ssh -p$PRODPORT" $SOURCEFOLDER $PRODUSER@$PRODSERVER:$PRODDESTINATION
        elif [ $2 == "go" ]
            then
                echo "Running actual deploy"
                
                INDEXFILE="./public/index.html"
                TIMESTAMP=`date +%s`
                `sed -i "s/{{version}}/$TIMESTAMP/g" $INDEXFILE`
                
                rsync -az --force --delete --progress --exclude-from=rsync_exclude.txt -e "ssh -p$PRODPORT" $SOURCEFOLDER $PRODUSER@$PRODSERVER:$PRODDESTINATION
                `git checkout $INDEXFILE`
        else
            echo $ERRORSTRING;
        fi
fi