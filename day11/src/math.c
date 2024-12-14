/*
** EPITECH PROJECT, 2024
** advent-of-code-2024
** File description:
** math
*/

#include "aoc.h"

unsigned int count_digits(unsigned long long num)
{
    unsigned int count = 0;

    if (num == 0)
        return 1;
    while (num > 0) {
        count++;
        num /= 10;
    }
    return count;
}

unsigned long long power10(unsigned int exp)
{
    unsigned long long result = 1;

    for (unsigned int i = 0; i < exp; i++) {
        result *= 10;
    }
    return result;
}
