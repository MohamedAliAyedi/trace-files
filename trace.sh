#!/bin/bash

show_usage()
{
   echo "trace.sh: [-h] [-r] [-f] [-d] [-a] [-m] [-c] [-u] [-s] chemin.."
}

help(){
    show_usage
    cat trace.help
}

AfficheFile(){
    dirName=$(find ~/Desktop -name $1)
    if [ -d "$dirName" ]; then
        echo "------------------------" >> nomdefichier_journal
        echo "$dirName" >> nomdefichier_journal
        Files=$( ls -l $dirName |  grep '^-' | rev | cut -d ' ' -f '1' | rev >> nomdefichier_journal )
        echo "------------------------" >> nomdefichier_journal
        echo "Extract name of files done."
    else
        echo "$dirName it is not dir."
    fi
}

AfficheDirectory(){
    dirName=$(find ~/Desktop -name $1)
    if [ -d "$1" ]; then
        echo "------------------------" >> nomdedossier_journal
        echo "$dirName" >> nomdedossier_journal
        Dirs=$( ls -l $dirName |  grep '^d' | rev | cut -d ' ' -f '1' | rev >> nomdedossier_journal)
        echo "------------------------" >> nomdedossier_journal
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
        echo "Directory $1 has ( "$access" | $(stat -c '%a' $1 ) )"
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
        python plt.py $(($folderNumbers - 1)) $FilesNumbers
    else 
        echo "$1 it is not dir."
    fi
}

checkMachineVersion() {
    unameOut="$(uname -s)"
    case "${unameOut}" in
        Linux*)     machine="Linux";;
        Darwin*)    machine="Mac";;
        CYGWIN*)    machine="Windows";;
        MINGW*)     machine="Windows";;
    esac
    echo ${machine}
}

installReq() {
    checkMachineVersion
    if [[ "$machine" == "Linux" ]]; then
        if ! hash python; then
            echo "python is not installed"
            sudo apt install python3
            sudo pip install matplotlib 
        else 
            echo "python is installed"
            if python -c "import matplotlib" &> /dev/null; then
                echo 'modules is already installed in python3'
                echo ''
                echo '~~~ All good you can now full script enjoy ~~~'
            else
                echo 'modules is not installed'
                pip install matplotlib 
                echo '~~~ All good you can now full script enjoy ~~~'
            fi
        fi

    elif [[ "$machine" == "Windows" ]]; then
        if ! hash python; then
            echo "python is not installed"
            echo "Install python via ::  https://www.python.org/downloads/"
        else 
            echo "python is installed"
            if python -c "import matplotlib" &> /dev/null; then
                echo 'modules is already installed in python3'
                echo ''
                echo '~~~All good you can now full script enjoy~~~'
            else
                echo 'modules is not installed'
                pip install matplotlib 
            fi
        fi
    else
        echo "Bower Install python"
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
        while getopts ":hrf:d:a:m:c:u:s:": options; do

                case "${options}" in
                        h) help ;;
                        f) AfficheFile ${OPTARG} ;;
                        d) AfficheDirectory ${OPTARG} ;;
                        a) dateAcess ${OPTARG} ;;
                        m) datemodif ${OPTARG} ;;
                        c) NB ${OPTARG} ;;
                        u) DirectoryUser ${OPTARG} ;;
                        s) stat ${OPTARG} ;;
                        r) installReq
                esac
        done
fi
exit 1
