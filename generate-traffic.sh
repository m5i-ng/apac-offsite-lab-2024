#!/bin/bash

# URL="http://localhost:8080/notes"
METHOD=("GET" "POST" "PUT" "DELETE" "LIST")
NOTES_APP=$NOTES_APP
URL="http://${NOTES_APP_HOST:-localhost}:8080/notes"

# https://www.grammarly.com/blog/14-of-the-longest-words-in-english/
# https://en.wikipedia.org/wiki/Longest_word_in_English
LONG_WORDS=(
    "Llanfairpwllgwyngyllgogerychwyrndrobwllllantysiliogogogoch"
    "Chargoggagoggmanchauggagoggchaubunangungamaugg"
    "Mamungkukumpurangkuntjunya"
    "Pseudopseudohypoparathyroidism"
    "Pneumonoultramicroscopicsilicovolcanoconiosis"
    "Floccinaucinihilipilification"
    "Supercalifragilisticexpialidocious"
    "Honorificabilitudinitatibus"
    "Incomprehensibilities"
)

get_random_word() {
    local array=("$@")
    echo "${array[RANDOM % ${#array[@]}]}"
}


for i in {1..3600}
do
    m=${METHOD[RANDOM % ${#METHOD[@]}]}
    randword=$(get_random_word "${LONG_WORDS[@]}")
    randchar_length=$((80 + RANDOM % 51))
    randchar=$(tr -dc A-Za-z0-9 </dev/urandom | head -c $randchar_length)
    rand_id=$((RANDOM % $i))
    randstring="${randword}-${randchar}"
    
    case $m in
        "GET")
            echo "Executing: curl -X $m '${URL}?id=$rand_id'"
            result=$(curl -s -X $m "${URL}?id=$rand_id")
            ;;
        "POST")
            echo "Executing: curl -X $m '${URL}?desc=$randstring'"
            result=$(curl -s -X $m "${URL}?desc=$randstring")
            ;;
        "PUT")
            echo "Executing: curl -X $m '${URL}?id=$rand_id&desc=$randstring'"
            result=$(curl -s -X $m "${URL}?id=$rand_id&desc=$randstring")
            ;;
        "DELETE")
            echo "Executing: curl -X $m '${URL}?id=$rand_id'"
            result=$(curl -s -X $m "${URL}?id=$rand_id")
            ;;
        "LIST")
            echo "Executing: curl -X GET '${URL}'"
            result=$(curl -s -X GET "${URL}")
            ;;
    esac

    # Output the result
    echo "Response: ${result}"
    echo ""
    
    sleep 3
done

