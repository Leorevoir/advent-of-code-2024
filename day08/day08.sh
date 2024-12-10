#!/usr/bin/env bash

readarray -t parsed < data.txt

cols=${#parsed[@]}
rows=${#parsed[0]}

declare -A antennas
declare -a antinodes
declare -a p2_antinodes

BASE_REGEX="(-?[0-9]+),(-?[0-9]+)"

function is_inbounds()
{
    local x="$1"
    local y="$2"

    if [[ $x -ge 0 && $x -lt $cols && $y -ge 0 && $y -lt ${#parsed[$x]} ]]; then
        return 0
    fi

    return 1
}

function pair_exists()
{
    local x0="$2"
    local x1="$3"

    case "$1" in
        1) cmp=${antinodes[@]}
        ;;
        *) cmp=${p2_antinodes[@]}
        ;;
    esac

    [[ " $cmp " =~ " $x0,$x1 " ]]
}

function part2_compute_rules()
{
    local dx=$1
    local dy=$2
    local x=$3
    local y=$4
    local op=$5

    while is_inbounds "$x" "$y"; do
        if ! pair_exists 0 "$x" "$y"; then
            p2_antinodes+=("$x,$y")
        fi
        x=$(echo "$x $op $dx" | bc)
        y=$(echo "$y $op $dy" | bc)
    done
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

    if ! pair_exists 1 "$nx" "$ny" && is_inbounds "$nx" "$ny"; then
        antinodes+=("$nx,$ny")
    fi

    #part2
    local ndx=$(( ${j[0]}-${i[0]} ))
    local ndy=$(( ${j[1]}-${i[1]} ))
    part2_compute_rules "$ndx" "$ndy" "${i[0]}" "${i[1]}" "-"
    part2_compute_rules "$ndx" "$ndy" "${i[0]}" "${i[1]}" "+"
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

echo "part1: ${#antinodes[@]}"
echo "part2: ${#p2_antinodes[@]}"
