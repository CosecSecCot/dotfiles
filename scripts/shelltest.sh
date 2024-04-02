#!/bin/bash

echo Hello World!

# Variables

VARIABLE="deeznuts"

# echo "What is your first name?"
# read FIRST_NAME
# echo "What is your last name?"
# read LAST_NAME

# echo "Hello $FIRST_NAME $LAST_NAME"


# Positional Arguments
echo "so the arguments you gave are: $1 $2" 


# Piping
echo "Hello World, how are you" | grep "how"

# Output redirection

echo "I will cum first" > ./txtfile.txt  # Overwrites output to ./txtfile.txt
echo "hello world" >> ./txtfile.txt  # Appends output to ./txtfile.txt


# if statements
if [ ${1:l} = deeznuts ]; then
    echo "sugondeeznuts"
elif [ ${1:l} = help ]; then
    echo "just type deeznuts"
else
    echo "nahh bruh u need help, type help"
fi


# Arrays
DEEZ_ARR=(one two three four five)
echo $DEEZ_ARR
echo ${DEEZ_ARR[2]}
echo ${DEEZ_ARR[@]}


for item in ${DEEZ_ARR[@]}; do
    echo -n $item | wc -c  # -n flag to ignore all newline characters
done


# functions

showuptime() {
    # if there was a global variable named up, this function would have
    # modified it without the local keyword

    local up=$(uptime | cut -c4-)
    cat << EOF
-----
uptime: $up
-----
EOF
}
showuptime

newfun() {
    local output="Hello there, function arg: $1"
    echo $output
}

newfun "dslkf"
newfun $1
