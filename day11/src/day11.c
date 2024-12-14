/*
** EPITECH PROJECT, 2024
** advent-of-code-2024
** File description:
** day11
*/

#include "aoc.h"

static unsigned long long *get_stones_base(const char *filename, size_t *size)
{
    FILE *file = fopen(filename, "r");
    unsigned long long *stones = NULL;
    unsigned long long *tmp = NULL;
    unsigned long long value = 0;

    *size = 0;
    while (fscanf(file, "%llu", &value) == 1) {
        tmp = realloc(stones, (*size + 1) * sizeof(unsigned long long));
        stones = tmp;
        stones[*size] = value;
        (*size)++;
    }
    fclose(file);
    return stones;
}

unsigned long long blink(unsigned long long stone, int n)
{
    unsigned int len = 0;
    unsigned int mid = 0;
    unsigned long long first = 0;
    unsigned long long second = 0;

    if (n == 0)
        return 1;
    if (stone == 0)
        return blink(1, n - 1);
    len = count_digits(stone);
    if (len % 2 == 0) {
        mid = len / 2;
        first = stone / power10(mid);
        second = stone % power10(mid);
        return (blink(first, n - 1) + blink(second, n - 1));
    }
    return blink(stone * 2024, n - 1);
}

static unsigned long long blink_n_times(stones_t *stones, const int n)
{
    unsigned long long result = 0;

    for (size_t i = 0; i < stones->size; i++) {
        result += blink(stones->values[i], n);
    }
    return result;
}

int main(__attribute__((unused))int argc, __attribute__((unused))char **argv)
{
    stones_t *stones = malloc(sizeof(stones_t));

    stones->size = 0;
    stones->values = get_stones_base("data.txt", &stones->size);
    printf("%llu\n", blink_n_times(stones, 25));
    free(stones->values);
    free(stones);
    return SUCCESS;
}

