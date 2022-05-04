# Trace.sh
This is all about bash scripting. with this script you can run commands to control files. 

# Install Requirements manual


```#!/bin/sh

     ,    ,    /\   /\
    /( /\ )\  _\ \_/ /_       trace.sh the tools of manipulation xD
    |\_||_/| < \_   _/ >
    \______/  \|0   0|/       Version :: 0.0.2v
      _\/_   _(_  ^  _)_      Realsed :: 2022/03/05
     ( () ) /`\|V"""V|/`\
       {}   \  \_____/  /
       ()   /\   )=(   /\
    da {}  /  \_/\=/\_/  \ 

    Linux:
        sudo apt install python3
        pip install matplotlib OR pip3 install matplotlib

    Windows:
       1. install git bash  OR  Cygwin
       2. install graphic from https://www.python.org/downloads/
       3. $ pip3 install matplotlib
    Mac: 
       1. need to install brew
       2. brew install python
       3. python3 -m ensurepip --upgrade
       4. pip install matplotlib OR pip3 install matplotlib
```
# command line arguments

`$ trace.sh: [-h] [-r] [-f] [-d] [-a] [-m] [-c] [-u] [-s] argument...`

Where, trace.sh is a shell script file and argument.. are list of arguments.


1. The `-h` variable
To display detailed help from a text file.

2. The `-f` variable
To search a directory by name then display names of his files 

3. The `-d` variable
To search a directory by name then display names of his folders.

4. The `-a` variable
Allows to write in the date_journal file the date of its last access.

5. The `-m` variable
Allows to write in the modif_journal file the date of its last modification.

6. The `-c` variable
To show number of folders and files and save to file count

7. The `-u` variable
To trace the owner name to the access header of a folder

8. The `-s` variable
To show show file statistics how many files and folders

8. The `-r` variable
To install requirements script

# Examples


```#!/bin/sh

	$ trace.sh -f (only directory name)..
	$ trace.sh -d (only directory name)..
	$ trace.sh -a (file path)..
	$ trace.sh -m (file path)..
	$ trace.sh -c (directory path)..
	$ trace.sh -u (directory path)..
	$ trace.sh -s (directory path)..
	$ trace.sh -r

```