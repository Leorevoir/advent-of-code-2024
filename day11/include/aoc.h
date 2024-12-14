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

typedef struct cache_key_s {
    unsigned long long stone;
    int n;
} cache_key_t;

typedef struct cache_entry_s {
    cache_key_t key;
    unsigned long long value;
    struct cache_entry_s *next;
} cache_entry_t;

/* math */
unsigned int count_digits(unsigned long long num);
unsigned long long power10(unsigned int exp);

/* cache */
void insert_cache(
    cache_entry_t **cache, size_t cache_size,
    unsigned long long stone, int n, unsigned long long value);
unsigned long long lookup_cache(
    cache_entry_t **cache, size_t cache_size, unsigned long long stone, int n);
void free_cache(cache_entry_t **cache, size_t cache_size);

#endif /* AOC_H_ */
