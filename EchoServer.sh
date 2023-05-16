send() {
    nc $ip 3000
}

receive() {
    variable=$(nc -l $ip 2000)
    echo $variable
    echo $variable | send
}

ip=127.0.0.1
while :
do
    receive
done







#/Users/vuxlamm/Desktop/HDA/2.Semester/Betriebssysteme/Praktikum/5.Praktikum BS/BS_5
