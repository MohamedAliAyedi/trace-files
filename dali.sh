#!/bin/bash

show_usage()
{
   echo "trace.sh: [-h] [-T] [-t] [-n] [-N] [-d] [-m] [-s] chemin.."
}

help(){
    show_usage
    cat trace.help.txt
}

AfficheFile(){
    dirName=$(find ./ -name $1)
    if [ -d "$dirName" ]; then
        Files=$( ls -l $dirName |  grep '^-' | cut -f 8-8 -d ' ' >> nomdefichier_journal ) 
        echo "Extract name of files done."
    else 
        echo "$dirName it is not dir."
    fi
}

AfficheDirectory(){
    dirName=$(find ./ -name $1)
    if [ -d "$1" ]; then

        Dirs=$( find $1 -maxdepth 1 -mindepth 1 -type d >> nomdedossier_journal) 
        echo "Extract name of Directorys done."
    else 
        echo "$1 it is not dir."
    fi
}

NB() {
    if [ -d "$1" ]; then
     count=$( ls $1 | wc -l ) 
     echo ""
     echo "#### ( $1 ) has "$count" Files ####"
     echo  "( $1 ) has "$count" Files" >> count
    else 
        echo "$1 it is not dir."
    fi
 
}

DirectoryUser(){
    if [ -d "$1" ]; then
        access=$( ls -la $1 | cut -f 1-1 -d ' ' | sed -n '2p' )
        echo "Directory $1 has ( "$access" )"
    else 
        echo "$1 it is not dir."
    fi

}

datemodif() {
    if [ -f "$1" ]; then
        dateModif=$( stat -c '%y' $1 )
        echo $dateModif >> date_journal
        echo "Date Modify has been successfully saved in modif_journal"
    else 
        echo "$1 it is not file."
    fi
}

dateAcess() {
    if [ -f "$1" ]; then
        dateAcessf=$( stat -c '%x' $1 )
        echo $dateAcessf >> date_journal
        echo "Date Access has been successfully saved in date_journal"
    else 
        echo "$1 it is not file."
    fi
}

stat() {
    if [ -d "$1" ]; then
        folderNumbers=$(find $1 -type d | wc -l)
        FilesNumbers=$(find $1 -type f | wc -l)
        echo "Statistics of Directory $1"
        python plt.py $folderNumbers $FilesNumbers
    else 
        echo "$1 it is not dir."
    fi
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################


if (( $# == 0 ))
then
  echo "trace.sh run with -h for help"
else
        while getopts ":hf:d:a:m:c:u:s:": options; do

                case "${options}" in
                        h) help ;;
                        f) AfficheFile ${OPTARG} ;;
                        d) AfficheDirectory ${OPTARG} ;;
                        a) dateAcess ${OPTARG} ;;
                        m) datemodif ${OPTARG} ;;
                        c) NB ${OPTARG} ;;
                        u) DirectoryUser ${OPTARG} ;;
                        s) stat ${OPTARG} ;;
                esac
        done
fi
exit 1
