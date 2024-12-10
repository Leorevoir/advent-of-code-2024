#!/usr/bin/env bash

readarray -t parsed < data.txt


cols=${#parsed[@]}
rows=${#parsed[0]}

declare -A antennas
declare -a antinodes

BASE_REGEX="(-?[0-9]+),(-?[0-9]+)"

function get_result()
{
    local x=0
    local result=0

    for i in ${antinodes[@]}; do

        if [[ $i =~ $BASE_REGEX ]]; then
            x[0]=${BASH_REMATCH[1]}
            x[1]=${BASH_REMATCH[2]}

            if [[ ${x[0]} -ge 0 && ${x[0]} -lt $cols && ${x[1]} -ge 0 && ${x[1]} -lt ${#parsed[${x[0]}]} ]]; then
                result=$((result+1))
            fi

        fi

    done

    echo "result: $result"
}

function pair_exists()
{
    local x0="$1"
    local x1="$2"

    [[ " ${antinodes[@]} " =~ " $x0,$x1 " ]]
}

function compute_rules()
{
    local i=0
    local j=0

    # get x and y integers from $i sring
    if [[ $1 =~ $BASE_REGEX ]]; then
        i[0]=${BASH_REMATCH[1]}
        i[1]=${BASH_REMATCH[2]}
    fi
    # get x and y integers from $j sring
    if [[ $2 =~ $BASE_REGEX ]]; then
        j[0]=${BASH_REMATCH[1]}
        j[1]=${BASH_REMATCH[2]}
    fi

    local dx=$(( ${i[0]}-${j[0]} ))
    local dy=$(( ${i[1]}-${j[1]} ))
    local nx=$(( ${j[0]}-$dx ))
    local ny=$(( ${j[1]}-$dy ))

    if ! pair_exists "$nx" "$ny"; then
        antinodes+=("$nx,$ny")
    fi
}

# iterates cols/rows (x,y)
for ((x=0; x<cols; x++)); do
    for ((y=0; y<rows; y++)); do
        
        # potential array hash = current char
        h=${parsed[$x]:$y:1}

        if [[ "$h" != "." ]]; then

            # append positions
            antennas["$h"]+="$x,$y "

        fi

    done
done


# iterate antennas hash key
for key in "${!antennas[@]}"; do

    # split every antennas[key] values at ' ' to "create" a list of value
    mapfile -t values < <(echo ${antennas[$key]})

    for i in $values; do
        for j in $values; do

            if [ $i == $j ]; then
                continue
            fi

            compute_rules $i $j

        done
    done

done

get_result
