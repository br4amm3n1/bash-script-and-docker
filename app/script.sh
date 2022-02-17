#!/bin/bash
index=1
  
echo -e "Author: Albert Minkh \n
Title: FileINFO \n
Description: Display information about an existing file\n\n"
echo "//////////////////////////"
echo "//////////////////////////"
echo -e "Launch program..."
echo "//////////////////////////"
echo "//////////////////////////"

#The program cycle
while [[ $index > 0 ]]
do

  counter=1
  cd /home

#Catalog name choice
  while [[ $counter > 0 ]]
  do

    echo -e "\n\nВ каком каталоге Вы хотите искать?"

    uniq=-1
  
    i=0
  
#Checking the number of directories
  for d in $(find . -maxdepth 1 -type d)
  do
    let "i=i+1"
  done

  let "i=i-1"

  echo -e "\nСписок каталогов ($i с учетом скрытых): "
  
  if [[ $i > 0 ]]
    then

    for catalogs in $(ls -d */)
    do
    
      let "uniq=uniq+1"
      echo -e "$uniq $catalogs"

    done
  
  
  if [[ $uniq < 0 ]]
  then
   
    echo -e "\nКаталогов в данном каталоге не существует."
   
    let "counter=counter-1"
   
  else
    
    array=( $(ls -d */) )
    #echo $uniq
    j=1
    while [[ $j > 0 ]]
    do
      echo "Введите номер каталога: "
      read num
     
      re="^[0-9]+$"
      if ! [[ $num =~ $re ]]
      then
        echo "ERR: не является числом." >&2
      elif [[ $num > $uniq ]]
      then
        echo "Каталог с таким номером не существует."
      else
        let "j=j-1"
      fi
      
    done
    
    cd ./${array[num]}

    echo "Продолжить выбор? (y/n): "

    cntr=1
    while [[ $cntr > 0 ]]
    do
 
      read answer

      if [[ "$answer" = "n" ]] || [[ "$answer" = "N" ]]
      then

        let "counter=counter-1"
        let "cntr=cntr-1"
    
      elif [[ $answer = "y" ]] || [[ $answer = "Y" ]]
      then
    
       echo "OK"
       let "cntr=cntr-1"
    
      fi
  
    done
   
   fi
    else
   
     let "counter=counter-1"
   
    fi
#

 done

uniq2=-1

echo -e "\nСодержимое текущего каталога:"

for files in $(ls)
do
 let "uniq2=uniq2+1"
 echo -e "$uniq2 $files"
done

if [[ $uniq2 != -1 ]]
then
 echo -e "\nВАЖНО: если у файлов отсутствуют расширения, значит это каталоги. В таком случае введите - again. Если хотите завершить работу скрипта - exit.\nВведите название файла (учитывая расширение. К примеру: text.txt):"
 read filename

 if [[ $filename = "again" ]]
 then
 
   let "index=index-1"
   cd /home/Documents
   exec "$0"
   
 elif [[ $filename = "exit" ]]
 then
  exit 0
 else
  
  stat --printf=" File name: %n\nFile type: %F\n File size: \
  %s byte\nFile owner: %U\nAccess rights: %A\nData modify: %y\n" $filename
  
  echo -e "\nХотите начать заново? (y/n)"
  read answ 
  
  if [[ $answ = "y" ]]
  then

   cd /home/Documents
   exec "$0"
 
  elif [[ "$answ" = "n" ]]
  then

   exit 0
 
  fi
  
 fi
  
else
  
  echo -e "\nХотите начать заново? (y/n)"
  read answ 
  
  if [[ $answ = "y" ]]
  then

   cd /home/Documents
   exec "$0"
 
  elif [[ "$answ" = "n" ]]
  then

   exit 0
 
  fi

 fi


done