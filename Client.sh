send() {
    nc $ip 2000
}

receive() {
    nc -l $ip
}

register() {
    echo "-----REGISTER -----"
    read -p "login: " username
    printf "password: "
    read -s password | shasum > password
    
    n=5
    count=$n
    
    while [ $count -ge 2 ]
    do
    password="$(cat password | shasum)"
    ((count--))
    done
    
    password=`cat password`
    data="regist $username $n $password"
    echo $data | send
}

login() {
    echo "-----LOGIN -----"
    read -p "login: " username
    printf "password: "
    read -s password
    
    echo
    
    echo $username | send
    c=$(nc -l $ip 3000)
    
    echo $c
    
    n=5

    if [ $n -gt $c ]
    then
    while [ $n -ge 1 ]
    do
    password="$(cat password | shasum )"
    ((n--))
    done
    else
        echo "Error"
    fi
    
    echo 2
    
    echo "$password" | send 4000
    
    echo 3
}

menu(){
    echo "======  Lab: Shell Programming (BS)  ======"
    echo
    echo "  r   Register"
    echo "  l   Login"
    echo "  q   Quit"
    echo
    
    read -p "your choice: " choice
    
    echo
    
    case "$choice"
        in
            r) register
            ;;
            l) login
            ;;
            q) exit 0
            ;;
            *) echo "false choice"
            ;;
    esac
}

ip=127.0.0.1
while :
do
    menu
    echo
done

