send() {
    nc $ip $1
}

receive() {
    nc -l $ip $1
}

store() {
    c=1
    echo $2 $3 $c > $1
    cat $1
}

login() {
    file=$(find /Users/vuxlamm/desktop/Shell -name $1) 1>&2
    data=$(cat $file)
    IFS=' '
    read -a array <<< "$data"
    echo "${array[2]}" | send 3000
    
    pc=$(nc -l $ip 4000)
    echo $pc
    
    if [ $pc -eq ${array[1]} ]
    then
        ${array[2]}=$((${array[2]} + 1))
        echo "Logged in"
    else
        echo "Not identified"
    fi
    
    echo $pc
}

manage() {
    if [ $1 == "regist" ]
    then
        store $2 $3 $4
    else
        login $1
    fi
}

getData() {
    data=$(receive $1)
    manage $data
}

ip=127.0.0.1
while :
do
    getData 2000
done
