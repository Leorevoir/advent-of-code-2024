#!/usr/bin/env bash

readarray -t parsed < data.txt


cols=${#parsed[@]}
rows=${#parsed[0]}

declare -A antennas
declare -a antinodes

FIRST_FREQ="([0-9]+)"

function compute_rules()
{
    local i=0
    local j=0

    # get x and y integers from $i sring
    if [[ $1 =~ ([0-9]+),([0-9]+) ]]; then
        i[0]=${BASH_REMATCH[1]}
        i[1]=${BASH_REMATCH[2]}
    fi
    # get x and y integers from $j sring
    if [[ $2 =~ ([0-9]+),([0-9]+) ]]; then
        j[0]=${BASH_REMATCH[1]}
        j[1]=${BASH_REMATCH[2]}
    fi

    local dx=$(echo "${i[0]}-${j[0]}" | bc)
    local dy=$(echo "${i[1]}-${j[1]}" | bc)
    local nx=$(echo "${j[0]}-${dx}" | bc)
    local ny=$(echo "${j[1]}-${dy}" | bc)

    antinodes+=("$nx,$ny")
}

# iterates cols/rows (x,y)
for ((x=0; x<cols; x++)); do
    for ((y=0; y<rows; y++)); do
        
        # potential array hash = current char
        h=${parsed[$x]:$y:1}

        if [[ "$h" != "." ]]; then

            # if frequence doesnt yet exists -> create it
            if [[ -z "${antennas[$h]}" ]]; then
                antennas["$h"]=""
           fi

            # append positions
            antennas["$h"]+="$x,$y "

        fi

    done
done


# iterate antennas hash key
for key in "${!antennas[@]}"; do

    # split every antennas[key] values at ' ' to "create" a list of value
    values=$(echo ${antennas[$key]} | tr " " "\n")

    for i in $values; do
        for j in $values; do

            if [ $i == $j ]; then
                continue
            fi

            compute_rules $i $j

        done
    done

done

