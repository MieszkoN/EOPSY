# #! /bin/sh
name=`basename $0`


error_msg() 
{ 
        echo "$name: error: $1" 1>&2 
}

recursion=false
uppercase=false
lowercase=false
search=""
sed_pattern=''

if test -z "$1"
then
        error_msg "You did not provide any arguments!"
fi

display_help()
{
cat<<EOT 1>&2
  usage:
    $name [-r] [-l|-u] <dir/file names...>
    $name [-r] <sed pattern> <dir/file names...>
  help:
    $name -h
  $name correct syntax examples: 
    $name -r -l DIRECTORY
    $name -r -u directory
  
  $name incorrect syntax example: 
    $name -b
EOT
exit 1;
}

set_option()
{
        if [ "$uppercase" = false ] && [ "$1" = "-l" ] 
        then
                lowercase=true
        elif [ "$lowercase" = false ] && [ "$1" = "-u" ]
        then
                uppercase=true
        else
                echo "You can not use both uppercase and lowercase options!"  
        fi
}


while test "x$1" != "x"
do
        case "$1" in
                -r) 
                        if test -z "$3"
                        then
                                error_msg "You did not provide enough arguments for recursion!"
                        fi
                        recursion=true;;
                -l|-u) 
                        if [ "$recursion" = false ]
                        then
                                if test -z "$2" 
                                then
                                        error_msg "You did not provide enough arguments!"
                                fi
                        fi
                        set_option $1;;
                -h) display_help;;
                -*) error_msg "bad option $1"; exit 1 ;;
                *) 
                        if [ "$recursion" = false ] && [ "$uppercase" = false ] && [ "$lowercase" = false ]
                        then
                                if test -z "$2"
                                then
                                        error_msg "You did not provide enough arguments blablclea!"
                                fi
                        fi
                        break;;
        esac
        shift
done

if [ -n "$1" ] && [ "$uppercase" = false ] && [ "$lowercase" = false ]
then
        sed_pattern="$1"
        shift
fi

while [ "$1" ]
do
        if [ ! -e "$1" ]
        then
                error_msg "$1 is not a file or directory!"
        else
                if [ "$recursion" = true ]
                then
                        search=$(find $1 -depth)
                else
                        search=$(find $1 -maxdepth 0)
                fi
                
                for file in $search
                do
                        temp_name=$(basename "$file")
                        temp_path=$(dirname "$file")
                        temp_pattern=''
                        new_name=''
                        if [ "$uppercase" = true ]
                        then
                                new_name=$(echo -n $temp_name | sed 's/[a-z]/\U&/g')
                        elif [ "$lowercase" = true ] 
                        then
                                new_name=$(echo -n $temp_name | sed 's/[A-Z]/\L&/g')
                        else
                                new_name=$(echo -n $temp_name | sed "$sed_pattern")
                        fi
                        
                        if [ "$temp_name" != "$new_name" ] && [ "$new_name" != '' ]
                        then
                                mv "$file" "${temp_path}/${new_name}"
                        fi
                done
        fi
        shift
done
