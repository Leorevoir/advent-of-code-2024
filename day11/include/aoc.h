/*
** EPITECH PROJECT, 2024
** Pokemon
** File description:
** aoc header
*/

#ifndef AOC_H_
    #define AOC_H_

    #include <stdio.h>
    #include <stdlib.h>
    #include <unistd.h>
    #include <string.h>

    #define SUCCESS 0
    #define ERROR 84

    typedef struct stones_s {
        unsigned long long *values;
        size_t size;
    } stones_t;

    inline unsigned int count_digits(unsigned long long num)
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

unsigned int count_digits(unsigned long long num);
unsigned long long power10(unsigned int exp);

#endif /* AOC_H_ */
