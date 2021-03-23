#!/bin/sh
if [ -e test_eopsy ]
then
	rm -r test_eopsy
fi

clear
mkdir test_eopsy
cd test_eopsy
touch aaaaaaaab
touch temp_file.txt
mkdir test*%directo!@$%.c
mkdir directory
touch test-file.txt
cd directory
touch file13241.java
touch filE!@*.txt
mkdir testdirectory
cd testdirectory
touch test.txt
touch modify.sh
cd ..
cd ..
cd ..

echo "----------------------------Created Directory----------------------------"
find test_eopsy
echo "\n--------------------------Help-----------------------------------"
./modify.sh -h
echo "\n--------------------------Bad option-------------------------------"
./modify.sh -p
echo "\n--------------------------Too few arguments-------------------------------"
./modify.sh -l
echo "\n--------------------------Too few arguments recursion-------------------------------"
./modify.sh -r -u
echo "\n--------------------------File does not exist-------------------------------"
./modify.sh -r -u Abcdefghijk
echo "\n--------------------------Recursion uppercase-------------------------------"
./modify.sh -r -u test_eopsy
find TEST_EOPSY
echo "\n--------------------------Recursion lowercase-------------------------------"
./modify.sh -r -l TEST_EOPSY
find test_eopsy
echo "\n--------------------------Upercase files and directories-------------------------------"
./modify.sh -u test_eopsy/temp_file.txt test_eopsy/directory/testdirectory/modify.sh
find test_eopsy
echo "\n-------------------------Lowercase file------------------------------"
./modify.sh -l test_eopsy/TEMP_FILE.TXT test_eopsy/directory/testdirectory/MODIFY.SH
find test_eopsy
echo "\n--------------------------sed pattern with recursion------------------------------"
./modify.sh -r s/dir[a-z]*/123/ test_eopsy
find test_eopsy
echo "\n--------------------------sed pattern without recursion------------------------------"
./modify.sh s/a*b/Great/ test_eopsy/aaaaaaaab
find test_eopsy