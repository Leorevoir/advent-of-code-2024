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

unsigned long long blink_with_cache(
    unsigned long long stone, int n, cache_entry_t **cache, size_t cache_size)
{
    unsigned long long cached_value = lookup_cache(cache, cache_size, stone, n);
    unsigned long long result = 0;
    unsigned long long first = 0;
    unsigned long long second = 0;
    unsigned int len = 0;
    unsigned int mid = 0;

    if (cached_value)
        return cached_value;
    if (n == 0)
        result = 1;
    else if (stone == 0)
        result = blink_with_cache(1, n - 1, cache, cache_size);
    else {
        len = count_digits(stone);
        if (len % 2 == 0) {
            mid = len / 2;
            first = stone / power10(mid);
            second = stone % power10(mid);
            result = (blink_with_cache(first, n - 1, cache, cache_size) + 
                      blink_with_cache(second, n - 1, cache, cache_size));
        } else
            result = blink_with_cache(stone * 2024, n - 1, cache, cache_size);
    }
    insert_cache(cache, cache_size, stone, n, result);
    return result;
}

static unsigned long long blink_n_times_with_cache(
    stones_t *stones, const int n, cache_entry_t **cache, size_t cache_size)
{
    unsigned long long result = 0;
    for (size_t i = 0; i < stones->size; i++) {
        result += blink_with_cache(stones->values[i], n, cache, cache_size);
    }
    return result;
}

int main(__attribute__((unused))int argc, __attribute__((unused))char **argv)
{
    stones_t *stones = malloc(sizeof(stones_t));
    size_t cache_size = 1024;
    cache_entry_t **cache = calloc(cache_size, sizeof(cache_entry_t*));
    
    stones->size = 0;
    stones->values = get_stones_base("data.txt", &stones->size);
    printf("part1: %llu\n", blink_n_times_with_cache(stones, 25, cache, cache_size));
    printf("part2: %llu\n", blink_n_times_with_cache(stones, 75, cache, cache_size));
    free_cache(cache, cache_size);
    free(stones->values);
    free(stones);
    return SUCCESS;
}
