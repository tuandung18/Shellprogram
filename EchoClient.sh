receive() {
    nc -l $ip 3000
}

send() {
    nc $ip 2000
}

readInput() {
    i=1
    j=$#
    
    while [ $i -le $j ]
    do
        echo "$1"
        i=$((i + 1))
        shift 1
    done
    
    echo
}

ip=$1
readInput "$@" | send $ip 2000

receive
