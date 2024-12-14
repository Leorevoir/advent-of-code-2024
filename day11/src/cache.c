/*
** EPITECH PROJECT, 2024
** advent-of-code-2024
** File description:
** cache
*/

#include "aoc.h"

static size_t hash_function(unsigned long long stone, int n, size_t size)
{
    return (stone + (unsigned long long)n) % size;
}

unsigned long long lookup_cache(
    cache_entry_t **cache, size_t cache_size, unsigned long long stone, int n)
{
    size_t index = hash_function(stone, n, cache_size);
    cache_entry_t *entry = cache[index];
    
    while (entry) {
        if (entry->key.stone == stone && entry->key.n == n) {
            return entry->value;
        }
        entry = entry->next;
    }
    return 0;
}

void insert_cache(
    cache_entry_t **cache, size_t cache_size,
    unsigned long long stone, int n, unsigned long long value)
{
    size_t index = hash_function(stone, n, cache_size);
    cache_entry_t *new_entry = malloc(sizeof(cache_entry_t));
    
    new_entry->key.stone = stone;
    new_entry->key.n = n;
    new_entry->value = value;
    new_entry->next = cache[index];
    cache[index] = new_entry;
}

void free_cache(cache_entry_t **cache, size_t cache_size)
{
    cache_entry_t *entry = NULL;
    cache_entry_t *next = NULL;

    for (size_t i = 0; i < cache_size; i++) {
        entry = cache[i];
        while (entry) {
            next = entry->next;
            free(entry);
            entry = next;
        }
    }
    free(cache);
}
